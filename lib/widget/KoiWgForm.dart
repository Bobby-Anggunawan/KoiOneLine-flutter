import 'package:flutter/material.dart';
import 'package:koi_one_line/koi_one_line.dart';

enum FieldType{
  text,
  password,
  text_multiline,
  widget,
  select
}


/// untuk membuat form dengan mudah.. hanya masukkan label dan data yang diinginkan
class KoiWgForm extends StatefulWidget {
  const KoiWgForm({
    Key? key,
    required this.field,
    this.widgetField = const {},
    this.selectField = const {},
    this.formMaxWidth = 350,
    this.multilineMaxLine = 12,
    this.multilineMinLine = 4,
    required this.onChange
  }) : super(key: key);

  /// fungsi ini tertrigger tiap ada perubahan di salahsatu field
  /// parameternya adalah:
  /// * Map<String, dynamic> data: data dari semua field
  /// * String lastChangedKey: key dari field yang terakhir diubah
  final Function(String lastChangedKey, Map<String, dynamic> data) onChange;

  /// lebar maksimal suatu kolom. Default 350
  final double formMaxWidth;

  /// list dari field yang ada dalam form ini
  /// String adalah nama field dan FieldType ada tipe dari dield ini
  final Map<String, FieldType> field;

  /// menampung daftar widget lain yang dimasukkan ke form ini, misalnya teks atau field custom.
  /// Note, key widget harus sama dengan key yang ditulis di field
  final Map<String, Widget> widgetField;

  /// menampung daftar isi default value dari field select/dropdown
  /// Note, key widget harus sama dengan key yang ditulis di field
  final Map<String, List<String>> selectField;

  final int multilineMaxLine;
  final int multilineMinLine;

  @override
  State<KoiWgForm> createState() => _KoiWgFormState();
}

class _KoiWgFormState extends State<KoiWgForm> {

  Map<String, dynamic> valueToReturn = {};

  @override
  Widget build(BuildContext context) {

    //start-cek apa semua widget yang didaftar di field sudah dimasukkan ke widgetField
    widget.field.forEach((key, value) {
      if(value == FieldType.widget){
        if(widget.widgetField[key] == null){
          throw AssertionError("Widget ${key} belum dimasukkan ke widgetField");
        }
      }
      if(value == FieldType.select){
        if(widget.selectField[key] == null){
          throw AssertionError("Value ${key} belum dimasukkan ke selectField");
        }
      }
    });
    //end---cek apa semua widget yang didaftar di field sudah dimasukkan ke widgetField

    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(context.koiSpacing.large),
        decoration: BoxDecoration(
            color: context.koiThemeColor.surface,
            borderRadius: BorderRadius.circular(context.koiSpacing.large)
        ),
        constraints: BoxConstraints(
            maxWidth: widget.formMaxWidth
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: List<Widget>.generate(widget.field.length, (index){
            if(widget.field.values.toList()[index] == FieldType.text){
              return TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: widget.field.keys.toList()[index]
                ),
                onChanged: (text){
                  valueToReturn[widget.field.keys.toList()[index]] = text;
                  widget.onChange(widget.field.keys.toList()[index], valueToReturn);
                },
              );
            }
            else if(widget.field.values.toList()[index] == FieldType.text_multiline){
              return TextField(
                keyboardType: TextInputType.multiline,
                minLines: widget.multilineMinLine,
                maxLines: widget.multilineMaxLine,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: widget.field.keys.toList()[index]
                ),
                onChanged: (text){
                  valueToReturn[widget.field.keys.toList()[index]] = text;
                  widget.onChange(widget.field.keys.toList()[index], valueToReturn);
                },
              );
            }
            else if(widget.field.values.toList()[index] == FieldType.password){
              return _PasswordField(
                label: widget.field.keys.toList()[index],
                onEdit: (newText){
                  valueToReturn[widget.field.keys.toList()[index]] = newText;
                  widget.onChange(widget.field.keys.toList()[index], valueToReturn);
                },
              );
            }
            else if(widget.field.values.toList()[index] == FieldType.widget){
              return widget.widgetField[widget.field.keys.toList()[index]]!;
            }
            else if(widget.field.values.toList()[index] == FieldType.select){
              return _DropdownField(
                onChange: (selected) {
                  valueToReturn[widget.field.keys.toList()[index]] = selected;
                  widget.onChange(widget.field.keys.toList()[index], valueToReturn);
                }, initialData: widget.selectField[widget.field.keys.toList()[index]]!,
                label: widget.field.keys.toList()[index],
              );
            }
            else{
              throw StateError("FieldType: ${widget.field.values.toList()[index].name} belum diimplementasikan");
            }
          }).koiAddBetweenElement(
              SizedBox(height: context.koiSpacing.large,)
          ),
        ),
      ),
    );
  }
}


class _PasswordField extends StatefulWidget {
  const _PasswordField({Key? key, required this.onEdit, required this.label}) : super(key: key);

  final Function(String) onEdit;
  final String label;

  @override
  State<_PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<_PasswordField> {

  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: widget.onEdit,
      obscureText: obscureText,
      decoration: InputDecoration(
          labelText: widget.label,
          border: OutlineInputBorder(),
          suffixIcon: IconButton(
            icon: Icon(obscureText ? Icons.visibility: Icons.visibility_off),
            onPressed: () {
              setState(() {
                obscureText = !obscureText;
              });
            },
          )
      ),
    );
  }
}

class _DropdownField extends StatefulWidget {
  const _DropdownField({Key? key, required this.onChange, required this.initialData, required this.label}) : super(key: key);

  final Function(String?) onChange;
  final List<String> initialData;
  final String label;

  @override
  State<_DropdownField> createState() => _DropdownFieldState();
}

class _DropdownFieldState extends State<_DropdownField> {
  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
        alignedDropdown: true,
        child: DropdownMenu<String>(
          label: Text(widget.label),
          onSelected: (newText) => widget.onChange(newText),
          dropdownMenuEntries: List.generate(widget.initialData.length, (index){
            return DropdownMenuEntry(
                value: widget.initialData[index],
                label: widget.initialData[index]
            );
          }),
        )
    );
  }
}