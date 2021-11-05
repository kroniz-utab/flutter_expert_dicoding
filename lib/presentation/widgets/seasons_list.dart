import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:ditonton/common/constants.dart';
import 'package:ditonton/domain/entities/tv_entities/season.dart';
import 'package:ditonton/presentation/pages/season_detail_page.dart';

class SeasonsList extends StatelessWidget {
  final int tvId;
  final List<Season> tv;
  final String tvPosterPath;
  final String tvName;
  final double? height;
  final bool isReplacement;

  const SeasonsList({
    Key? key,
    required this.tvId,
    required this.tv,
    required this.tvPosterPath,
    required this.tvName,
    required this.height,
    required this.isReplacement,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final tvs = tv[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                if (isReplacement) {
                  Navigator.pushReplacementNamed(
                    context,
                    SeasonDetailPage.ROUTE_NAME,
                    arguments: {
                      'tvId': tvId,
                      'seasonNumber': tvs.seasonNumber,
                      'tvPosterPath': tvPosterPath,
                      'seasonList': tv,
                      'tvName': tvName,
                    },
                  );
                } else {
                  Navigator.pushNamed(
                    context,
                    SeasonDetailPage.ROUTE_NAME,
                    arguments: {
                      'tvId': tvId,
                      'seasonNumber': tvs.seasonNumber,
                      'tvPosterPath': tvPosterPath,
                      'seasonList': tv,
                      'tvName': tvName,
                    },
                  );
                }
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: tvs.posterPath != null
                      ? '$BASE_IMAGE_URL${tvs.posterPath}'
                      : '$BASE_IMAGE_URL$tvPosterPath',
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: tv.length,
      ),
    );
  }
}