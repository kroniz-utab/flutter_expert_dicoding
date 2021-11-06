// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../utils/constants.dart';
import '../../domain/entities/tv_entities/tv.dart';
import '../../presentation/pages/tv_detail_page.dart';

class TVListLayout extends StatelessWidget {
  final List<TV> tv;
  final double? height;
  final bool isReplacement;

  const TVListLayout({
    Key? key,
    required this.tv,
    required this.height,
    required this.isReplacement,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final movie = tv[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                if (isReplacement) {
                  Navigator.pushReplacementNamed(
                    context,
                    TVDetailPage.ROUTE_NAME,
                    arguments: movie.id,
                  );
                } else {
                  Navigator.pushNamed(
                    context,
                    TVDetailPage.ROUTE_NAME,
                    arguments: movie.id,
                  );
                }
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${movie.posterPath}',
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
