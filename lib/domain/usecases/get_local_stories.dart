import 'package:top_stories_test/data/model/story_model.dart';
import 'package:top_stories_test/domain/entities/story.dart';
import 'package:top_stories_test/domain/repository/story_repository.dart';

class GetLocalStories {
  final StoryRepository storyRepository;
  final String section;

  GetLocalStories(this.storyRepository, this.section);

  Future<List<StoryModel>> getLocalStories () async {
    return await storyRepository.getLocalStories(section);
  }
}