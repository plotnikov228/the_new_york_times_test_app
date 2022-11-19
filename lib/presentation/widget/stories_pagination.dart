import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_stories_test/domain/entitye/story.dart';
import 'package:top_stories_test/presentation/bloc/home_bloc/event.dart';

Widget StoriesPagination(int pages, int selectedPage, BuildContext context, Bloc bloc,) {
  return SliverGrid(delegate: SliverChildBuilderDelegate(
        (context, index) {
      return SizedBox(
        width: 20,
        height: 20,
        child: ElevatedButton(
          onPressed: () {
            bloc.add(HomeChangePageEvent(index + 1));
          },
          style: ElevatedButton.styleFrom(
            primary: selectedPage == index + 1 ? Colors.black : Colors.white,
          ),
          child: Center(
            child: Text((index + 1).toString(), style: TextStyle(color: selectedPage == index + 1 ? Colors.white : Colors.black),),
          ),
        ),
      );
    },
    childCount: pages,
  ),
    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 50),


  );
}
