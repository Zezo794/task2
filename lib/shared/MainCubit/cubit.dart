

import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task2/shared/MainCubit/states.dart';




class AppCubit extends Cubit<AppState> {
  AppCubit() : super(InitialAppState());

  static AppCubit get(context) {
    return BlocProvider.of(context);
  }

  String selectedItem = 'الْقَصِيدَة الأُولَى : التّائِيَّة';
  int currentPage = 1;
  int totalPages = 0;
  bool fullScreen=false;

  void onPdfPageChanged(val) {
      currentPage = val;
      emit(ChangeCurrentPageSuccessState());
  }

  void changeTotalPage(val) {
    totalPages = val;
    emit(ChangeTotalPageSuccessState());
  }

  void changeSelectedItem(val) {
    selectedItem = val;
    emit(ChangeSelectedItemSuccessState());
  }


  void changeFullScreen(val) {
    fullScreen = val;
    emit(ChangeFullScreenSuccessState());
  }
  List<Rect> highlightRects = [];
  void addHighlightRect(Rect rect) {
    highlightRects.add(rect);
    emit(AppHighlightChangedState());
  }

}


