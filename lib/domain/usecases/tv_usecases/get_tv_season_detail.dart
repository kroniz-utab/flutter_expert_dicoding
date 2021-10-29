import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv_entities/season_detail.dart';
import 'package:ditonton/domain/repositories/tv_repository.dart';

class GetTVSeasonDetail {
  final TVRepository repository;

  GetTVSeasonDetail(this.repository);

  Future<Either<Failure, SeasonDetail>> execute(int tvId, int season) {
    return repository.getTVSeasonDetail(tvId, season);
  }
}
