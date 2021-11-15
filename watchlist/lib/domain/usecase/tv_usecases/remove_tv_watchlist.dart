import 'package:dartz/dartz.dart';
import 'package:core/core.dart';

class RemoveTVWatchlist {
  final TVRepository repository;

  RemoveTVWatchlist(this.repository);

  Future<Either<Failure, String>> execute(TVDetail tv) {
    return repository.removeWatchlist(tv);
  }
}
