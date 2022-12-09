import 'package:top_stories_test/data/model/story_model.dart';
import 'package:top_stories_test/domain/entities/story.dart';
import 'package:top_stories_test/domain/repository/story_repository.dart';

class GetRemoteStories {
  final StoryRepository storyRepository;
  final String section;

  GetRemoteStories(this.storyRepository, this.section);

  Future<List<StoryModel>> getRemoteStories () async {
    return await storyRepository.getRemoteStories(section);
  }
}