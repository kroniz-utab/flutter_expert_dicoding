import 'package:dartz/dartz.dart';
import 'package:core/core.dart';

class GetTopRatedTVShows {
  final TVRepository repository;

  GetTopRatedTVShows(this.repository);

  Future<Either<Failure, List<TV>>> execute() {
    return repository.getTopRatedTVShows();
  }
}
