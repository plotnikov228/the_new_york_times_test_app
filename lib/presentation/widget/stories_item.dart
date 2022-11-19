import 'package:flutter/material.dart';
import 'package:top_stories_test/domain/entitye/story.dart';
import 'package:top_stories_test/presentation/view/story_page.dart';

Widget StoryItem(Story story, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(8, 16, 8, 16),
    child: Card(
      elevation: 0.1,
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => StoryPage(url: story.url)));
        },
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
                padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                child: SizedBox(
                  width: double.infinity,
                  child: Text(
                    story.title,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                )),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
              child: Container(
                width: double.infinity,
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      'section: ',
                      style:
                          TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                    ),
                    Text(story.section, style: const TextStyle(fontSize: 11))
                  ],
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    story.multimedia.first.url,
                    errorBuilder: (context, exception, stackTrace) {
                      return Image.asset('assets/image_for_loading_image.jpg');
                    },
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Image.asset('assets/image_for_loading_image.jpg');
                    },
                  ),
                )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: double.infinity,
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      'published in: ',
                      style:
                          TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                    ),
                    Text(
                        '${story.publishedDate?.year}.${story.publishedDate?.month}.${story.publishedDate?.day}  '
                            '${story.publishedDate?.hour.toString().length != 1 ? story.publishedDate?.hour : '0${story.publishedDate?.hour}'}:'
                        '${story.publishedDate?.minute.toString().length != 1 ? story.publishedDate?.minute : '0${story.publishedDate?.minute}'}:'
                            '${story.publishedDate?.second.toString().length != 1 ? story.publishedDate?.second : '0${story.publishedDate?.second}'}',
                        style: const TextStyle(fontSize: 10))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    ),
  );
}
