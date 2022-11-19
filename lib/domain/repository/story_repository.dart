import 'package:top_stories_test/domain/entitye/story.dart';

abstract class StoryRepository {

  Future<List<Story>> getStories (String section);

  Future<List<Story>> searchStories (List<Story> list,String query);

}