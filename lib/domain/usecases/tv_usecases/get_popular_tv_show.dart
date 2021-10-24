import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv_entities/tv.dart';
import 'package:ditonton/domain/repositories/tv_repository.dart';

class GetPopularTVShows {
  final TVRepository repository;

  GetPopularTVShows(this.repository);

  Future<Either<Failure, List<TV>>> execute() {
    return repository.getPopularTVShows();
  }
}
