import 'package:dartz/dartz.dart';
import 'package:core/core.dart';

class GetTVShowDetail {
  final TVRepository repository;

  GetTVShowDetail(this.repository);

  Future<Either<Failure, TVDetail>> execute(int id) {
    return repository.getTVShowDetail(id);
  }
}
