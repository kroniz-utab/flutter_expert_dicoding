import '../../../data/models/tv_models/tv_model.dart';
import 'package:equatable/equatable.dart';

class TvResponse extends Equatable {
  final List<TVModel> tvList;

  const TvResponse({
    required this.tvList,
  });

  factory TvResponse.fromJson(Map<String, dynamic> json) => TvResponse(
        tvList: List<TVModel>.from((json["results"] as List)
            .map((e) => TVModel.fromJson(e))
            .where((element) => element.posterPath != null)),
      );

  Map<String, dynamic> toJson() => {
        "results": List<dynamic>.from(tvList.map((x) => x.toJson())),
      };

  @override
  List<Object?> get props => [tvList];
}
