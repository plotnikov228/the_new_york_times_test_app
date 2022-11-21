import 'package:top_stories_test/domain/entities/story.dart';
import 'package:top_stories_test/domain/repository/story_repository.dart';

class GetStories {
  final StoryRepository storiesRepository;
  final String section;
  GetStories(this.storiesRepository, this.section);

  Future<List<Story>> getStories () async {
    return await storiesRepository.getStories(section);
  }
}