import 'package:ditonton/data/models/movie_models/genre_model.dart';
import 'package:ditonton/data/models/movie_models/movie_table.dart';
import 'package:ditonton/data/models/tv_models/createdby_model.dart';
import 'package:ditonton/data/models/tv_models/episode_to_air_model.dart';
import 'package:ditonton/data/models/tv_models/network_model.dart';
import 'package:ditonton/data/models/tv_models/production_country_model.dart';
import 'package:ditonton/data/models/tv_models/season_model.dart';
import 'package:ditonton/data/models/tv_models/spoken_language_model.dart';
import 'package:ditonton/data/models/tv_models/tv_detail_model.dart';
import 'package:ditonton/data/models/tv_models/tv_model.dart';
import 'package:ditonton/data/models/tv_models/tv_response.dart';
import 'package:ditonton/data/models/tv_models/tv_table.dart';
import 'package:ditonton/domain/entities/movie_entities/genre.dart';
import 'package:ditonton/domain/entities/movie_entities/movie.dart';
import 'package:ditonton/domain/entities/movie_entities/movie_detail.dart';
import 'package:ditonton/domain/entities/tv_entities/created_by.dart';
import 'package:ditonton/domain/entities/tv_entities/episode_to_air.dart';
import 'package:ditonton/domain/entities/tv_entities/network.dart';
import 'package:ditonton/domain/entities/tv_entities/production_country.dart';
import 'package:ditonton/domain/entities/tv_entities/season.dart';
import 'package:ditonton/domain/entities/tv_entities/spoken_language.dart';
import 'package:ditonton/domain/entities/tv_entities/tv.dart';
import 'package:ditonton/domain/entities/tv_entities/tv_detail.dart';

final testMovie = Movie(
  adult: false,
  backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
  genreIds: [14, 28],
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

final testMovieDetail = MovieDetail(
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

final testMovieTable = MovieTable(
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

final testMovieCache = MovieTable(
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

final testTVModel = TVModel(
  backdropPath: '/path.jpg',
  firstAirDate: 'firstAirDate',
  genreIds: [1, 2, 3],
  id: 1,
  name: 'name',
  originCountry: ['originCountry'],
  originalLanguage: 'originalLanguage',
  originalName: 'originalName',
  overview: 'overview',
  popularity: 9.9,
  posterPath: '/path.jpg',
  voteAverage: 9.9,
  voteCount: 1,
);

final testTVModelList = [testTVModel];
final testTVList = [testTVEntity];

final testTVModelResponse = TvResponse(tvList: testTVModelList);

final testTVEntity = TV(
  backdropPath: '/path.jpg',
  firstAirDate: 'firstAirDate',
  genreIds: [1, 2, 3],
  id: 1,
  name: 'name',
  originCountry: ['originCountry'],
  originalLanguage: 'originalLanguage',
  originalName: 'originalName',
  overview: 'overview',
  popularity: 9.9,
  posterPath: '/path.jpg',
  voteAverage: 9.9,
  voteCount: 1,
);

final testTvDetail = TVDetail(
  backdropPath: 'backdropPath',
  createdBy: [
    CreatedBy(
      id: 5,
      creditId: 'creditId',
      name: 'name',
      gender: 0,
      profilePath: 'profilePath',
    ),
  ],
  episodeRunTime: [30],
  firstAirDate: "2021-01-01",
  genres: [Genre(id: 4, name: 'action')],
  homepage: 'homepage',
  id: 1,
  inProduction: false,
  languages: ['languages'],
  lastAirDate: "2021-01-01",
  lastEpisodeToAir: TEpisodeToAir(
    airDate: "2021-01-01",
    episodeNumber: 12,
    id: 44,
    name: 'name',
    overview: 'overview',
    productionCode: 'productionCode',
    seasonNumber: 1,
    stillPath: 'stillPath',
    voteAverage: 5.5,
    voteCount: 5,
  ),
  name: 'name',
  nextEpisodeToAir: null,
  networks: [
    Network(
      name: 'name',
      id: 2,
      logoPath: 'logoPath',
      originCountry: 'originCountry',
    ),
  ],
  numberOfEpisodes: 12,
  numberOfSeasons: 1,
  originCountry: ['originCountry'],
  originalLanguage: 'originalLanguage',
  originalName: 'originalName',
  overview: 'overview',
  popularity: 8.8,
  posterPath: '/path.jpg',
  productionCompanies: [
    Network(
      name: 'name',
      id: 5,
      logoPath: 'logoPath',
      originCountry: 'originCountry',
    ),
  ],
  productionCountries: [
    ProductionCountry(iso31661: 'iso31661', name: 'name'),
  ],
  seasons: [
    Season(
      airDate: "2021-01-01",
      episodeCount: 12,
      id: 55,
      name: 'name',
      overview: 'overview',
      posterPath: 'posterPath',
      seasonNumber: 1,
    ),
  ],
  spokenLanguages: [
    SpokenLanguage(
        englishName: 'englishName', iso6391: 'iso6391', name: 'name'),
  ],
  status: 'status',
  tagline: 'tagline',
  type: 'type',
  voteAverage: 9.9,
  voteCount: 200,
);

final testTvDetailResponse = TvDetailResponse(
  backdropPath: 'backdropPath',
  createdBy: [
    CreatedByModel(
      id: 5,
      creditId: 'creditId',
      name: 'name',
      gender: 0,
      profilePath: 'profilePath',
    ),
  ],
  episodeRunTime: [30],
  firstAirDate: "2021-01-01",
  genres: [GenreModel(id: 4, name: 'action')],
  homepage: 'homepage',
  id: 1,
  inProduction: false,
  languages: ['languages'],
  lastAirDate: "2021-01-01",
  lastEpisodeToAir: TEpisodeToAirModel(
    airDate: "2021-01-01",
    episodeNumber: 12,
    id: 44,
    name: 'name',
    overview: 'overview',
    productionCode: 'productionCode',
    seasonNumber: 1,
    stillPath: 'stillPath',
    voteAverage: 5.5,
    voteCount: 5,
  ),
  name: 'name',
  nextEpisodeToAir: null,
  networks: [
    NetworkModel(
      name: 'name',
      id: 2,
      logoPath: 'logoPath',
      originCountry: 'originCountry',
    ),
  ],
  numberOfEpisodes: 12,
  numberOfSeasons: 1,
  originCountry: ['originCountry'],
  originalLanguage: 'originalLanguage',
  originalName: 'originalName',
  overview: 'overview',
  popularity: 8.8,
  posterPath: '/path.jpg',
  productionCompanies: [
    NetworkModel(
      name: 'name',
      id: 5,
      logoPath: 'logoPath',
      originCountry: 'originCountry',
    ),
  ],
  productionCountries: [
    ProductionCountryModel(iso31661: 'iso31661', name: 'name'),
  ],
  seasons: [
    SeasonModel(
      airDate: "2021-01-01",
      episodeCount: 12,
      id: 55,
      name: 'name',
      overview: 'overview',
      posterPath: 'posterPath',
      seasonNumber: 1,
    ),
  ],
  spokenLanguages: [
    SpokenLanguageModel(
        englishName: 'englishName', iso6391: 'iso6391', name: 'name'),
  ],
  status: 'status',
  tagline: 'tagline',
  type: 'type',
  voteAverage: 9.9,
  voteCount: 200,
);

final testWatchlistTV = TV.watchlist(
  id: 1,
  overview: 'overview',
  posterPath: '/path.jpg',
  name: 'name',
);

final testTVTable = TVTable(
  id: 1,
  name: 'name',
  posterPath: '/path.jpg',
  overview: 'overview',
);

final testTVMap = {
  'id': 1,
  'name': 'name',
  'posterPath': '/path.jpg',
  'overview': 'overview',
};

final testTVCache = TVTable(
  id: 1,
  name: 'name',
  posterPath: '/path.jpg',
  overview: 'overview',
);

final testTVCacheMap = {
  'id': 1,
  'name': 'name',
  'posterPath': '/path.jpg',
  'overview': 'overview',
};

final testTVFromCache = TV.watchlist(
  id: 1,
  overview: 'overview',
  posterPath: '/path.jpg',
  name: 'name',
);
