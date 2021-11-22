import 'dart:convert';

import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../dummy_data/dummy_objects_tv.dart';
import '../../../json_reader.dart';

void main() {
  test('should be a subclass of season detail entity', () {
    final result = testTvSeasonResponse.toEntity();
    expect(result, testTvSeason);
  });

  test('should return a JSON map containing proper data', () async {
    final result = testTvSeasonResponse.toJson();
    expect(result, testTvSeasonResponseMap);
  });

  test('should return a valid model from json', () async {
    // arrange
    final Map<String, dynamic> jsonMap =
        jsonDecode(readJson('dummy_data/tv_season_detail.json'));
    // act
    final result = SeasonDetailModel.fromJson(jsonMap);
    // assert
    expect(result, testTvSeasonResponse);
  });
}
