import 'package:top_stories_test/domain/entities/story.dart';

abstract class HomeEvent{}

class HomeLoadEvent extends HomeEvent{}
class HomeSearchEvent extends HomeEvent{
  final String query;
  HomeSearchEvent(this.query);
}
class HomeChangePageEvent extends HomeEvent{
  final int selectedPage;
  HomeChangePageEvent(this.selectedPage);
}
class HomeChangeSectionEvent extends HomeEvent{
  final String section;
  HomeChangeSectionEvent(this.section);
}
class HomeRefreshListEvent extends HomeEvent{
  final List<Story> fetchedData;

  HomeRefreshListEvent(this.fetchedData);
}

class HomeAddSectionToFavoriteEvent extends HomeEvent{
  final String section;

  HomeAddSectionToFavoriteEvent(this.section);
}