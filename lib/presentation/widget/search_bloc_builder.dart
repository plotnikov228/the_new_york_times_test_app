import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_stories_test/domain/entities/story.dart';
import 'package:top_stories_test/presentation/bloc/search_bloc/bloc.dart';
import 'package:top_stories_test/presentation/bloc/search_bloc/event.dart';
import 'package:top_stories_test/presentation/bloc/search_bloc/state.dart';
import 'package:top_stories_test/presentation/widget/search_pagination.dart';
import 'package:top_stories_test/presentation/widget/stories_list.dart';

class SearchBlocBuilder extends StatelessWidget {
  const SearchBlocBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SearchBloc bloc = context.read<SearchBloc>();
    return BlocBuilder<SearchBloc, SearchState>(builder: (context, state) {
      if (state is SearchLoadingState) {
        return CustomScrollView(
          slivers: [
            SliverAppBar(
              title: const Text('Search'),
              floating: true,
              elevation: 5,
              bottom: AppBar(
                automaticallyImplyLeading: false,
                title: Container(
                  width: double.infinity,
                  height: 40,
                  color: Colors.white,
                  child: Center(
                    child: TextField(
                      onChanged: (text) {
                        state.query = text;
                      },
                      onSubmitted: (text) {
                        state.query = text;
                        bloc.add(SearchingEvent(state.query));
                      },
                      decoration: InputDecoration(
                        labelText: state.query,
                        hintText: 'Search for something',
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.search),
                          onPressed: () {
                            bloc.add(SearchingEvent(state.query));
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            )
          ],
        );
      }
      if (state is SearchLoadedState) {
        return CustomScrollView(
          slivers: [
            SliverAppBar(
              title: const Text('Search'),
              floating: true,
              elevation: 5,
              bottom: AppBar(
                automaticallyImplyLeading: false,
                title: Container(
                  width: double.infinity,
                  height: 40,
                  color: Colors.white,
                  child: Center(
                    child: TextField(
                      onChanged: (text) {
                        state.query = text;
                      },
                      onSubmitted: (text) {
                        if (text.isNotEmpty) {
                          state.query = text;
                          bloc.add(SearchingEvent(state.query));
                        }
                      },
                      decoration: InputDecoration(
                        hintText: 'Search for something',
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.search),
                          onPressed: () {
                            bloc.add(SearchingEvent(state.query));
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            StoriesList(state.list, context, state.listItem),
            SearchPagination(state.pages, state.page, context, bloc),
          ],
        );
      }
      if (state is SearchSetupState) {
        return CustomScrollView(
          slivers: [
            SliverAppBar(
              title: const Text('Search'),
              floating: true,
              bottom: AppBar(
                automaticallyImplyLeading: false,
                title: Container(
                  width: double.infinity,
                  height: 40,
                  color: Colors.white,
                  child: Center(
                    child: TextField(
                      onChanged: (text) {
                        state.query = text;
                      },
                      onSubmitted: (text) {
                        if (text.isNotEmpty) {
                          state.query = text;
                          bloc.add(SearchingEvent(text));
                        }
                      },
                      decoration: InputDecoration(
                        hintText: 'Search for something',
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.search),
                          onPressed: () {
                            bloc.add(SearchingEvent(state.query));
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      } else {
        return Container();
      }
    });
  }
}
