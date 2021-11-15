import 'package:core/core.dart';

class GetWatchlistTVStatus {
  final TVRepository repository;

  GetWatchlistTVStatus(this.repository);

  Future<bool> execute(int id) async {
    return repository.isAddedToWatchlist(id);
  }
}
