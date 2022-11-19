import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_stories_test/domain/usecases/get_favorite_section.dart';
import 'package:top_stories_test/domain/usecases/get_sections.dart';
import 'package:top_stories_test/presentation/bloc/home_bloc/bloc.dart';
import 'package:top_stories_test/presentation/bloc/home_bloc/event.dart';
import 'package:top_stories_test/presentation/bloc/home_bloc/state.dart';
import 'package:top_stories_test/presentation/widget/stories_bloc_builder.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => HomeBloc(GetSections.sections)
          ..add(HomeLoadEvent()),
        child: const Scaffold(body: StoriesBlocBuilder()));
  }
}
