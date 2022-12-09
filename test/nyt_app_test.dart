import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:top_stories_test/data/datasources/connection_info.dart';
import 'package:top_stories_test/data/datasources/local_datasources/story_local_datasources.dart';
import 'package:top_stories_test/data/datasources/remote_datasources/story_remote_datasources.dart';
import 'package:top_stories_test/data/repository/story_repository.dart';
import 'package:top_stories_test/domain/usecases/get_remote_stories.dart';

import 'test_helper.dart';

@GenerateMocks([GetRemoteStoriesMock])
void main(){

  group('test nyt app', () {
    test('anything testing', () async {
    var list = await GetRemoteStories(StoryRepositoryImpl(
        StoryRemoteDataSources(), StoryLocalDataSources(),
        ConnectionInfo()), 'home').getRemoteStories();
    var _list = GetRemoteStoriesMock().getRemoteStories();
    expect(_list, list);
    });

  });

  
}

