import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_stories_test/presentation/bloc/home_bloc/event.dart';

Widget StoriesLoadingSliverWidget (Bloc bloc, String section, List<String> favoriteSections, List<String> sections) {
  return CustomScrollView(
    slivers: [
      SliverAppBar(
        title: Text(section),
        floating: true,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(favoriteSections.contains(section)
                ? Icons.remove
                : Icons.add),
            onPressed: () {
              bloc.add(HomeChangeSectionEvent(section));
            },
          ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          )
        ],
        bottom: AppBar(
            automaticallyImplyLeading: false,
            actions: [
              DropdownButton(
                  hint: Text(section),
                  items: sections
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
                          if (section != favoriteSections[index]) {
                            bloc.add(HomeChangeSectionEvent(
                                favoriteSections[index]));
                          }
                        },
                        child: Text(
                          favoriteSections[index],
                          style: const TextStyle(color: Colors.black),
                        ),
                      ),
                    );
                  },
                  itemCount: favoriteSections.length,
                ))),
      ),
      SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            return Container(
                width: 500,
                height: 500,
                child: const Center(
                    child: CircularProgressIndicator(
                      color: Colors.black,
                    )));
          }, childCount: 1))
    ],
  );
}