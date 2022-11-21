import 'package:top_stories_test/data/model/multimedia_model.dart';
import 'package:top_stories_test/domain/entities/multimedia.dart';

class MultimediaMapper extends Multimedia {
  MultimediaMapper(
      {required super.url,
      required super.format,
      required super.height,
      required super.width,
      required super.type,
      required super.subtype,
      required super.caption,
      required super.copyright});

  static Multimedia fromJson(MultimediaModel json) {
    return Multimedia(
      url: json.url,
      format: json.format,
      height: json.height,
      width: json.width,
      type: json.type,
      subtype: json.subtype,
      caption: json.caption,
      copyright: json.copyright,
    );
  }
}
