import 'package:flutter/material.dart';
import 'package:koi_one_line/koi_one_line.dart';


enum SortDirections{
  Ascending,
  Descending,
  None
}


/// masih dalam progress
///
/// TODO:
/// * buat supaya bisa ambil data dari api langsung(proses loading, sorting, paging, dll semua di handle di sini, user tinggal memasukkan url apu)
class KoiWgDataTable extends StatelessWidget {
  const KoiWgDataTable({
    Key? key,
    required this.columns,
    required this.row,
    this.headerColor = null,
    this.rowColorOdd = null,
    this.rowColorEven = null,
    this.rowMinHeight = 52,
    this.headerHeight = 56,
    this.columnMinWidth = 100,
    this.columnMaxWidth = 300,
    this.cellContentAlignment = Alignment.centerLeft,
    this.borderInnerVertical = BorderSide.none,
    this.borderInnerHorizontal = const BorderSide(color: Colors.black),
    this.borderOuter = const BorderSide(color: Colors.black),
    this.cellContentpadding = const EdgeInsets.symmetric(horizontal: 16),
    this.onSort = null,
    this.highlightRowIndex = const {}
  }) : super(key: key);

  /// tinggi minimal tiap row. Default **52** dapat dari:
  ///
  /// *https://m2.material.io/components/data-tables#anatomy*
  final double rowMinHeight;

  final double headerHeight;

  /// lebar minimum suatu kolom(kalau kolom di asignt otomatis/size dibiarkan null)
  /// Note, nilai 100 dariku sendiri
  final double columnMinWidth;
  /// lebar maksimum suatu kolom(kalau kolom di asignt otomatis/size dibiarkan null)
  /// Note, nilai 300 dariku sendiri
  final double columnMaxWidth;

  /// spacing antar kolom. Default **16** dapat dari:
  ///
  /// *EdgeInsets.symmetric(horizontal: 16)*
  ///
  /// *https://m2.material.io/components/data-tables#anatomy*
  final EdgeInsets cellContentpadding;

  final Color? headerColor;
  final Color? rowColorOdd;
  final Color? rowColorEven;

  /// Alignment semua item di dalam cell. Defaultnya [Alignment.centerLeft]
  /// Note, ini diaplikasikan sama untuk content di row dan header
  final Alignment cellContentAlignment;


  //###################################
  /// Border item vertical(border antar kolom).
  /// Default: [BorderSide.none]
  final BorderSide borderInnerVertical;
  /// Border item horizontal(border antar baris).
  /// Default: [BorderSide(color: Colors.black)]
  final BorderSide borderInnerHorizontal;
  /// Border di sisi luar tabel ini.
  /// Default: [BorderSide(color: Colors.black)]
  final BorderSide borderOuter;
  //###################################

  /// list kolom kolom yang ada di dalam tabel, berurutan dari kiri ke kanan
  final List<WgDataTableColumn> columns;
  /// list row yang ada di dalam tabel. Isinya list yang menggambarkan data per baris.
  ///
  /// **WARNING**
  /// kalau jumlah item dalam list di bagian dalam tidak sama dengan jumlah item dalam list di parameter [columns], widget ini akan mereturn error
  final List<List<Widget>> row;

  /// kalau ada row yang diwarnai, masukkanindeksnya beserta warnanya
  final Map<int, Color> highlightRowIndex;

  /// fungsi yang dipanggil kalau tombol sort ditekan di header
  final void Function(int indexSortedColumn, List<SortDirections> allColumnDirection)? onSort;

  @override
  Widget build(BuildContext context) {



    final ScrollController _horizontal = ScrollController(),
        _vertical = ScrollController();


    List<List<Widget>> generatedRow = [];
    List<double> generatedRowWidth = [];


    int _macCol = 0;
    row.forEach((element) {
      if(_macCol < element.length){
        _macCol = element.length;
      }

      //start-hitung ukuran tiap kolom
      for(int x =0; x < element.length; x++){

        double getSize = columns[x].width ?? columnMinWidth;
        if(element[x] is Text){
          var atext = element[x] as Text;
          if(atext.data != null){
            var getSize_ = KoiLib.calculateWidgetSize.Text(atext.data!, atext.style ?? TextStyle()).width;
            if(getSize < getSize_){
              getSize = getSize_;
            }
          }
          else{
            TextPainter textPainter = TextPainter(
                text: atext.textSpan, maxLines: 1, textDirection: TextDirection.ltr)
              ..layout(minWidth: 0, maxWidth: double.infinity);
            var getSize_ = textPainter.size.width;
            if(getSize < getSize_){
              getSize = getSize_;
            }
          }
        }

        try{
          if(generatedRowWidth[x] <  getSize && getSize < columnMaxWidth){
            generatedRowWidth[x] = getSize;
          }
        }
        catch(e){
          generatedRowWidth.add(getSize);
        }
      }
      //end---hitung ukuran tiap kolom
    });

    //start-fill generated row(supaya kalau jumlah colom tiap row berbeda beda, widget tetap menampilkan hasil)
    row.forEach((element) {
      if(element.length < _macCol){
        while(element.length < _macCol){
          element.add(SizedBox());
        }
      }

      generatedRow.add(element);
    });
    //end---fill generated row(supaya kalau jumlah colom tiap row berbeda beda, widget tetap menampilkan hasil)


    var buildHeader = _RenderRow(
      List.generate(columns.length, (index){return columns[index].title;}),
      generatedRowWidth,
      rowMinHeight: headerHeight,
      rowFixHeight: headerHeight,
      cellContentAlignment: cellContentAlignment,
      cellContentpadding: cellContentpadding,
      borderInnerHorizontal: borderInnerHorizontal,
      borderInnerVertical: borderInnerVertical,
      backgroundColor: headerColor ?? context.koiThemeColor.surfaceVariant,
    );

    return Scrollbar(
      controller: _horizontal,
      thumbVisibility: true,
      trackVisibility: true,
      child: Scrollbar(
        controller: _vertical,
        thumbVisibility: true,
        trackVisibility: true,
        notificationPredicate: (notif) => notif.depth == 1,
        child: SingleChildScrollView(
            controller: _horizontal,
            scrollDirection: Axis.horizontal,
            child: Stack(
              children: [
                SingleChildScrollView(
                  controller: _vertical,
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: buildHeader.rowFixHeight,)
                    ].koiJoinList(List.generate(generatedRow.length, (index){
                      return _RenderRow(
                        generatedRow[index],
                        generatedRowWidth,
                        rowMinHeight: rowMinHeight,
                        cellContentAlignment: cellContentAlignment,
                        cellContentpadding: cellContentpadding,
                        borderInnerHorizontal: borderInnerHorizontal,
                        borderInnerVertical: borderInnerVertical,
                        backgroundColor: index % 2 == 0 ? (rowColorEven ?? context.koiThemeColor.surface) : (rowColorOdd ?? context.koiThemeColor.surfaceVariant),
                      );
                    })),
                  ),
                ),

                Align(
                  child: buildHeader,
                  alignment: Alignment.topCenter,
                ),
              ],
            )
        ),
      ),
    );
  }
}

class WgDataTableColumn{
  WgDataTableColumn({
    required this.title,
    this.width,
    this.canSort = false,
    this.directions = SortDirections.None
  });

  /// nama kolom ini
  final Widget title;

  /// lebar dari kolom ini
  /// kalau null artinya sizenya otomatis
  /// kalau tidak null, sizenya mengikuti angka yang dimasukkan ke [assignedColumn]
  final double? width;

  /// apa kolom ini bisa di sort
  /// Defaultnya false
  final bool canSort;

  /// sort directions saat ini. default [none]
  SortDirections directions;
}

class _RenderRow extends StatelessWidget {
  const _RenderRow(
      this.row,
      this.width,
      {
        Key? key,
        required this.rowMinHeight,
        this.rowFixHeight,
        required this.cellContentpadding,
        required this.cellContentAlignment,
        required this.borderInnerVertical,
        required this.borderInnerHorizontal,
        required this.backgroundColor
      }) : super(key: key);

  final List<Widget> row;//
  final List<double> width;

  final Color backgroundColor;

  final double rowMinHeight;//

  /// dipakai untuk header aja biar tingginya fix
  final double? rowFixHeight;


  final EdgeInsets cellContentpadding;//
  final Alignment cellContentAlignment;
  final BorderSide borderInnerVertical;//
  final BorderSide borderInnerHorizontal;//

  @override
  Widget build(BuildContext context) {

    return Container(
      height: rowFixHeight,
      decoration: BoxDecoration(
          color: backgroundColor,
        border: Border.symmetric(horizontal: borderInnerHorizontal),
      ),
      constraints: BoxConstraints(
          minHeight: rowMinHeight,
      ),
      child: IntrinsicHeight(
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: List.generate(row.length, (index){
              return Container(
                decoration: BoxDecoration(
                  border: Border.symmetric(vertical: borderInnerHorizontal),
                ),
                child: Padding(
                    padding: cellContentpadding,
                    child: Container(
                      width: width[index],
                      child: row[index],
                    )
                ),
              );
            })
        ),
      ),
    );

    return Row(
      children: List.generate(row.length, (index){
        return Container(
          height: rowFixHeight,
          width: width[index],
          decoration: BoxDecoration(
              border: Border.symmetric(vertical: borderInnerVertical, horizontal: borderInnerHorizontal),
              color: backgroundColor
          ),
          constraints: BoxConstraints(
              minHeight: rowMinHeight
          ),
          child: Padding(
            padding: cellContentpadding,
            child: Align(
              alignment: cellContentAlignment,
              child: row[index],
            ),
          ),
        );
      }),
    );
  }
}
