import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv_entities/tv.dart';
import 'package:ditonton/domain/entities/tv_entities/tv_detail.dart';

abstract class TVRepository {
  Future<Either<Failure, List<TV>>> getTVOnTheAir();
  Future<Either<Failure, TVDetail>> getTVShowDetail(int id);
  Future<Either<Failure, List<TV>>> getPopularTVShows();
  Future<Either<Failure, List<TV>>> getTopRatedTVShows();
  Future<Either<Failure, List<TV>>> getTvRecommendations(int id);
  Future<Either<Failure, List<TV>>> getSimilarTVShows(int id);
  Future<Either<Failure, List<TV>>> searchTVShows(String query);
}
