library tv;

/// provider
export 'presentation/provider/tv_list_notifier.dart';
export 'presentation/provider/popular_tv_notifier.dart';
export 'presentation/provider/tv_detail_notifier.dart';
export 'presentation/provider/top_rated_tv_notifier.dart';
export 'presentation/provider/tv_season_notifier.dart';

/// usecase
export 'domain/usecase/get_popular_tv_show.dart';
export 'domain/usecase/get_similar_tv_shows.dart';
export 'domain/usecase/get_top_rated_tv_show.dart';
export 'domain/usecase/get_tv_on_the_air.dart';
export 'domain/usecase/get_tv_recommendations.dart';
export 'domain/usecase/get_tv_season_detail.dart';
export 'domain/usecase/get_tv_show_detail.dart';

/// pages
export 'presentation/pages/home_tv_page.dart';
export 'presentation/pages/popular_tv_page.dart';
export 'presentation/pages/season_detail_page.dart';
export 'presentation/pages/top_rated_tv_page.dart';
export 'presentation/pages/tv_detail_page.dart';
