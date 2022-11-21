import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_stories_test/data/datasources/connection_info.dart';
import 'package:top_stories_test/data/datasources/local_datasources/story_local_datasources.dart';
import 'package:top_stories_test/data/datasources/remote_datasources/story_remote_datasources.dart';
import 'package:top_stories_test/data/repository/story_repository.dart';
import 'package:top_stories_test/domain/entities/story.dart';
import 'package:top_stories_test/domain/usecases/get_stories.dart';

import 'package:top_stories_test/presentation/bloc/home_bloc/bloc.dart';
import 'package:top_stories_test/presentation/bloc/home_bloc/event.dart';
import 'package:top_stories_test/presentation/bloc/home_bloc/state.dart';
import 'package:top_stories_test/presentation/view/search_page.dart';
import 'package:top_stories_test/presentation/widget/stories_list.dart';
import 'package:top_stories_test/presentation/widget/stories_loading_sliver_widget.dart';
import 'package:top_stories_test/presentation/widget/stories_pagination.dart';

class StoriesBlocBuilder extends StatelessWidget {

  const StoriesBlocBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeBloc bloc = context.read<HomeBloc>();
    return BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
      if(state is HomeLoadingState) {
        return StoriesLoadingSliverWidget(bloc, state.section, state.favoriteSections, state.sections);
      }

      if (state is HomeLoadedState) {

        return StreamBuilder(
          stream: getStoriesStream(state.section),
          builder: (context, AsyncSnapshot<List<Story>> snapshot) {

            if(snapshot.connectionState != ConnectionState.waiting && snapshot.data! != null ) {
              if(snapshot.data!.first.title != state.fetchedData.first.title) {
                bloc.add(HomeRefreshListEvent(snapshot.data!));
              }
            }

           return CustomScrollView(
            slivers: [
              SliverAppBar(
                title: Text(state.section),
                floating: true,
                elevation: 0,
                actions: [
                  IconButton(
                    icon: Icon(state.favoriteSections.contains(state.section)
                        ? Icons.remove
                        : Icons.add),
                    onPressed: () {
                      bloc.add(HomeAddSectionToFavoriteEvent(state.section));
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => StorySearch(
                              loadedList: state.fetchedData)));
                    },
                  )
                ],
                bottom: AppBar(
                  automaticallyImplyLeading: false,
                  title: Container(
                      width: double.infinity,
                      height: 40,
                      color: Colors.white,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(4, 0, 4, 0),
                            child: OutlinedButton(
                              onPressed: () {
                                if (state.section !=
                                    state.favoriteSections[index]) {
                                  bloc.add(HomeChangeSectionEvent(
                                      state.favoriteSections[index]));
                                }
                              },
                              child: Text(
                                state.favoriteSections[index],
                                style: const TextStyle(color: Colors.black),
                              ),
                            ),
                          );
                        },
                        itemCount: state.favoriteSections.length,
                      )),
                  actions: [
                    DropdownButton(
                      hint: Text(state.section),
                        items: state.sections
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? section) {
                          bloc.add(HomeChangeSectionEvent(section.toString()));
                        })
                  ],
                ),
              ),
              StoriesList(state.list.isEmpty ? [] : state.list, context, state.list.isEmpty ? 0 : state.listItem),
              StoriesPagination(state.list.isEmpty ? 0 : state.pages, state.list.isEmpty ? 0 : state.page, context, bloc),

            ],

          );}
        );

      } else {
        return Container();
      }
    });
  }
}

Stream<List<Story>> getStoriesStream(String _section) async* {
  while(true) {
    print('is working');
    await Future.delayed(const Duration(milliseconds: 5000));
    yield await GetStories(StoryRepositoryImpl(
        StoryRemoteDataSources(), StoryLocalDataSources(), ConnectionInfo()), _section).getStories();
  }
}
