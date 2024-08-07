import 'package:flutter/material.dart';
import 'package:koi_one_line/koi_one_line.dart';
import '../widget/KoiWgForm.dart';

/// page untuk mempermudah membuat form dengan cepat. Dapat digunakan untuk membuat page login
@Deprecated('Use [KoiWgForm]')
class KoiPgForm extends StatefulWidget {
  const KoiPgForm({
    Key? key,
    required this.title,
    this.titleStyle = null,
    required this.field,
    required this.onSubmit,
    this.widgetField = const {},
    this.selectField = const {},
    this.formMaxWidth = 350,
    this.submitButton,
    this.background,
    this.multilineMaxLine = 12,
    this.multilineMinLine = 4
  }) : super(key: key);

  /// title dari form ini
  final String title;
  /// textstyle untuk title
  final TextStyle? titleStyle;
  /// build tombol submit custom
  ///
  /// Parameternya adalah fungsi [onSubmit], yang di expect tertrigger kalau tombol ditekan
  ///
  /// **Contoh**
  ///
  /// submitButton: (submitFunc){
  ///                     return ElevatedButton(onPressed: (){
  ///                       print("ikan asin");
  ///                       submitFunc();
  ///                     }, child: Text("Ikan"));
  ///                   }
  final Widget Function(Function)? submitButton;

  /// lebar maksimal suatu kolom. Default 350
  final double formMaxWidth;

  /// background yang ditampilkan di belakang form
  final Widget? background;

  /// list dari field yang ada dalam form ini
  /// String adalah nama field dan FieldType ada tipe dari dield ini
  final Map<String, FieldType> field;

  /// menampung daftar widget lain yang dimasukkan ke form ini, misalnya teks atau field custom.
  /// Note, key widget harus sama dengan key yang ditulis di field
  final Map<String, Widget> widgetField;

  /// menampung daftar isi default value dari field select/dropdown
  /// Note, key widget harus sama dengan key yang ditulis di field
  final Map<String, List<String>> selectField;

  /// fungsi yang di trigger kalau tombol submit ditekan. Menggunakan parameter [field] yang merupakan isi dari semua filed yang ada
  final void Function(Map<String, dynamic>) onSubmit;

  final int multilineMaxLine;
  final int multilineMinLine;

  @override
  State<KoiPgForm> createState() => _KoiPgFormState();
}

class _KoiPgFormState extends State<KoiPgForm> {


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



    late Widget buildTombolSubmit;
    if(widget.submitButton != null){
      buildTombolSubmit = widget.submitButton!((){
        widget.onSubmit(valueToReturn);
      });
    }
    else{
      buildTombolSubmit = FilledButton(
        onPressed: () {
          widget.onSubmit(valueToReturn);
        },
        child: Text("Submit"),
      );
    }

    return Scaffold(
      body: Stack(
        children: [
          widget.background,
          Padding(
            padding: EdgeInsets.all(context.koiSpacing.autoFromScreenEdge),
            child: Center(
              child: SingleChildScrollView(
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
                    children: <Widget>[
                      Text(
                        widget.title,
                        style: widget.titleStyle ?? context.koiThemeText.headline(),
                      ),
                    ].koiJoinList(
                        List.generate(widget.field.length, (index){
                          if(widget.field.values.toList()[index] == FieldType.text){
                            return TextField(
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: widget.field.keys.toList()[index]
                              ),
                              onChanged: (text){
                                valueToReturn[widget.field.keys.toList()[index]] = text;
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
                              },
                            );
                          }
                          else if(widget.field.values.toList()[index] == FieldType.password){
                            return _PasswordField(
                              label: widget.field.keys.toList()[index],
                              onEdit: (newText){
                                valueToReturn[widget.field.keys.toList()[index]] = newText;
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
                              }, initialData: widget.selectField[widget.field.keys.toList()[index]]!,
                              label: widget.field.keys.toList()[index],
                            );
                          }
                          else{
                            throw StateError("FieldType: ${widget.field.values.toList()[index].name} belum diimplementasikan");
                          }
                        })
                    ).koiJoinList([
                      buildTombolSubmit
                    ]).koiAddBetweenElement(
                        SizedBox(height: context.koiSpacing.large,)
                    ),
                  ),
                ),
              ),
            ),
          )
        ].koiRemoveNull(),
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
