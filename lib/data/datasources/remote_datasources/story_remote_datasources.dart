import 'dart:convert';

import 'package:top_stories_test/data/model/story_model.dart';
import 'package:http/http.dart' as http;

import '../../../domain/entities/story.dart';

class StoryRemoteDataSources {
  final String apiKey = 'VeBcN1xA7YTXSiKVeGZGATP585TdJKfL';

  Future<List<StoryModel>> getStories(String tag) async {
    final response =
        await http.get(Uri.parse('https://api.nytimes.com/svc/topstories/v2/$tag.json?api-key=$apiKey'));
    if (response.statusCode == 200) {
      List<StoryModel> _list = [];
      print("response.statusCode == 200");
      final List<dynamic> storyJson = jsonDecode(utf8.decode(response.bodyBytes))['results'];
      print("all okey");
      for(int i = 0; i < storyJson.length; i++) {
        _list.add(StoryModel.fromJson(storyJson[i]));
      }
      return _list;
    } else {
      print("all not okey");
      throw Exception('Error fetching');
    }
  }
}
