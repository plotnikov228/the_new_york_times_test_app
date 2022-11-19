import 'package:top_stories_test/data/mapper/multimedia_mapper.dart';
import 'package:top_stories_test/data/model/multimedia_model.dart';
import 'package:top_stories_test/data/model/story_model.dart';
import 'package:top_stories_test/domain/entitye/story.dart';

class StoryMapper extends Story {
  StoryMapper(
      {required super.section,
      required super.subsection,
      required super.title,
      required super.abstract,
      required super.url,
      required super.uri,
      required super.byline,
      required super.itemType,
      required super.updatedDate,
      required super.createdDate,
      required super.publishedDate,
      required super.materialTypeFacet,
      required super.kicker,
      required super.desFacet,
      required super.orgFacet,
      required super.perFacet,
      required super.geoFacet,
      required super.multimedia,
      required super.shortUrl});

  static Story fromJson(StoryModel json) {
    return Story(
        section: json.section,
        subsection: json.subsection,
        title: json.title,
        abstract: json.abstract,
        url: json.url,
        uri: json.uri,
        byline: json.byline,
        itemType: json.itemType,
        updatedDate: json.updatedDate == null ? null : DateTime.parse(json.updatedDate),
        createdDate: json.createdDate == null ? null : DateTime.parse(json.createdDate),
        publishedDate: json.publishedDate == null ? null : DateTime.parse(json.publishedDate),
        materialTypeFacet: json.materialTypeFacet,
        kicker: json.kicker,
        desFacet: json.desFacet.map((e) => e as String).toList(),
        orgFacet: json.orgFacet.map((e) => e as String).toList(),
        perFacet: json.perFacet.map((e) => e as String).toList(),
        geoFacet: json.geoFacet.map((e) => e as String).toList(),
        multimedia:
            json.multimedia.map((e) => MultimediaMapper.fromJson(e)).toList(),
        shortUrl: json.shortUrl);
  }
}
