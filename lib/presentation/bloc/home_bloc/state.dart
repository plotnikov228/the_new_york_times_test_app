import 'package:top_stories_test/domain/entitye/story.dart';

abstract class HomeState {}

class HomeLoadingState extends HomeState{
  final List<String> sections;
  String section;
  List<String> favoriteSections;
  HomeLoadingState(this.sections, this.section,this.favoriteSections);
}
class HomeLoadedState extends HomeState{
  final List<Story> list;
  final int listItem;
  int page;
  final int pages;
  List<String> favoriteSections;
  final List<String> sections;
  String section;
  final List<Story> fetchedData;


  HomeLoadedState(this.list, this.page, this.pages, this.listItem, this.sections, this.section, this.favoriteSections, this.fetchedData);
}
