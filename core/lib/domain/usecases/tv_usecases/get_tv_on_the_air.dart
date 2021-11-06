import 'package:dartz/dartz.dart';
import '../../../utils/failure.dart';
import '../../../domain/entities/tv_entities/tv.dart';
import '../../../domain/repositories/tv_repository.dart';

class GetTVOnTheAir {
  final TVRepository repository;

  GetTVOnTheAir(this.repository);

  Future<Either<Failure, List<TV>>> execute() {
    return repository.getTVOnTheAir();
  }
}
