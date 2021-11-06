import '../../utils/exception.dart';
import '../../data/datasources/db/database_helper.dart';
import '../../data/models/tv_models/tv_table.dart';

abstract class TVLocalDataSource {
  Future<String> insertTVWatchlist(TVTable tv);
  Future<String> removeTVWatchlist(TVTable tv);
  Future<TVTable?> getTVShowById(int id);
  Future<List<TVTable>> getWatchlistTVShow();
  Future<void> cacheTVOnTheAir(List<TVTable> tv);
  Future<List<TVTable>> getCachedTVOnTheAir();
}

class TVLocalDataSourceImpl implements TVLocalDataSource {
  final DatabaseHelper databaseHelper;

  TVLocalDataSourceImpl({
    required this.databaseHelper,
  });

  @override
  Future<TVTable?> getTVShowById(int id) async {
    final result = await databaseHelper.getTVShowById(id);
    if (result != null) {
      return TVTable.fromMap(result);
    } else {
      return null;
    }
  }

  @override
  Future<List<TVTable>> getWatchlistTVShow() async {
    final result = await databaseHelper.getWatchlistTVShow();
    return result.map((data) => TVTable.fromMap(data)).toList();
  }

  @override
  Future<String> insertTVWatchlist(TVTable tv) async {
    try {
      await databaseHelper.insertTVWatchlist(tv);
      return 'Added to Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeTVWatchlist(TVTable tv) async {
    try {
      await databaseHelper.removeTVWatchlist(tv);
      return 'Removed from Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<void> cacheTVOnTheAir(List<TVTable> tv) async {
    await databaseHelper.clearTVCache('on the air');
    await databaseHelper.insertTVCacheTransaction(tv, 'on the air');
  }

  @override
  Future<List<TVTable>> getCachedTVOnTheAir() async {
    final result = await databaseHelper.getTVCacheMovies('on the air');
    if (result.isNotEmpty) {
      return result.map((e) => TVTable.fromMap(e)).toList();
    } else {
      throw CacheException("Can't get the data :(");
    }
  }
}
