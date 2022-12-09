import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:top_stories_test/data/model/story_model.dart';
import 'package:path_provider/path_provider.dart' as path;

class StoryLocalDataSources {

  static Future initDB () async{
    var _dir = await path.getApplicationDocumentsDirectory();
    Hive.init(_dir.path);
  }

  Future setBox(List<StoryModel> model, String section) async {
    for(var item in model) {
      Hive.box(section).add(jsonEncode(item.toJson()));
    }
  }

  Future deleteBox( String section) async {
    await Hive.box(section).clear();
  }

  Future<List<StoryModel>> getBox(String section) async {
    await Hive.openBox(section);
    List<dynamic> storyJson = [];
    List<StoryModel> list = [];
    for(int i = 0; i < Hive.box(section).length; i++){
      storyJson.add(jsonDecode(Hive.box(section).getAt(i)!));
    }
    for(var item in storyJson){
      list.add(StoryModel.fromJson(item));
    }
    return list;
  }
}
