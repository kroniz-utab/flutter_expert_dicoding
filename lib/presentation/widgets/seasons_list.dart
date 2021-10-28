import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:ditonton/common/constants.dart';
import 'package:ditonton/domain/entities/tv_entities/season.dart';

class SeasonsList extends StatelessWidget {
  final List<Season> tv;
  final String tvPosterPath;
  final double? height;

  const SeasonsList({
    Key? key,
    required this.tv,
    required this.tvPosterPath,
    this.height,
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
                // Navigator.pushNamed(
                //   context,
                //   TVDetailPage.ROUTE_NAME,
                //   arguments: tvs.id,
                // );
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
