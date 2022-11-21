import 'package:top_stories_test/data/datasources/connection_info.dart';
import 'package:top_stories_test/data/datasources/local_datasources/story_local_datasources.dart';
import 'package:top_stories_test/data/datasources/remote_datasources/story_remote_datasources.dart';
import 'package:top_stories_test/data/mapper/story_mapper.dart';
import 'package:top_stories_test/data/model/story_model.dart';
import 'package:top_stories_test/domain/entities/story.dart';
import 'package:top_stories_test/domain/repository/story_repository.dart';

class StoryRepositoryImpl implements StoryRepository {
  final StoryRemoteDataSources storyRemoteDataSources;
  final StoryLocalDataSources storyLocalDataSources;
  final ConnectionInfo connectionInfo;

  StoryRepositoryImpl(this.storyRemoteDataSources, this.storyLocalDataSources,
      this.connectionInfo);

  @override
  Future<List<Story>> getStories(String section) async {
    List<StoryModel> _list = [];
    try {
      _list = await storyRemoteDataSources.getStories(section);
      connectionInfo.connection = true;
      print("all okey1");
      if (_list.isNotEmpty) {
        if (section == 'home') {
          List<StoryModel> _localList = await storyLocalDataSources.getBox();
          print("all okey2");
          if (_localList.isNotEmpty) {
            await storyLocalDataSources.deleteBox();
            await storyLocalDataSources.setBox(_list);
            print("all okey3 is not empty");
          } else {
            await storyLocalDataSources.setBox(_list);
            print("all okey3 is empty");
          }
        }
      }
      print(connectionInfo.connection);
    } catch (_) {
      connectionInfo.connection = false;
      print(connectionInfo.connection);
      _list = await storyLocalDataSources.getBox();
    }
    return _list.map((e) => StoryMapper.fromJson(e)).toList();
  }

  @override
  Future<List<Story>> searchStories(
      List<Story> list, String query) async {
    List<Story> searchList = [];
    if (query.isNotEmpty) {
      for (var element in list) {
        if (element.section == query) {
          searchList.add(element);
        }
        else {
          if (element.title.contains(query)) {
            searchList.add(element);
          }
        }
      }
    }
    return searchList;
  }
}
