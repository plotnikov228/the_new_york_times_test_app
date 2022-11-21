import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_stories_test/domain/entities/story.dart';
import 'package:top_stories_test/presentation/bloc/search_bloc/bloc.dart';
import 'package:top_stories_test/presentation/bloc/search_bloc/state.dart';
import 'package:top_stories_test/presentation/widget/search_bloc_builder.dart';

class StorySearch extends StatelessWidget {
  final List<Story> loadedList;
  const StorySearch({Key? key, required this.loadedList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => SearchBloc(SearchLoadingState(), loadedList),
        child: const Scaffold(
            body: SearchBlocBuilder()
        ));
  }
}
