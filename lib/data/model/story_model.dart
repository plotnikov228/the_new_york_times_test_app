import 'dart:typed_data';

import 'package:top_stories_test/data/model/multimedia_model.dart';

class StoryModel{
  @override
  final String section;
  final String subsection;
  final String title;
  final String abstract;
  final String url;
  final String uri;
  final String byline;
  final String itemType;
  final String updatedDate;
  final String createdDate;
  final String publishedDate;
  final String materialTypeFacet;
  final String kicker;
  final List<dynamic> desFacet;
  final List<dynamic> orgFacet;
  final List<dynamic> perFacet;
  final List<dynamic> geoFacet;
  final List<dynamic> multimedia;
  final String shortUrl;

  StoryModel({required this.section,
    required this.subsection,
    required this.title,
    required this.abstract,
    required this.url,
    required this.uri,
    required this.byline,
    required this.itemType,
    required this.updatedDate,
    required this.createdDate,
    required this.publishedDate,
    required this.materialTypeFacet,
    required this.kicker,
    required this.desFacet,
    required this.orgFacet,
    required this.perFacet,
    required this.geoFacet,
    required this.multimedia,
    required this.shortUrl});

  factory StoryModel.fromJson(Map<String, dynamic> json){
    return StoryModel(
        section: json['section'],
        subsection: json['subsection'],
        title: json['title'],
        abstract: json['abstract'],
        url: json['url'],
        uri: json['uri'],
        byline: json['byline'],
        itemType: json['item_type'],
        updatedDate: json['updated_date'],
        createdDate: json['created_date'],
        publishedDate: json['published_date'],
        materialTypeFacet: json['material_type_facet'],
        kicker: json['kicker'],
        desFacet: json['des_facet'],
        orgFacet: json['org_facet'],
        perFacet: json['per_facet'],
        geoFacet: json['geo_facet'],
        multimedia: json['multimedia']
            .map((e) => MultimediaModel.fromJson(e))
            .toList(),
        shortUrl: json['short_url']);
  }

  Map<String, dynamic> toJson(){
    return {
      'section' : section,
      'subsection' : subsection,
      'title' : title,
      'abstract' : abstract,
      'url' : url,
      'uri' : uri,
      'byline' : byline,
      'item_type' : itemType,
      'update_date' : updatedDate,
      'create_date' : createdDate,
      'published_date' : publishedDate,
      'material_type_facet' : materialTypeFacet,
      'kicker' : kicker,
      'des_facet' : desFacet,
      'org_facet' : orgFacet,
      'per_facet' : perFacet,
      'geo_facet' : geoFacet,
      'multimedia' : multimedia,
      'short_url' : shortUrl
    };
  }
}
