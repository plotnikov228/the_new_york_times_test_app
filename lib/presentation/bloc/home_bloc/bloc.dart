import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_stories_test/data/datasources/connection_info.dart';
import 'package:top_stories_test/data/datasources/local_datasources/story_local_datasources.dart';
import 'package:top_stories_test/data/datasources/remote_datasources/story_remote_datasources.dart';
import 'package:top_stories_test/data/repository/story_repository.dart';
import 'package:top_stories_test/domain/entities/story.dart';
import 'package:top_stories_test/domain/usecases/get_favorite_section.dart';
import 'package:top_stories_test/domain/usecases/get_stories.dart';
import 'package:top_stories_test/presentation/bloc/home_bloc/event.dart';
import 'package:top_stories_test/presentation/bloc/home_bloc/state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final List<String> sections;


  HomeBloc(this.sections)
      : super(HomeLoadingState(
            sections, 'home', GetFavoriteSection.favoriteSections)) {
    final List<String> favoriteSections = GetFavoriteSection.favoriteSections;
    int itemList = 5;
    String section = 'home';
    int selectedPage = 1;
    int pages = 0;
    bool snackBar = false;
    List<Story> fetchedData = [];
    List<Story> listRightNow = [];
    final StoryRepositoryImpl storyRepositoryImpl = StoryRepositoryImpl(
        StoryRemoteDataSources(), StoryLocalDataSources(), ConnectionInfo());
///HOME LOAD
    on<HomeLoadEvent>((event, emit) async {
      emit(HomeLoadingState(sections, section, favoriteSections));
      fetchedData = await GetStories(storyRepositoryImpl, section).getStories();
      print(fetchedData.length);
      listRightNow = fetchedData;
      pages = fetchedData.length ~/ 5;
      itemList = 5;
      if (fetchedData.length <= 5) {
        itemList = fetchedData.length;
        pages = 1;
      }
      if(pages * 5 < fetchedData.length) {
        pages++;
      }
      if (fetchedData.isEmpty) {
        pages = 0;
      }

      emit(HomeLoadedState(
          listRightNow,
          selectedPage,
          pages,
          itemList,
          sections,
          section,
          favoriteSections, fetchedData));

    });
///HOME CHANGE SECTION
    on<HomeChangeSectionEvent>((event, emit) async {
      emit(HomeLoadingState(sections, section, favoriteSections));
      section = event.section;
      selectedPage = 1;
      fetchedData = await GetStories(storyRepositoryImpl, section).getStories();
      listRightNow = fetchedData;
      pages = fetchedData.length ~/ 5;
      itemList = 5;
      if (fetchedData.length < 5) {
        itemList = fetchedData.length;
        pages = 1;
      }
      if(pages * 5 < fetchedData.length) {
        pages++;
      }
      if (fetchedData.isEmpty) {
        pages = 0;
      }

      emit(HomeLoadedState(listRightNow, selectedPage, pages, itemList, sections,
          section, favoriteSections, fetchedData));
    });
///HOME CHANGE PAGE
    on<HomeChangePageEvent>((event, emit) async {
      List<Story> _list = [];
      int maxLengthList = event.selectedPage * 5;
      itemList = 5;
      selectedPage = event.selectedPage;
      if(maxLengthList > fetchedData.length) {
        itemList  = fetchedData.length - ((event.selectedPage - 1) * 5);
        maxLengthList = fetchedData.length;
      }
      for (int i = maxLengthList - itemList; i < maxLengthList; i++) {
        print(i);
        _list.add(fetchedData[i]);
      }

      listRightNow = _list;

      emit(HomeLoadedState(listRightNow, selectedPage, pages, itemList, sections,
          section, favoriteSections, fetchedData));
    });
///HOME ADD SECTION TO FAVORITE
    on<HomeAddSectionToFavoriteEvent>((event, emit) async {
      if (favoriteSections.contains(event.section)) {
        favoriteSections.remove(event.section);
      } else {
        favoriteSections.add(event.section);
      }
      await GetFavoriteSection.setFavoriteSections(favoriteSections);

      emit(HomeLoadedState(listRightNow, selectedPage, pages, itemList,
          sections, section, favoriteSections, fetchedData));
    });
///HOME REFRESH LIST
    on<HomeRefreshListEvent>((event, emit) async {
      if(event.fetchedData != null){
        fetchedData = event.fetchedData;
        pages = event.fetchedData.length ~/ 5;
        itemList =5;
        if (fetchedData.length <= 5) {
          itemList = fetchedData.length;
          pages = 1;
        }
        if(pages * 5 < fetchedData.length) {
          pages++;
        }
        if(selectedPage != 1) {
          if(selectedPage <= pages) {
            List<Story> _list = [];
            itemList = 5;
            var maxLengthList = selectedPage * 5;
            if(maxLengthList > fetchedData.length) {
              itemList  = fetchedData.length - ((selectedPage - 1) * 5);
              maxLengthList = fetchedData.length;
            }
            for (int i = maxLengthList - itemList; i < maxLengthList; i++) {
              print(i);
              _list.add(fetchedData[i]);
            }
            listRightNow = _list;

            emit(HomeLoadedState(listRightNow, selectedPage, pages, itemList, sections,
                section, favoriteSections, fetchedData));
          } else {
            List<Story> _list = [];
            for (int i =0; i < (fetchedData.length > 5 ? 5 : fetchedData.length) ; i++) {
              print(i);
              _list.add(fetchedData[i]);
            }
            listRightNow = _list;

            emit(HomeLoadedState(listRightNow, selectedPage, pages, itemList, sections,
                section, favoriteSections, fetchedData));
          }
        }
        else {
          itemList = fetchedData.length > 5 ? 5 : fetchedData.length;
          List<Story> _list = [];
          for (int i =0; i < itemList; i++) {
            print(i);
            _list.add(fetchedData[i]);
          }
          listRightNow = _list;

          emit(HomeLoadedState(listRightNow, selectedPage, pages, itemList, sections,
              section, favoriteSections, fetchedData));
        }
      }
    });
  }
}

