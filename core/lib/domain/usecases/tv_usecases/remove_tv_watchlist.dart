import 'package:dartz/dartz.dart';
import '../../../utils/failure.dart';
import '../../../domain/entities/tv_entities/tv_detail.dart';
import '../../../domain/repositories/tv_repository.dart';

class RemoveTVWatchlist {
  final TVRepository repository;

  RemoveTVWatchlist(this.repository);

  Future<Either<Failure, String>> execute(TVDetail tv) {
    return repository.removeWatchlist(tv);
  }
}
