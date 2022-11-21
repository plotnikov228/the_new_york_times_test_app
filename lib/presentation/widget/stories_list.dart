import 'package:flutter/material.dart';
import 'package:top_stories_test/domain/entities/story.dart';
import 'package:top_stories_test/presentation/widget/stories_item.dart';

Widget StoriesList(List<Story> list, BuildContext context, int itemList,) {
return SliverList(
    delegate: SliverChildBuilderDelegate((context, index) {
      return StoryItem(list[index], context);
    },
        childCount: itemList));

}
