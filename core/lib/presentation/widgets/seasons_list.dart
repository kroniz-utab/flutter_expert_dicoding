// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/tv_entities/season.dart';
import '../../utils/constants.dart';

class SeasonsList extends StatelessWidget {
  final Season season;
  final String tvPosterPath;
  final Function() onTap;

  const SeasonsList({
    Key? key,
    required this.season,
    required this.tvPosterPath,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: InkWell(
        onTap: onTap,
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(16)),
          child: CachedNetworkImage(
            imageUrl: season.posterPath != null
                ? '$BASE_IMAGE_URL${season.posterPath}'
                : '$BASE_IMAGE_URL$tvPosterPath',
            placeholder: (context, url) => Center(
              child: CircularProgressIndicator(),
            ),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
        ),
      ),
    );
  }
}
