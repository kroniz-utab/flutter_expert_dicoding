import 'package:dartz/dartz.dart';
import 'package:core/core.dart';

class GetTVOnTheAir {
  final TVRepository repository;

  GetTVOnTheAir(this.repository);

  Future<Either<Failure, List<TV>>> execute() {
    return repository.getTVOnTheAir();
  }
}
