import 'package:top_stories_test/domain/entitye/multimedia.dart';

class MultimediaModel{
  final String url;
  final String format;
  final int height;
  final int width;
  final String type;
  final String subtype;
  final String caption;
  final String copyright;

  MultimediaModel(
      {required this.url,
      required this.format,
      required this.height,
      required this.width,
      required this.type,
      required this.subtype,
      required this.caption,
      required this.copyright});

  factory MultimediaModel.fromJson(Map<String, dynamic> json) {
    return MultimediaModel(
        url: json['url'],
        format: json['format'],
        height: json['height'],
        width: json['width'],
        type: json['type'],
        subtype: json['subtype'],
        caption: json['caption'],
        copyright: json['copyright']);
  }

  Map<String, dynamic> toJson() {
    return {
      'format': format,
      'url': url,
      'height': height,
      'width': width,
      'type': type,
      'subtype': subtype,
      'caption': caption,
      'copyright': copyright,
    };
  }
}
