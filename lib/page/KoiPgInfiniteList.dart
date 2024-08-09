import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

/// page untuk menampilkan list yang terdiri dari widget ListTitle()
class KoiPgInfiniteList extends StatefulWidget {
  const KoiPgInfiniteList({

    required this.fetchPage,
    this.pageStart = 1,
    this.pagingController = null,
    this.leading = const [],

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
  final PagingController<int, Widget>? pagingController;

  /// daftar widget yang diletakkan sebelum list
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

  late PagingController<int, Widget> _pagingController;
  PagingController<int, Widget> get controller{
    if(widget.pagingController == null){
      return _pagingController;
    }
    return widget.pagingController!;
  }

  @override
  void initState() {
    if(widget.pagingController == null){
      _pagingController = PagingController(firstPageKey: widget.pageStart);

      // tambah daftar widget leading yang dimasuukkan sebagai parameter widget ini
      controller.appendPage(widget.leading, controller.firstPageKey);

      controller.addPageRequestListener((pageKey) {
        widget.fetchPage(pageKey).then((adata){
          // berhenti tambah data
          if(adata == null || adata.isEmpty){
            controller.nextPageKey = null;
          }
          else{
            controller.appendPage(adata, pageKey+1);
          }
        });
      });
    }


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
