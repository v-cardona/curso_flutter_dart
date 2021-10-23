// To parse this JSON data, do
//
//     final reverseQueryResponse = reverseQueryResponseFromJson(jsonString);

// ignore_for_file: unnecessary_null_comparison

import 'dart:convert';

ReverseQueryResponse reverseQueryResponseFromJson(String str) =>
    ReverseQueryResponse.fromJson(json.decode(str));

String reverseQueryResponseToJson(ReverseQueryResponse data) =>
    json.encode(data.toJson());

class ReverseQueryResponse {
  ReverseQueryResponse({
    required this.type,
    required this.query,
    required this.features,
    required this.attribution,
  });

  String type;
  List<double> query;
  List<Feature> features;
  String attribution;

  factory ReverseQueryResponse.fromJson(Map<String, dynamic> json) =>
      ReverseQueryResponse(
        type: json["type"],
        query: List<double>.from(json["query"].map((x) => x.toDouble())),
        features: List<Feature>.from(
            json["features"].map((x) => Feature.fromJson(x))),
        attribution: json["attribution"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "query": List<dynamic>.from(query.map((x) => x)),
        "features": List<dynamic>.from(features.map((x) => x.toJson())),
        "attribution": attribution,
      };
}

class Feature {
  Feature({
    required this.id,
    required this.type,
    required this.placeType,
    required this.relevance,
    required this.properties,
    required this.textEs,
    required this.placeNameEs,
    required this.text,
    required this.placeName,
    required this.center,
    required this.geometry,
    required this.address,
    required this.context,
    required this.bbox,
    required this.languageEs,
    required this.language,
  });

  String id;
  String type;
  List<String> placeType;
  int relevance;
  Properties properties;
  String textEs;
  String placeNameEs;
  String text;
  String placeName;
  List<double> center;
  Geometry geometry;
  String address;
  List<Context> context;
  List<double> bbox;
  Language languageEs;
  Language language;

  factory Feature.fromJson(Map<String, dynamic> json) => Feature(
        id: json["id"],
        type: json["type"],
        placeType: List<String>.from(json["place_type"].map((x) => x)),
        relevance: json["relevance"],
        properties: Properties.fromJson(json["properties"]),
        textEs: json["text_es"],
        placeNameEs: json["place_name_es"],
        text: json["text"],
        placeName: json["place_name"],
        center: List<double>.from(json["center"].map((x) => x.toDouble())),
        geometry: Geometry.fromJson(json["geometry"]),
        address: json["address"] ?? '',
        context: json["context"] == null
            ? []
            : List<Context>.from(
                json["context"].map((x) => Context.fromJson(x))),
        bbox: json["bbox"] == null
            ? []
            : List<double>.from(json["bbox"].map((x) => x.toDouble())),
        languageEs: languageValues.map[json["language_es"]] ?? Language.ES,
        language: languageValues.map[json["language"]] ?? Language.ES,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "place_type": List<dynamic>.from(placeType.map((x) => x)),
        "relevance": relevance,
        "properties": properties.toJson(),
        "text_es": textEs,
        "place_name_es": placeNameEs,
        "text": text,
        "place_name": placeName,
        "center": List<dynamic>.from(center.map((x) => x)),
        "geometry": geometry.toJson(),
        "address": address,
        "context": context,
        "bbox": bbox,
        "language_es": languageEs,
        "language": language,
      };
}

class Context {
  Context({
    required this.id,
    required this.textEs,
    required this.text,
    required this.wikidata,
    required this.languageEs,
    required this.language,
    required this.shortCode,
  });

  String id;
  String textEs;
  String text;
  Wikidata wikidata;
  Language languageEs;
  Language language;
  ShortCode shortCode;

  factory Context.fromJson(Map<String, dynamic> json) => Context(
        id: json["id"],
        textEs: json["text_es"],
        text: json["text"],
        wikidata: wikidataValues.map[json["wikidata"]] ?? Wikidata.Q11299,
        languageEs: languageValues.map[json["language_es"]] ?? Language.ES,
        language: languageValues.map[json["language"]] ?? Language.ES,
        shortCode: shortCodeValues.map[json["short_code"]] ?? ShortCode.US,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "text_es": textEs,
        "text": text,
        "wikidata": wikidata,
        "language_es": languageEs,
        "language": language,
        "short_code": shortCode,
      };
}

enum Language { ES }

final languageValues = EnumValues({"es": Language.ES});

enum ShortCode { US_NY, US }

final shortCodeValues =
    EnumValues({"us": ShortCode.US, "US-NY": ShortCode.US_NY});

enum Wikidata { Q11299, Q60, Q1384, Q30 }

final wikidataValues = EnumValues({
  "Q11299": Wikidata.Q11299,
  "Q1384": Wikidata.Q1384,
  "Q30": Wikidata.Q30,
  "Q60": Wikidata.Q60
});

class Geometry {
  Geometry({
    required this.type,
    required this.coordinates,
  });

  String type;
  List<double> coordinates;

  factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
        type: json["type"],
        coordinates:
            List<double>.from(json["coordinates"].map((x) => x.toDouble())),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "coordinates": List<dynamic>.from(coordinates.map((x) => x)),
      };
}

class Properties {
  Properties({
    required this.accuracy,
    required this.wikidata,
    required this.shortCode,
  });

  String accuracy;
  Wikidata wikidata;
  ShortCode shortCode;

  factory Properties.fromJson(Map<String, dynamic> json) => Properties(
        accuracy: json["accuracy"],
        wikidata: wikidataValues.map[json["wikidata"]] ?? Wikidata.Q11299,
        shortCode: shortCodeValues.map[json["short_code"]] ?? ShortCode.US,
      );

  Map<String, dynamic> toJson() => {
        "accuracy": accuracy,
        "wikidata": wikidata,
        "short_code": shortCode,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String>? get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
