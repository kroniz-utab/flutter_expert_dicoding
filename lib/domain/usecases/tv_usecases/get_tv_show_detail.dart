import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv_entities/tv_detail.dart';
import 'package:ditonton/domain/repositories/tv_repository.dart';

class GetTVShowDetail {
  final TVRepository repository;

  GetTVShowDetail(this.repository);

  Future<Either<Failure, TVDetail>> execute(int id) {
    return repository.getTVShowDetail(id);
  }
}
