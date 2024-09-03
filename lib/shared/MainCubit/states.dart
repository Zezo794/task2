 abstract class AppState {}

 class InitialAppState extends AppState{}


 class ChangeCurrentPageSuccessState extends AppState{}
 class ChangeTotalPageSuccessState extends AppState{}
 class ChangeSelectedItemSuccessState extends AppState{}
 class ChangeFullScreenSuccessState extends AppState{}

 class AppHighlightChangedState extends AppState{}







 class FetchVideoQualitiesLoadingState extends AppState{}
 class FetchVideoQualitiesSuccessState extends AppState{}
 class FetchVideoQualitiesErrorState extends AppState {
  final String error;

  FetchVideoQualitiesErrorState(this.error);
 }








 class ChangeShowThumbnailSuccessState extends AppState{}





