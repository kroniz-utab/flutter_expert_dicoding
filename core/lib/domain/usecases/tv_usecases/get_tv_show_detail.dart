import 'package:dartz/dartz.dart';
import '../../../utils/failure.dart';
import '../../../domain/entities/tv_entities/tv_detail.dart';
import '../../../domain/repositories/tv_repository.dart';

class GetTVShowDetail {
  final TVRepository repository;

  GetTVShowDetail(this.repository);

  Future<Either<Failure, TVDetail>> execute(int id) {
    return repository.getTVShowDetail(id);
  }
}
