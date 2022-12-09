import 'package:flutter/material.dart';
import 'package:top_stories_test/data/datasources/connection_info.dart';
import 'package:top_stories_test/data/datasources/local_datasources/story_local_datasources.dart';
import 'package:top_stories_test/data/datasources/remote_datasources/story_remote_datasources.dart';
import 'package:top_stories_test/data/repository/story_repository.dart';
import 'package:top_stories_test/domain/usecases/get_favorite_section.dart';
import 'package:top_stories_test/domain/usecases/get_local_stories.dart';
import 'package:top_stories_test/domain/usecases/get_remote_stories.dart';
import 'package:top_stories_test/domain/usecases/get_stories.dart';
import 'package:top_stories_test/notifications.dart';
import 'package:top_stories_test/presentation/view/home_page.dart';
import 'package:workmanager/workmanager.dart';

Future<void> callbackDispatcher() async {
  Workmanager().executeTask((taskName, inputData) async {
    Notifications.initNotifications();
    var favoriteSections = await GetFavoriteSection.getFavoriteSections();
    if(favoriteSections.isNotEmpty) {
      for(var section in favoriteSections) {
        try {
          await StoryLocalDataSources.initDB();
          var db = StoryLocalDataSources();
          var remoteData = await GetRemoteStories(StoryRepositoryImpl(
              StoryRemoteDataSources(), StoryLocalDataSources(),
              ConnectionInfo()), section).getRemoteStories();
          var localData = await GetLocalStories(StoryRepositoryImpl(
              StoryRemoteDataSources(), StoryLocalDataSources(),
              ConnectionInfo()), section).getLocalStories();
          if (remoteData.first.title != localData.first.title) {
            db.setBox(remoteData, section);
            Notifications.pushNotification(
                section, remoteData.first.title, 0);
          }
        } catch(_){
          Notifications.pushNotification(
              '', '', 1);
        }
      }
    }
    return Future.value(true);
  });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StoryLocalDataSources.initDB();
  await GetFavoriteSection.getFavoriteSections();
  Notifications.initNotifications();
  await Workmanager().initialize(callbackDispatcher, isInDebugMode: true);
  await Workmanager().registerPeriodicTask("workertask", "workertask",
      frequency: const Duration(minutes: 15),);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'THE NEW YORK TIMES',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: MaterialColor(0xFFFFFFFF, color),
      ),
      home: const Home(),
    );
  }
}

Map<int, Color> color = {
  50: const Color.fromRGBO(255, 255, 255, .1),
  100: const Color.fromRGBO(255, 255, 255, .2),
  200: const Color.fromRGBO(255, 255, 255, .3),
  300: const Color.fromRGBO(255, 255, 255, .4),
  400: const Color.fromRGBO(255, 255, 255, .5),
  500: const Color.fromRGBO(255, 255, 255, .6),
  600: const Color.fromRGBO(255, 255, 255, .7),
  700: const Color.fromRGBO(255, 255, 255, .8),
  800: const Color.fromRGBO(255, 255, 255, .9),
  900: const Color.fromRGBO(255, 255, 255, 1),
};

//api-key fe2acc72-21ce-44ea-b7f3-8f09d6042d50