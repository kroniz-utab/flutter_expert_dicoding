import 'dart:convert';

import 'package:core/data/models/tv_models/tv_detail_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../dummy_data/dummy_objects_tv.dart';
import '../../../json_reader.dart';

void main() {
  test('should be a subclass of tv detail entity', () {
    final result = testTvDetailResponse.toEntity();
    expect(result, testTvDetail);
  });

  test('should return a JSON map containing proper data', () async {
    final result = testTvDetailResponse.toJson();
    expect(result, testTvDetailResponseMap);
  });

  test('should return a valid model from json', () async {
    // arange
    final Map<String, dynamic> jsonMap =
        jsonDecode(readJson('dummy_data/tv_detail.json'));
    // act
    final result = TvDetailResponse.fromJson(jsonMap);
    // assert
    expect(result, testTvDetailResponse);
  });
}
