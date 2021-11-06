import 'package:dartz/dartz.dart';
import '../../../domain/entities/movie_entities/movie.dart';
import '../../../domain/repositories/movie_repository.dart';
import '../../../utils/failure.dart';

class GetMovieRecommendations {
  final MovieRepository repository;

  GetMovieRecommendations(this.repository);

  Future<Either<Failure, List<Movie>>> execute(id) {
    return repository.getMovieRecommendations(id);
  }
}
