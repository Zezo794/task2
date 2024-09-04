import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pdfx/pdfx.dart';
import 'package:task2/shared/MainCubit/cubit.dart';
import 'package:task2/shared/MainCubit/states.dart';

import '../../shared/component/constans.dart';

class PdfViewerPage extends StatefulWidget {
  const PdfViewerPage({super.key});

  @override
  PdfViewerPageState createState() => PdfViewerPageState();
}

class PdfViewerPageState extends State<PdfViewerPage> {
  late PdfController _pdfController;

  @override
  void initState() {
    super.initState();
    _initPdfController();
    _loadTotalPages();
  }

  void _initPdfController() {
    var cubit = AppCubit.get(context);
    _pdfController = PdfController(
      document: PdfDocument.openAsset('assets/final.pdf'),
      initialPage: cubit.currentPage,
    );
  }

  Future<void> _loadTotalPages() async {
    var cubit = AppCubit.get(context);
    final document = await _pdfController.document;
    cubit.changeTotalPage(document.pagesCount);
  }

  @override
  void dispose() {
    _pdfController.dispose();
    super.dispose();
  }

  @override
  @override
  Widget build(BuildContext context) {
    var cubit = AppCubit.get(context);
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          backgroundColor: const Color(0xFFE0E4C9),
          appBar: cubit.fullScreen
              ? null
              : AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.black54,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: cubit.selectedItem,
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        cubit.changeSelectedItem(newValue);
                        int pageIndex = titles
                            .firstWhere((element) => element.keys.first == newValue)
                            .values
                            .first;
                        _pdfController.animateToPage(
                          pageIndex,
                          duration: const Duration(milliseconds: 250),
                          curve: Curves.ease,
                        );
                        cubit.onPdfPageChanged(pageIndex);
                      }
                    },
                    items: titles.map<DropdownMenuItem<String>>((Map<String, int> title) {
                      return DropdownMenuItem<String>(
                        value: title.keys.first,
                        child: FittedBox(
                          child: Text(
                            title.keys.first,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      );
                    }).toList(),
                    underline: const SizedBox(height: 1),
                    iconEnabledColor: Colors.black,
                    dropdownColor: Colors.black54,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(width: 5,),
                Expanded(
                  child: Text(
                    'الصفحة ${cubit.currentPage} / ${cubit.totalPages}',
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
                IconButton(
                  icon: Icon(
                    cubit.allFavoritesTitles.contains(cubit.selectedItem)
                        ? Icons.star
                        : Icons.star_border,
                    color: cubit.allFavoritesTitles.contains(cubit.selectedItem)
                        ? Colors.yellow
                        : Colors.white,
                  ),
                  onPressed: () async {
                    cubit.changeFavoritesUser2(cubit.selectedItem);
                    await cubit.changeFavoritesDatabase(cubit.selectedItem);
                  },
                ),
                IconButton(
                  onPressed: () {
                    cubit.changeFullScreen(!cubit.fullScreen);
                  },
                  icon: const Icon(Icons.fullscreen),
                ),
              ],
            ),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_forward),
              ),
            ],
          ),

            body: WillPopScope(
            onWillPop: () async {
              if (cubit.fullScreen) {
                cubit.changeFullScreen(false);
                return false; // Prevent the page from popping
              }
              return true; // Allow the page to pop
            },
            child: LayoutBuilder(
              builder: (context, constraints) {
                return PdfView(
                    scrollDirection: Axis.vertical,
                    physics: const BouncingScrollPhysics(),
                    controller: _pdfController,
                    renderer: (PdfPage page) {
                      return page.render(
                        width: constraints.maxWidth,
                        height: constraints.maxHeight,
                        format: PdfPageImageFormat.jpeg,
                        backgroundColor: '#e0e4c9',
                      );
                    },
                    onPageChanged: (index) {
                      cubit.onPdfPageChanged(index);

                      for (int i = 0; i < titles.length - 1; i++) {
                        var title = titles[i];
                        var pageNumber = title.values.first;
                        var title2 = titles[i + 1];
                        var pageNumber2 = title2.values.first;

                        if (index >= pageNumber && index < pageNumber2) {
                          cubit.changeSelectedItem(title.keys.first);
                          break;
                        }
                      }

                      // If the current page index is beyond the last title's page number
                      if (index >= titles.last.values.first) {
                        cubit.changeSelectedItem(titles.last.keys.first);
                      }
                    });
              },
            ),
          ),
        );
      },
    );
  }
}
