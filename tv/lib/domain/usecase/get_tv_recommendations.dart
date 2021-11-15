import 'package:dartz/dartz.dart';
import 'package:core/core.dart';

class GetTVRecommendations {
  final TVRepository repository;

  GetTVRecommendations(this.repository);

  Future<Either<Failure, List<TV>>> execute(int id) {
    return repository.getTvRecommendations(id);
  }
}
