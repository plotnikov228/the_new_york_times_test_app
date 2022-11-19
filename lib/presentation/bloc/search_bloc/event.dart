abstract class SearchEvent{}

class SearchingEvent extends SearchEvent{
  String query;
  SearchingEvent(this.query);
}
class SearchChangePageEvent extends SearchEvent{
  int selectedPage;
  SearchChangePageEvent(this.selectedPage);
}