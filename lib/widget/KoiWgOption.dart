import 'package:flutter/material.dart';
import 'package:koi_one_line/extension/FromBuildContext.dart';

enum OptionMode{
  MultiSelect,
  SingleSelect
}

/// membuat option daftar tombol yang bisa dipilih
class KoiWgOption<T> extends StatefulWidget {
  const KoiWgOption({Key? key, required this.options, this.maxOptionSelected = -1 >>> 1, required this.optionMode, required this.onOptionChange, this.styleUnselected = null, this.styleSelected = null}) : super(key: key);

  /// masukkan daftar button di sini
  /// - key(dynamic) adalah value dari button ini
  /// - value(Widget) adalah label dari option ini
  final Map<T, Widget> options;

  /// kalau OptionMode.MultiSelect, variable ini membatasi berapa banyak option maksimal yang dapat diselect di widget ini
  /// defaultnya adalah interger terbesar
  final int maxOptionSelected;

  /// saat user memilih option, user hanya bisa memilih 1 option saja atau boleh pilih option lain
  /// buat ini supaya user tahu ini juga bisa dipakai untuk select hanya 1 option saja
  /// kalo tanpa ini nanti user pikir ini hanya bisa multiselect
  final OptionMode optionMode;

  /// fungsi yang dipanggil kalau value berubah(user klik option)
  final Function(List<T>) onOptionChange;

  final ButtonStyle? styleSelected;
  final ButtonStyle? styleUnselected;


  @override
  State<KoiWgOption<T>> createState() => _KoiWgOptionState<T>();
}

class _KoiWgOptionState<T> extends State<KoiWgOption<T>> {

  List<T> selected = [];

  late ButtonStyle styleSelected;
  late ButtonStyle styleUnselected;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    styleSelected = widget.styleSelected ?? ButtonStyle(
      foregroundColor: MaterialStateProperty.resolveWith((states){
        return context.koiThemeColor.onSurface;
      }),
      iconColor: MaterialStateProperty.resolveWith((states){
        return context.koiThemeColor.secondary;
      }),
      backgroundColor: MaterialStateProperty.resolveWith((states){
        return context.koiThemeColor.surface;
      })
    );

    styleUnselected = widget.styleUnselected ?? ButtonStyle(
        foregroundColor: MaterialStateProperty.resolveWith((states){
          return context.koiThemeColor.primary;
        }),
        iconColor: MaterialStateProperty.resolveWith((states){
          return context.koiThemeColor.primary;
        }),
        backgroundColor: MaterialStateProperty.resolveWith((states){
          return context.koiThemeColor.primaryContainer;
        })
    );
  }


  @override
  Widget build(BuildContext context) {

    var ListLabel = widget.options.values.toList();
    var ListValue = widget.options.keys.toList();

    return Wrap(
      spacing: context.koiSpacing.smallest,
      runSpacing: context.koiSpacing.smallest,
      children: List.generate(
          widget.options.length,
          (index){
            return _OptionButton<T>(
              label: ListLabel[index],
              value: ListValue[index],
              styleSelected: styleSelected,
              styleUnselected: styleUnselected,
              onSelect: (T value) {

                if(widget.optionMode == OptionMode.SingleSelect){
                  if(selected.contains(value) == false){
                    selected.clear();
                    selected.add(value);
                  }
                  else{
                    selected.clear();
                  }
                }
                else{
                  if(selected.contains(value)){
                    selected.remove(value);
                  }
                  else{
                    if(selected.length < widget.maxOptionSelected){
                      selected.add(value);
                    }
                  }
                }


                widget.onOptionChange(selected);
                setState(() {});
              },
              isSelected: !selected.contains(ListValue[index]),
            );
          }
      ),
    );
  }
}


/// tombol yang dipakai
class _OptionButton<T> extends StatelessWidget {
  const _OptionButton({Key? key, required this.label, required this.value, required this.styleSelected, required this.styleUnselected, required this.onSelect, required this.isSelected}) : super(key: key);

  final T value;
  final Widget label;
  final ButtonStyle styleSelected;
  final ButtonStyle styleUnselected;

  final bool isSelected;

  final Function(T value) onSelect;


  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        style: isSelected ? styleSelected : styleUnselected,
        onPressed: (){
          onSelect(value);
        },
        child: label
    );
  }
}