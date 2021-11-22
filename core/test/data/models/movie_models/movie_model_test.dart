import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../../dummy_data/dummy_objects_movie.dart';

void main() {
  const tMovieModel = MovieModel(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    title: 'title',
    video: false,
    voteAverage: 1,
    voteCount: 1,
  );

  final tMovie = Movie(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: const [1, 2, 3],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    title: 'title',
    video: false,
    voteAverage: 1,
    voteCount: 1,
  );

  test('should be a subclass of Movie entity', () async {
    final result = tMovieModel.toEntity();
    expect(result, tMovie);
  });

  test('should convert movie detail response to json', () {
    final result = testMovieDetailResponse.toJson();
    expect(result, testMovieDetailResponseMap);
  });

  test('should convert movie genre to json', () {
    const testMovieGenre = GenreModel(id: 1, name: 'name');
    final testMovieGenreMap = {'id': 1, 'name': 'name'};
    final result = testMovieGenre.toJson();
    expect(result, testMovieGenreMap);
  });
}
