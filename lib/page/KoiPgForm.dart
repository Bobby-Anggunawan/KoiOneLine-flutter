import 'package:flutter/material.dart';
import 'package:koi_one_line/koi_one_line.dart';


enum FieldType{
  text,
  password,
  widget
}

/// page untuk mempermudah membuat form dengan cepat. Dapat digunakan untuk membuat page login
class KoiPgForm extends StatefulWidget {
  const KoiPgForm({
    Key? key,
    required this.title,
    required this.field,
    required this.onSubmit,
    this.widgetField = const {},
    this.formMaxWidth = 350,
    this.submitButton,
    this.background
  }) : super(key: key);

  /// title dari form ini
  final String title;
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

  /// fungsi yang di trigger kalau tombol submit ditekan. Menggunakan parameter [field] yang merupakan isi dari semua filed yang ada
  final void Function(Map<String, dynamic>) onSubmit;

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
        if(widget.widgetField[key] != null){
          throw AssertionError("Widget ${key} belum dimasukkan ke widgetField");
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
          Center(
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
                      style: context.koiThemeText.headline(),
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