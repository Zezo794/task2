import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task2/shared/MainCubit/states.dart';

import '../network/local/Database_helper.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(InitialAppState());

  static AppCubit get(context) {
    return BlocProvider.of(context);
  }

  String selectedItem = 'الْقَصِيدَة الأُولَى : التّائِيَّة';
  int currentPage = 1;
  int totalPages = 0;
  bool fullScreen = false;

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

  List<Map<String, dynamic>> allFavorites = [];
  List<String> allFavoritesTitles = [];
  Future<void> getALLFavorites() async {
    try {
      allFavorites = await DBHelper.getAllFavorites();
      emit(GetALLFavoritesSuccessState());
    } catch (e) {
      print('Error fetching favorites: $e');
    }
  }

  Future<void> getALLFavoritesTitles() async {
    try {
      allFavoritesTitles = await DBHelper.getAllFavoriteTitles();
      emit(GetALLFavoritesTitlesSuccessState());
    } catch (e) {
      print('Error fetching favorites titles: $e');
    }
  }

  List<Map<String, dynamic>> allItem = [];

  // Future<void> getALLItem() async {
  //   try {
  //     allItem = await DBHelper.getAllData();
  //     emit(GetALLItemSuccessState());
  //   } catch (e) {
  //     print('Error fetching favorites: $e');
  //   }
  // }

  Future<void> insertAllTitles(List<Map<String, int>> titles) async {
    for (var title in titles) {
      title.forEach((key, value) async {
        await DBHelper.insert(key, value);
      });
    }
  }

  void changeFavoritesUser(String title, bool isFavorite) {
    try {
      // Assuming you have a way to identify the new item by title
      Map<String, dynamic>? newItem = allFavorites.firstWhere(
            (item) => item['title'] == title,

      );



      var mutableFavorites = List<Map<String, dynamic>>.from(allFavorites);

      if (newItem['isFavorite'] == 1) {
        newItem['isFavorite'] = 0;
        mutableFavorites.removeWhere((fav) => fav['id'] == newItem['id']);
      } else {
        newItem['isFavorite'] = 1;
        mutableFavorites.add(newItem);
      }

      allFavorites = mutableFavorites;

      emit(ChangeFavoritesUseSuccessStater());
    } catch (e) {
      print(e);
    }
  }


  void changeFavoritesUser2(String title) {
    try {

      if (allFavoritesTitles.contains(title)) {
        allFavoritesTitles.remove(title);
      } else {
       allFavoritesTitles.add(title);
      }

      emit(ChangeFavoritesUseSuccessStater());
    } catch (e) {

      print(e);
    }
  }


  Future<void> changeFavoritesDatabase(String title) async {
    try {

      if (allFavoritesTitles.contains(title)) {
        await DBHelper.updateFavorite(title, 1);
      } else {

        await DBHelper.updateFavorite(title, 0);
      }
    } catch (e) {
      print(e);
    }

    emit(ChangeFavoritesDatabaseSuccessState());
  }

}
