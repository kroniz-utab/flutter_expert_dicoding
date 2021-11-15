import 'package:core/core.dart';

const testTVModel = TVModel(
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
  genreIds: const [1, 2, 3],
  id: 1,
  name: 'name',
  originCountry: const ['originCountry'],
  originalLanguage: 'originalLanguage',
  originalName: 'originalName',
  overview: 'overview',
  popularity: 9.9,
  posterPath: '/path.jpg',
  voteAverage: 9.9,
  voteCount: 1,
);

const testTvDetail = TVDetail(
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

const testTvDetailResponse = TvDetailResponse(
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

const testTVTable = TVTable(
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

const testTVCache = TVTable(
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

const testTvSeasonResponse = SeasonDetailModel(
  id: 'stringId',
  airDate: 'airDate',
  episodes: [
    EpisodeModel(
      airDate: 'airDate',
      episodeNumber: 1,
      crew: [
        CrewModel(
          job: 'job',
          department: 'department',
          creditId: 'creditId',
          adult: true,
          gender: 0,
          id: 1,
          knownForDepartment: 'knownForDepartment',
          name: 'name',
          originalName: 'originalName',
          popularity: 12.2,
          profilePath: 'profilePath',
        ),
      ],
      guestStars: [
        GuestStarModel(
          character: 'character',
          creditId: 'creditId',
          order: 1,
          adult: true,
          gender: 1,
          id: 1,
          knownForDepartment: 'knownForDepartment',
          name: 'name',
          originalName: 'originalName',
          popularity: 1,
          profilePath: 'profilePath',
        ),
      ],
      id: 1,
      name: 'name',
      overview: 'overview',
      productionCode: 'productionCode',
      seasonNumber: 1,
      stillPath: 'stillPath',
      voteAverage: 12.2,
      voteCount: 33,
    ),
  ],
  name: 'name',
  overview: 'overview',
  seasonDetailModelId: 1,
  posterPath: 'posterPath',
  seasonNumber: 1,
);

const testTvSeason = SeasonDetail(
  id: 'stringId',
  airDate: 'airDate',
  episodes: [
    Episode(
      airDate: 'airDate',
      episodeNumber: 1,
      crew: [
        Crew(
          job: 'job',
          department: 'department',
          creditId: 'creditId',
          adult: true,
          gender: 0,
          id: 1,
          knownForDepartment: 'knownForDepartment',
          name: 'name',
          originalName: 'originalName',
          popularity: 12.2,
          profilePath: 'profilePath',
        ),
      ],
      guestStars: [
        GuestStar(
          character: 'character',
          creditId: 'creditId',
          order: 1,
          adult: true,
          gender: 1,
          id: 1,
          knownForDepartment: 'knownForDepartment',
          name: 'name',
          originalName: 'originalName',
          popularity: 1,
          profilePath: 'profilePath',
        ),
      ],
      id: 1,
      name: 'name',
      overview: 'overview',
      productionCode: 'productionCode',
      seasonNumber: 1,
      stillPath: 'stillPath',
      voteAverage: 12.2,
      voteCount: 33,
    ),
  ],
  name: 'name',
  overview: 'overview',
  seasonDetailModelId: 1,
  posterPath: 'posterPath',
  seasonNumber: 1,
);
