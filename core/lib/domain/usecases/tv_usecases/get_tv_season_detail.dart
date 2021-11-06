import 'package:dartz/dartz.dart';
import '../../../utils/failure.dart';
import '../../../domain/entities/tv_entities/season_detail.dart';
import '../../../domain/repositories/tv_repository.dart';

class GetTVSeasonDetail {
  final TVRepository repository;

  GetTVSeasonDetail(this.repository);

  Future<Either<Failure, SeasonDetail>> execute(int tvId, int season) {
    return repository.getTVSeasonDetail(tvId, season);
  }
}
