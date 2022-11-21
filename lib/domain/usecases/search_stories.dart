import 'package:top_stories_test/domain/entities/story.dart';

import '../repository/story_repository.dart';

class SearchStories {
  final StoryRepository storyRepository;
  List<Story> list;
  final String query;

  SearchStories(this.storyRepository, this.query, this.list);

  Future<List<Story>> searchStories () async {
    return await storyRepository.searchStories(list, query);
  }
}