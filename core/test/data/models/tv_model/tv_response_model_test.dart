import 'dart:convert';

import 'package:core/data/models/tv_models/tv_model.dart';
import 'package:core/data/models/tv_models/tv_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../json_reader.dart';

void main() {
  const tTVModel = TVModel(
    backdropPath: "/path.jpg",
    firstAirDate: "2021-10-12",
    genreIds: [1, 2, 3],
    id: 1,
    name: "title",
    originCountry: ["US"],
    originalLanguage: "en",
    originalName: "original title",
    overview: "overview",
    popularity: 6336.725,
    posterPath: "/path.jpg",
    voteAverage: 8,
    voteCount: 931,
  );

  const tTVResponseModel = TvResponse(tvList: <TVModel>[tTVModel]);

  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/tv_on_the_air_response.json'));
      // act
      final result = TvResponse.fromJson(jsonMap);
      // assert
      expect(result, tTVResponseModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tTVResponseModel.toJson();
      // assert
      final expectedJsonMap = {
        "results": [
          {
            "backdrop_path": "/path.jpg",
            "first_air_date": "2021-10-12",
            "genre_ids": [1, 2, 3],
            "id": 1,
            "name": "title",
            "origin_country": ["US"],
            "original_language": "en",
            "original_name": "original title",
            "overview": "overview",
            "popularity": 6336.725,
            "poster_path": "/path.jpg",
            "vote_average": 8,
            "vote_count": 931
          }
        ],
      };
      expect(result, expectedJsonMap);
    });
  });
}
