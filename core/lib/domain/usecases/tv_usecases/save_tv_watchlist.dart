import 'package:dartz/dartz.dart';
import '../../../utils/failure.dart';
import '../../../domain/entities/tv_entities/tv_detail.dart';
import '../../../domain/repositories/tv_repository.dart';

class SaveTVWatchList {
  final TVRepository repository;

  SaveTVWatchList(this.repository);

  Future<Either<Failure, String>> execute(TVDetail tv) {
    return repository.saveWatchlist(tv);
  }
}
