import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:koi_one_line/koi_one_line.dart';

/// kalau butuh input select tapi item yang bisa dipilih kebanyakan(misalnya nama kota)
class MultiSelectWithSearch<T> extends StatefulWidget {
  const MultiSelectWithSearch({super.key, required this.label, this.openSearchText, required this.onSearch, this.selected = const [], this.onSelected, this.suggestion = const [], this.searchHintText = "Cari..."});

  final String searchHintText;

  final Widget label;
  final Widget? openSearchText;

  /// yang terjadi jik user mencari data
  ///
  /// return adalah map berisi value dari tiap item sebagai key dan label yang akan ditampilkan dari tiap item
  /// parameter adalah search query yang akan digunakan
  final Future<List<KoiDataItem<T>>> Function(String searchQuery) onSearch;

  /// list dari item yang diselect(defaultnya)
  final List<KoiDataItem<T>> selected;

  /// suggestion yang user lihat tanpa perlu cari dulu. Sebaiknya ini diisi oleh beberapa data
  final List<KoiDataItem<T>> suggestion;

  /// callback yang dipanggil jika user menselect item. Defaultnya null/gak ada yang terjadi
  final Function(List<T> selectedItem)? onSelected;

  @override
  State<MultiSelectWithSearch> createState() => _MultiSelectWithSearchState();
}

class _MultiSelectWithSearchState extends State<MultiSelectWithSearch> {

  List<KoiDataItem> selected = [];
  List<dynamic> selectedOnlyVal = [];

  List<KoiDataItem> suggestion = [];
  late Widget openSearchText;

  bool isExist(List<KoiDataItem> source, dynamic toSearch){
    bool ret = false;

    for(int x=0; x< source.length; x++){
      if(source[x].data == toSearch){
        ret = true;
      }
    }

    return ret;
  }
  void buildSuggestion(){
    suggestion = [];

    suggestion.addAll(selected);

    widget.suggestion.forEach((adata){
      if(isExist(suggestion, adata.data) == false){
        suggestion.add(adata);
      }
    });

    setState(() {});

  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    widget.selected.forEach((adata){
      selected.add(adata);
      selectedOnlyVal.add(adata.data);
    });
    buildSuggestion();

    if(widget.openSearchText == null){
      openSearchText = Text("Lihat Semua");
    }else{
      openSearchText = widget.openSearchText!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            widget.label,
            Expanded(child: SizedBox()),
            TextButton(onPressed: (){
              //todo
              showBottomSheet(context: context, builder: (context){

                return _SheetSearch(searchHintText: widget.searchHintText, onSearch: widget.onSearch, selected: selected, onItemSelected: (newData){
                  selected = newData;
                  selectedOnlyVal = [];
                  newData.forEach((adata){
                    selectedOnlyVal.add(adata.data);
                  });

                  buildSuggestion();

                  if(widget.onSelected != null){
                    widget.onSelected!(selectedOnlyVal);
                  }
                  setState(() {});
                });
              });
            }, child: openSearchText)
          ],
        ),

        Wrap(
          alignment: WrapAlignment.start,
          runAlignment: WrapAlignment.start,
          spacing: context.koiSpacing.smallest,
          runSpacing: context.koiSpacing.smallest,
          children: List.generate(suggestion.length, (index){
            return ChoiceChip(
              label: suggestion[index].label,
              selected: selectedOnlyVal.contains(suggestion[index].data),
              onSelected: (isSelected){
                if(isSelected){
                  selected.add(suggestion[index]);
                  selectedOnlyVal.add(suggestion[index].data);
                }
                else{
                  selected.removeWhere((adata){
                    return adata.data == suggestion[index].data;
                  });
                  selectedOnlyVal.remove(suggestion[index].data);
                }
                if(widget.onSelected != null){
                  widget.onSelected!(selectedOnlyVal);
                }
                setState(() {});
              },
            );
          }),
        )
      ],
    );
  }
}

class _SheetSearch extends StatefulWidget {
  const _SheetSearch({super.key, required this.searchHintText, required this.onSearch, required this.selected, required this.onItemSelected});

  final Future<List<KoiDataItem>> Function(String searchQuery) onSearch;
  final List<KoiDataItem> selected;
  final String searchHintText;
  
  final Function(List<KoiDataItem> newSelected) onItemSelected;

  @override
  State<_SheetSearch> createState() => _SheetSearchState();
}

class _SheetSearchState extends State<_SheetSearch> {

  List<KoiDataItem> selected = [];
  List<dynamic> selectedOnlyVal = [];

  List<KoiDataItem> searchResult = [];
  
  @override
  void initState(){
    // TODO: implement initState
    super.initState();
    
    widget.selected.forEach((adata){
      selected.add(adata);
      selectedOnlyVal.add(adata.data);
    });

    widget.onSearch("").then((adata){
      searchResult.addAll(adata);
      setState(() {});
    });

  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [

          SizedBox(height: context.koiSpacing.autoFromScreenEdge*2,),

          Center(
            child: Container(
              color: context.koiThemeColor.outline,
              width: 50,
              height: 2,
            ),
          ),

          SizedBox(height: context.koiSpacing.autoFromScreenEdge*2,),

          TextField(
            decoration: InputDecoration(
              hintText: widget.searchHintText,
              prefixIcon: Icon(Icons.search),
            ),
            onChanged: (value) async{
              searchResult = await widget.onSearch(value);
              setState(() {});
            },
          ),


          Expanded(
              child: ListView(
                children: List.generate(searchResult.length, (idx){
                  return CheckboxListTile(
                    title: searchResult[idx].label,
                    value: selectedOnlyVal.contains(searchResult[idx].data),
                    onChanged: (value) {
                      if(value == true){
                        selected.add(searchResult[idx]);
                        selectedOnlyVal.add(searchResult[idx].data);
                      }
                      else{
                        selected.removeWhere((adata){
                          return adata.data == searchResult[idx].data;
                        });
                        selectedOnlyVal.remove(searchResult[idx].data);
                      }
                      setState(() {
                        widget.onItemSelected(selected);
                      });
                    },
                  );
                }),
              )
          )

        ],
      ),
    );
  }
}
