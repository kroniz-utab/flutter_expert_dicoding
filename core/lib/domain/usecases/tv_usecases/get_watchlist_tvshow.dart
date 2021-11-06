import 'package:dartz/dartz.dart';
import '../../../utils/failure.dart';
import '../../../domain/entities/tv_entities/tv.dart';
import '../../../domain/repositories/tv_repository.dart';

class GetWatchlistTVShows {
  final TVRepository _repository;

  GetWatchlistTVShows(this._repository);

  Future<Either<Failure, List<TV>>> execute() {
    return _repository.getWatchListTVShow();
  }
}
