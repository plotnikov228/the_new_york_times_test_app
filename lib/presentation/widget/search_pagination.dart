import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_stories_test/presentation/bloc/search_bloc/event.dart';

Widget SearchPagination(int pages, int selectedPage, BuildContext context, Bloc bloc) {
  return SliverGrid(delegate: SliverChildBuilderDelegate(
        (context, index) {
      return ElevatedButton(
        onPressed: () {
          bloc.add(SearchChangePageEvent(index + 1));
        },
        style: ElevatedButton.styleFrom(
          primary: selectedPage == index + 1 ? Colors.black : Colors.white,
          minimumSize: const Size(40, 40),
          maximumSize: const Size(40, 40),
        ),
        child: Center(
          child: Text((index + 1).toString(), style: TextStyle(color: selectedPage == index + 1 ? Colors.white : Colors.black),),
        ),
      );
    },
    childCount: pages,
  ),
    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 50),


  );
}