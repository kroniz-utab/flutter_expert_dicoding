import 'package:core/core.dart';

final testMovie = Movie(
  adult: false,
  backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
  genreIds: const [14, 28],
  id: 557,
  originalTitle: 'Spider-Man',
  overview:
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  popularity: 60.441,
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  releaseDate: '2002-05-01',
  title: 'Spider-Man',
  video: false,
  voteAverage: 7.2,
  voteCount: 13507,
);

final testMovieList = [testMovie];

const testMovieDetail = MovieDetail(
  adult: false,
  backdropPath: 'backdropPath',
  genres: [Genre(id: 1, name: 'Action')],
  id: 1,
  originalTitle: 'originalTitle',
  overview: 'overview',
  posterPath: 'posterPath',
  releaseDate: 'releaseDate',
  runtime: 120,
  title: 'title',
  voteAverage: 1,
  voteCount: 1,
);

final testWatchlistMovie = Movie.watchlist(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

const testMovieTable = MovieTable(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testMovieMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'title': 'title',
};

const testMovieCache = MovieTable(
  id: 557,
  overview:
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  title: 'Spider-Man',
);

final testMovieCacheMap = {
  'id': 557,
  'overview':
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  'posterPath': '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  'title': 'Spider-Man',
};

final testMovieFromCache = Movie.watchlist(
  id: 557,
  overview:
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  title: 'Spider-Man',
);

const testMovieDetailResponse = MovieDetailResponse(
  adult: true,
  backdropPath: 'backdropPath',
  budget: 1,
  genres: [GenreModel(id: 1, name: 'name')],
  homepage: 'homepage',
  id: 1,
  imdbId: 'imdbId',
  originalLanguage: 'originalLanguage',
  originalTitle: 'originalTitle',
  overview: 'overview',
  popularity: 1.1,
  posterPath: 'posterPath',
  releaseDate: 'releaseDate',
  revenue: 1,
  runtime: 1,
  status: 'status',
  tagline: 'tagline',
  title: 'title',
  video: false,
  voteAverage: 1.1,
  voteCount: 5,
);

final testMovieDetailResponseMap = {
  'adult': true,
  'backdrop_path': 'backdropPath',
  'budget': 1,
  'genres': [
    {'id': 1, 'name': 'name'}
  ],
  'homepage': 'homepage',
  'id': 1,
  'imdb_id': 'imdbId',
  'original_language': 'originalLanguage',
  'original_title': 'originalTitle',
  'overview': 'overview',
  'popularity': 1.1,
  'poster_path': 'posterPath',
  'release_date': 'releaseDate',
  'revenue': 1,
  'runtime': 1,
  'status': 'status',
  'tagline': 'tagline',
  'title': 'title',
  'video': false,
  'vote_average': 1.1,
  'vote_count': 5,
};
