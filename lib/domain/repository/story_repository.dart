import 'package:top_stories_test/data/model/story_model.dart';
import 'package:top_stories_test/domain/entities/story.dart';

abstract class StoryRepository {

  Future<List<Story>> getStories (String section);

  Future<List<StoryModel>> getRemoteStories (String section);

  Future<List<StoryModel>> getLocalStories (String section);

  Future<List<Story>> searchStories (List<Story> list,String query);

}