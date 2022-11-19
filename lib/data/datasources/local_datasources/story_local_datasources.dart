import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:top_stories_test/data/model/story_model.dart';
import 'package:path_provider/path_provider.dart' as path;

class StoryLocalDataSources {
  final Box box = Hive.box("list");
  static late Box staticBox;

  static Future initDB () async{
    var _dir = await path.getApplicationDocumentsDirectory();
    Hive.init(_dir.path);
    await Hive.openBox("list");
    staticBox =  Hive.box("list");
  }

  Future setBox(List<StoryModel> model) async {
    for(var item in model) {
      box.add(jsonEncode(item.toJson()));
    }
  }

  Future deleteBox() async {
    await box.clear();
  }

  Future<List<StoryModel>> getBox() async {
    List<dynamic> storyJson = [];
    List<StoryModel> list = [];
    for(int i = 0; i < box.length; i++){
      storyJson.add(jsonDecode(box.getAt(i)!));
    }
    for(var item in storyJson){
      list.add(StoryModel.fromJson(item));
    }
    return list;
  }
}
