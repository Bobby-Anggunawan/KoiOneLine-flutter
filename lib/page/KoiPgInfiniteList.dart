import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

/// page untuk menampilkan list yang terdiri dari widget ListTitle()
class KoiPgInfiniteList extends StatefulWidget {
  const KoiPgInfiniteList({

    required this.fetchPage,
    this.pageStart = 1,
    this.leading = const [],
    this.controller = null,

    this.appBar,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.floatingActionButtonAnimator,
    this.persistentFooterButtons,
    this.persistentFooterAlignment = AlignmentDirectional.centerEnd,
    this.drawer,
    this.onDrawerChanged,
    this.endDrawer,
    this.onEndDrawerChanged,
    this.bottomNavigationBar,
    this.bottomSheet,
    this.backgroundColor,
    this.resizeToAvoidBottomInset,
    this.primary = true,
    this.drawerDragStartBehavior = DragStartBehavior.start,
    this.extendBody = false,
    this.extendBodyBehindAppBar = false,
    this.drawerScrimColor,
    this.drawerEdgeDragWidth,
    this.drawerEnableOpenDragGesture = true,
    this.endDrawerEnableOpenDragGesture = true,
    this.restorationId,
    Key? key
  }) : super(key: key);

  /// page awal halaman ini mulai fetch. defaultnya 1
  final int pageStart;

  /// controller untuk mengatur paging
  ///
  /// Init dengan [PagingController(firstPageKey: widget.pageStart)]
  final KoiPgInfiniteListController? controller;

  /// daftar widget yang diletakkan sebelum list yang akan di fetch
  /// note, gak ada trailing karena kan ini harusnya infite list :v
  final List<Widget> leading;

  /// Fungsi untuk mengambil data
  ///
  /// **Parameter**
  /// * [page]: page yan diambil saat ini. Dimulai dari [pageStart], defaultnya 1
  ///
  /// **Return**
  /// Mereturn list widget yang akan ditampilkan. Kalau null atau kosong artinya ini page terakhir, proses fetch akan dihentikan
  final Future<List<Widget>?> Function(int page) fetchPage;

  final PreferredSizeWidget? appBar;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final FloatingActionButtonAnimator? floatingActionButtonAnimator;
  final List<Widget>? persistentFooterButtons;
  final AlignmentDirectional persistentFooterAlignment;
  final Widget? drawer;
  final void Function(bool)? onDrawerChanged;
  final Widget? endDrawer;
  final void Function(bool)? onEndDrawerChanged;
  final Widget? bottomNavigationBar;
  final Widget? bottomSheet;
  final Color? backgroundColor;
  final bool? resizeToAvoidBottomInset;
  final bool primary;
  final DragStartBehavior drawerDragStartBehavior;
  final bool extendBody;
  final bool extendBodyBehindAppBar;
  final Color? drawerScrimColor;
  final double? drawerEdgeDragWidth;
  final bool drawerEnableOpenDragGesture;
  final bool endDrawerEnableOpenDragGesture;
  final String? restorationId;

  @override
  State<KoiPgInfiniteList> createState() => _KoiPgInfiniteListState();
}

class _KoiPgInfiniteListState extends State<KoiPgInfiniteList> {

  late PagingController<int, Widget> controller;

  @override
  void initState() {
    controller = PagingController(firstPageKey: widget.pageStart);
    controller.addPageRequestListener((pageKey) {
      widget.fetchPage(pageKey).then((adata){
        // berhenti tambah data
        if(adata == null || adata.isEmpty){

          /// kalau di page pertama data langsung kosong(belum ada data masuk misalnya)
          if(pageKey == controller.firstPageKey){
            controller.appendLastPage(widget.leading);
          }

          controller.nextPageKey = null;
        }
        else{
          // ini tambah widget leading
          if(pageKey == controller.firstPageKey){
            adata.insertAll(0, widget.leading);
          }

          // ini baru masukkan data yang di fetch
          controller.appendPage(adata, pageKey+1);
        }
      });
    });

    widget.controller?._onRefresh = (){
      controller.refresh();
    };


    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();


    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: PagedListView<int, Widget>(
        pagingController: controller,
        builderDelegate: PagedChildBuilderDelegate(itemBuilder: (BuildContext context, Widget item, int index) {
          return item;
        }),
      ),

      appBar: widget.appBar,
      floatingActionButton: widget.floatingActionButton,
      floatingActionButtonLocation: widget.floatingActionButtonLocation,
      floatingActionButtonAnimator: widget.floatingActionButtonAnimator,
      persistentFooterButtons: widget.persistentFooterButtons,
      persistentFooterAlignment: widget.persistentFooterAlignment,
      drawer: widget.drawer,
      onDrawerChanged: widget.onDrawerChanged,
      endDrawer: widget.endDrawer,
      onEndDrawerChanged: widget.onEndDrawerChanged,
      bottomNavigationBar: widget.bottomNavigationBar,
      bottomSheet: widget.bottomSheet,
      backgroundColor: widget.backgroundColor,
      resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset,
      primary: widget.primary,
      drawerDragStartBehavior: widget.drawerDragStartBehavior,
      extendBody: widget.extendBody,
      extendBodyBehindAppBar: widget.extendBodyBehindAppBar,
      drawerScrimColor: widget.drawerScrimColor,
      drawerEdgeDragWidth: widget.drawerEdgeDragWidth,
      drawerEnableOpenDragGesture: widget.drawerEnableOpenDragGesture,
      endDrawerEnableOpenDragGesture: widget.endDrawerEnableOpenDragGesture,
      restorationId: widget.restorationId,
    );
  }
}


class KoiPgInfiniteListController{

  KoiPgInfiniteListController();

  void refresh(){
    _onRefresh!();
  }

  Function? _onRefresh;
}