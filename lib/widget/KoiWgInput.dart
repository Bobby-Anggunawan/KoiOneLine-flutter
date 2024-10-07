import 'package:flutter/material.dart';
import 'package:koi_one_line/widget/KoiWgInput/MultiSelectWithSearch.dart';


class KoiDataItem<T>{
  T data;
  Widget label;

  KoiDataItem({required this.label, required this.data});

}

/// kumpulan widget input yang terlalu rumit masuk ke KoiWgForm
class KoiWgInput extends StatelessWidget {


  final Widget _ret;

  KoiWgInput.MultiSelectWithSearch({
    Key? key,
    required Widget label,
    Widget? openSearchText,
    required Future<List<KoiDataItem<String>>> Function(String searchQuery) onSearch,
    List<KoiDataItem<String>> selected = const [],
    List<KoiDataItem<String>> suggestion = const [],
    Function(List<dynamic> selectedItem)? onSelected
  }) : _ret = MultiSelectWithSearch<String>(label: label, openSearchText: openSearchText, onSearch: onSearch, selected: selected, suggestion: suggestion, onSelected: onSelected), super(key: key);

  @override
  Widget build(BuildContext context) {
    return _ret;
  }
}