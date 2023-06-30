// To parse this JSON data, do
//
//     final wordsModel = wordsModelFromMap(jsonString);

import 'dart:convert';

class WordsModel {
  String? word;
  List<Result>? results;
  Syllables? syllables;
  Pronunciation? pronunciation;
  double? frequency;

  WordsModel({
    this.word,
    this.results,
    this.syllables,
    this.pronunciation,
    this.frequency,
  });

  factory WordsModel.fromJson(String str) => WordsModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory WordsModel.fromMap(Map<String, dynamic> json) => WordsModel(
    word: json["word"],
    results: json["results"] == null ? [] : List<Result>.from(json["results"]!.map((x) => Result.fromMap(x))),
    syllables: json["syllables"] == null ? null : Syllables.fromMap(json["syllables"]),
    pronunciation: json["pronunciation"] == null ? null : Pronunciation.fromMap(json["pronunciation"]),
    frequency: json["frequency"]?.toDouble(),
  );

  Map<String, dynamic> toMap() => {
    "word": word,
    "results": results == null ? [] : List<dynamic>.from(results!.map((x) => x.toMap())),
    "syllables": syllables?.toMap(),
    "pronunciation": pronunciation?.toMap(),
    "frequency": frequency,
  };
}

class Pronunciation {
  String? all;

  Pronunciation({
    this.all,
  });

  factory Pronunciation.fromJson(String str) => Pronunciation.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Pronunciation.fromMap(Map<String, dynamic> json) => Pronunciation(
    all: json["all"],
  );

  Map<String, dynamic> toMap() => {
    "all": all,
  };
}

class Result {
  String? definition;
  String? partOfSpeech;
  List<String>? synonyms;
  List<String>? typeOf;
  List<String>? hasTypes;
  List<String>? derivation;
  List<String>? examples;

  Result({
    this.definition,
    this.partOfSpeech,
    this.synonyms,
    this.typeOf,
    this.hasTypes,
    this.derivation,
    this.examples,
  });

  factory Result.fromJson(String str) => Result.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Result.fromMap(Map<String, dynamic> json) => Result(
    definition: json["definition"],
    partOfSpeech: json["partOfSpeech"],
    synonyms: json["synonyms"] == null ? [] : List<String>.from(json["synonyms"]!.map((x) => x)),
    typeOf: json["typeOf"] == null ? [] : List<String>.from(json["typeOf"]!.map((x) => x)),
    hasTypes: json["hasTypes"] == null ? [] : List<String>.from(json["hasTypes"]!.map((x) => x)),
    derivation: json["derivation"] == null ? [] : List<String>.from(json["derivation"]!.map((x) => x)),
    examples: json["examples"] == null ? [] : List<String>.from(json["examples"]!.map((x) => x)),
  );

  Map<String, dynamic> toMap() => {
    "definition": definition,
    "partOfSpeech": partOfSpeech,
    "synonyms": synonyms == null ? [] : List<dynamic>.from(synonyms!.map((x) => x)),
    "typeOf": typeOf == null ? [] : List<dynamic>.from(typeOf!.map((x) => x)),
    "hasTypes": hasTypes == null ? [] : List<dynamic>.from(hasTypes!.map((x) => x)),
    "derivation": derivation == null ? [] : List<dynamic>.from(derivation!.map((x) => x)),
    "examples": examples == null ? [] : List<dynamic>.from(examples!.map((x) => x)),
  };
}

class Syllables {
  int? count;
  List<String>? list;

  Syllables({
    this.count,
    this.list,
  });

  factory Syllables.fromJson(String str) => Syllables.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Syllables.fromMap(Map<String, dynamic> json) => Syllables(
    count: json["count"],
    list: json["list"] == null ? [] : List<String>.from(json["list"]!.map((x) => x)),
  );

  Map<String, dynamic> toMap() => {
    "count": count,
    "list": list == null ? [] : List<dynamic>.from(list!.map((x) => x)),
  };
}
