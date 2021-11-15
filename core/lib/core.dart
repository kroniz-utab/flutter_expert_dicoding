library core;

/// database
export 'data/datasources/db/database_helper.dart';

/// styles
export 'styles/colors.dart';
export 'styles/text_styles.dart';

/// utils
export 'utils/constants.dart';
export 'utils/exception.dart';
export 'utils/failure.dart';
export 'utils/state_enum.dart';
export 'utils/utils.dart';
export 'utils/routes.dart';

/// datasources
export 'data/datasources/movie_local_data_source.dart';
export 'data/datasources/movie_remote_data_source.dart';
export 'data/datasources/tv_local_data_source.dart';
export 'data/datasources/tv_remote_data_source.dart';

/// repositories
export 'domain/repositories/movie_repository.dart';
export 'domain/repositories/tv_repository.dart';
export 'data/repositories/movie_repository_impl.dart';
export 'data/repositories/tv_repository_impl.dart';

/// models
/// movie models
export 'data/models/movie_models/genre_model.dart';
export 'data/models/movie_models/movie_detail_model.dart';
export 'data/models/movie_models/movie_model.dart';
export 'data/models/movie_models/movie_response.dart';
export 'data/models/movie_models/movie_table.dart';

/// tv models
export 'data/models/tv_models/createdby_model.dart';
export 'data/models/tv_models/crew_model.dart';
export 'data/models/tv_models/episode_model.dart';
export 'data/models/tv_models/episode_to_air_model.dart';
export 'data/models/tv_models/guest_star_model.dart';
export 'data/models/tv_models/network_model.dart';
export 'data/models/tv_models/production_country_model.dart';
export 'data/models/tv_models/season_detail_model.dart';
export 'data/models/tv_models/season_model.dart';
export 'data/models/tv_models/spoken_language_model.dart';
export 'data/models/tv_models/tv_detail_model.dart';
export 'data/models/tv_models/tv_model.dart';
export 'data/models/tv_models/tv_response.dart';
export 'data/models/tv_models/tv_table.dart';

/// entities
/// movie entities
export 'domain/entities/movie_entities/genre.dart';
export 'domain/entities/movie_entities/movie_detail.dart';
export 'domain/entities/movie_entities/movie.dart';

/// tv entities
export 'domain/entities/tv_entities/created_by.dart';
export 'domain/entities/tv_entities/crew.dart';
export 'domain/entities/tv_entities/episode_to_air.dart';
export 'domain/entities/tv_entities/episode.dart';
export 'domain/entities/tv_entities/guest_star.dart';
export 'domain/entities/tv_entities/network.dart';
export 'domain/entities/tv_entities/production_country.dart';
export 'domain/entities/tv_entities/season_detail.dart';
export 'domain/entities/tv_entities/season.dart';
export 'domain/entities/tv_entities/spoken_language.dart';
export 'domain/entities/tv_entities/tv_detail.dart';
export 'domain/entities/tv_entities/tv.dart';

/// widgets
export 'presentation/widgets/custom_drawer.dart';
export 'presentation/widgets/movie_card_list.dart';
export 'presentation/widgets/movie_list.dart';
export 'presentation/widgets/seasons_list.dart';
export 'presentation/widgets/tv_card_list.dart';
export 'presentation/widgets/tv_list.dart';
