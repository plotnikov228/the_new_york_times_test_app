import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_stories_test/data/datasources/connection_info.dart';
import 'package:top_stories_test/data/datasources/local_datasources/story_local_datasources.dart';
import 'package:top_stories_test/data/datasources/remote_datasources/story_remote_datasources.dart';
import 'package:top_stories_test/data/repository/story_repository.dart';
import 'package:top_stories_test/domain/entities/story.dart';
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
    print(_list.length);
    pages = _list.length ~/ 5;
    itemList = 5;
    if(_list.length < 5) {
      itemList = _list.length;
      pages = 1;
    }
    if(pages * 5 < _list.length){
      pages++;
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
    itemList = 5;
    selectedPage = event.selectedPage;
    if(maxLengthList > _list.length) {
      itemList  = _list.length - ((event.selectedPage - 1) * 5);
      maxLengthList = _list.length;
    }
        selectedPage = event.selectedPage;

    for (int i = maxLengthList - itemList; i < maxLengthList; i++) {
      print(i);
      list.add(_list[i]);
    }

    emit(SearchLoadedState(list, selectedPage, pages, itemList, query));
  });

}}