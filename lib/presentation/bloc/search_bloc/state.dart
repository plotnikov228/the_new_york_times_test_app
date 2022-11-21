import 'package:top_stories_test/domain/entities/story.dart';

abstract class SearchState{}

class SearchSetupState extends SearchState{
  late String query;
}
class SearchLoadingState extends SearchState{
  late String query;
}
class SearchLoadedState extends SearchState{
  final List<Story> list;
  final int listItem;
  int page;
  final int pages;
  String query;

  SearchLoadedState(this.list, this.page, this.pages, this.listItem, this.query);
}