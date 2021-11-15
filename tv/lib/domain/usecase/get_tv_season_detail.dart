import 'package:dartz/dartz.dart';
import 'package:core/core.dart';

class GetTVSeasonDetail {
  final TVRepository repository;

  GetTVSeasonDetail(this.repository);

  Future<Either<Failure, SeasonDetail>> execute(int tvId, int season) {
    return repository.getTVSeasonDetail(tvId, season);
  }
}
