import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_stories_test/data/datasources/connection_info.dart';
import 'package:top_stories_test/data/datasources/local_datasources/story_local_datasources.dart';
import 'package:top_stories_test/data/datasources/remote_datasources/story_remote_datasources.dart';
import 'package:top_stories_test/data/repository/story_repository.dart';
import 'package:top_stories_test/domain/entitye/story.dart';
import 'package:top_stories_test/domain/usecases/search_stories.dart';
import 'package:top_stories_test/presentation/bloc/search_bloc/event.dart';
import 'package:top_stories_test/presentation/bloc/search_bloc/state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  List<Story> list;
  SearchBloc(initialState, this.list) : super(SearchSetupState()) {

    int pages = 1;
    int itemList = 5;
    int selectedPage = 1;
    late List<Story> _list;
    String query = '';

    final StoryRepositoryImpl storyRepositoryImpl = StoryRepositoryImpl(
        StoryRemoteDataSources(), StoryLocalDataSources(), ConnectionInfo());

  on<SearchingEvent>((event, emit) async{
    emit(SearchLoadingState());
    query = event.query;
    _list = await SearchStories(
      storyRepositoryImpl,
      event.query,
      list
    ).searchStories();
    pages = _list.length ~/ 5;
    itemList = 5;
    if(_list.length < 5) {
      itemList = _list.length;
      pages = 1;
    }
    selectedPage = 1;
    if(_list.isEmpty){
      pages = 0;
      emit(SearchSetupState());
    }
    emit(SearchLoadedState(_list, selectedPage, pages, itemList, query));
  });

  on<SearchChangePageEvent>((event, emit) async{
    emit(SearchLoadingState());

    List<Story> list = [];
    var maxLengthList = event.selectedPage * 5;
    if (maxLengthList > _list.length) {
      maxLengthList = maxLengthList - (maxLengthList - _list.length);
    }
    for (int i = maxLengthList - 5; i < maxLengthList; i++) {
      print(i);
      list.add(_list[i]);
    }
    selectedPage = event.selectedPage;
    emit(SearchLoadedState(list, selectedPage, pages, itemList, query));
  });

}}