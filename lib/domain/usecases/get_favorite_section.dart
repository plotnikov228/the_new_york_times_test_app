import 'package:shared_preferences/shared_preferences.dart';

class GetFavoriteSection {
  static List<String> favoriteSections = [];

  static Future getFavoriteSections () async {
    final prefs = await SharedPreferences.getInstance();
    print(prefs.getStringList('items'));
    if( prefs.getStringList('items') != null) {
      favoriteSections = prefs.getStringList('items')!;
      print(favoriteSections.length);
    }
  }

  static Future setFavoriteSections (List<String> list) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('items', list);
  }
}