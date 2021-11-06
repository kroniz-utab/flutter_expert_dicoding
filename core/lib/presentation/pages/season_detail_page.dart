// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/styles/colors.dart';
import 'package:core/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';

import '../../utils/constants.dart';
import '../../utils/state_enum.dart';
import '../../domain/entities/tv_entities/episode.dart';
import '../../domain/entities/tv_entities/season.dart';
import '../../domain/entities/tv_entities/season_detail.dart';
import '../../presentation/provider/tv_provider/tv_season_notifier.dart';
import '../../presentation/widgets/seasons_list.dart';

class SeasonDetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/tv-season';
  const SeasonDetailPage({
    Key? key,
    required this.tvId,
    required this.season,
    required this.tvPosterPath,
    required this.seasonList,
    required this.tvName,
  }) : super(key: key);

  final int tvId;
  final int season;
  final String tvPosterPath;
  final List<Season> seasonList;
  final String tvName;

  @override
  State<SeasonDetailPage> createState() => _SeasonDetailPageState();
}

class _SeasonDetailPageState extends State<SeasonDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<TVSeasonNotifier>(context, listen: false)
          .fetchSeasonDetail(widget.tvId, widget.season);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Consumer<TVSeasonNotifier>(
      builder: (context, provider, child) {
        if (provider.dataState == RequestState.Loading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (provider.dataState == RequestState.Loaded) {
          final seasonData = provider.data;
          return Center(
            child: SeasonContent(
              seasonData: seasonData,
              posterPath: widget.tvPosterPath,
              tvName: widget.tvName,
              seasonList: widget.seasonList,
              tvId: widget.tvId,
            ),
          );
        } else {
          return Center(
            child: Text(provider.message),
          );
        }
      },
    ));
  }
}

class SeasonContent extends StatelessWidget {
  const SeasonContent({
    Key? key,
    required this.seasonData,
    required this.posterPath,
    required this.tvName,
    required this.seasonList,
    required this.tvId,
  }) : super(key: key);

  final SeasonDetail seasonData;
  final String posterPath;
  final String tvName;
  final List<Season> seasonList;
  final int tvId;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: seasonData.posterPath == null
              ? '$BASE_IMAGE_URL$posterPath'
              : '$BASE_IMAGE_URL${seasonData.posterPath}',
          width: screenWidth,
          placeholder: (context, url) => Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        Container(
          margin: EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: kRichBlack,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: EdgeInsets.only(
                  left: 16,
                  top: 16,
                  right: 16,
                ),
                child: Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 16),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '$tvName (${seasonData.name})',
                              style: kHeading5,
                            ),
                            SizedBox(height: 8),
                            ReadMoreText(
                              seasonData.overview.isEmpty
                                  ? 'Coming Soon'
                                  : seasonData.overview,
                              trimCollapsedText: 'Read More',
                              trimExpandedText: ' Show Less',
                              style: kBodyText,
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Episodes',
                              style: kHeading6,
                            ),
                            SizedBox(height: 8),
                            ListView.separated(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                final episode = seasonData.episodes[index];
                                return EpisodesList(
                                  epi: episode,
                                  index: index,
                                );
                              },
                              separatorBuilder: (context, index) {
                                return SizedBox(height: 8);
                              },
                              itemCount: seasonData.episodes.length,
                            ),
                            SizedBox(height: 16),
                            seasonList.length == 1
                                ? SizedBox()
                                : Text(
                                    'Other Season',
                                    style: kHeading6,
                                  ),
                            SizedBox(height: 8),
                            seasonList.length == 1
                                ? SizedBox()
                                : SeasonsList(
                                    tvId: tvId,
                                    tv: seasonList,
                                    tvPosterPath: posterPath,
                                    tvName: tvName,
                                    height: 150,
                                    isReplacement: true,
                                  ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: Colors.white,
                        height: 4,
                        width: 48,
                      ),
                    )
                  ],
                ),
              );
            },
            minChildSize: 0.25,
          ),
        ),
        SafeArea(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor: kRichBlack,
              foregroundColor: Colors.white,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class EpisodesList extends StatelessWidget {
  const EpisodesList({
    Key? key,
    required this.epi,
    required this.index,
  }) : super(key: key);

  final Episode epi;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 1,
          child: CachedNetworkImage(
            imageUrl: epi.stillPath == null
                ? BASE_IMG_NOT_PREVIEWED
                : '$BASE_IMAGE_URL${epi.stillPath}',
            width: 125,
            placeholder: (context, url) => Center(
              child: CircularProgressIndicator(),
            ),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
        ),
        SizedBox(width: 8),
        Expanded(
          flex: 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Episode ${index + 1}',
                    style: kSmallText,
                  ),
                  Text(
                    epi.airDate,
                    style: kSmallText,
                  ),
                ],
              ),
              Text(
                epi.name,
                style: kSubtitle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                epi.overview,
                style: kSmallText,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              )
            ],
          ),
        )
      ],
    );
  }
}
