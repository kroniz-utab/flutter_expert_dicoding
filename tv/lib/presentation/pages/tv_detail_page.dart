// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:tv/tv.dart';
import 'package:watchlist/watchlist.dart';

class TVDetailPage extends StatefulWidget {
  final int id;
  const TVDetailPage({Key? key, required this.id}) : super(key: key);

  @override
  _TVDetailPageState createState() => _TVDetailPageState();
}

class _TVDetailPageState extends State<TVDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<TvDetailBloc>().add(OnTvDetailCalled(widget.id));
      context
          .read<TvRecommendationBloc>()
          .add(OnTvRecommendationCalled(widget.id));
      context.read<TvSimilarBloc>().add(OnTvSimilarCalled(widget.id));
      context.read<TvWatchlistBloc>().add(FetchTvWatchlistStatus(widget.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isAddedToWatchlist = context.select<TvWatchlistBloc, bool>((bloc) =>
        (bloc.state is TvIsAddedToWatchlist)
            ? (bloc.state as TvIsAddedToWatchlist).isAdded
            : false);
    return Scaffold(
      body: BlocBuilder<TvDetailBloc, TvDetailState>(
        builder: (context, state) {
          if (state is TvDetailLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is TvDetailHasData) {
            final tv = state.result;
            return SafeArea(
              child: DetailContent(
                isAddedToWatchlist,
                tv: tv,
              ),
            );
          } else if (state is TvDetailError) {
            return Center(
              child: Text(
                state.message,
                key: Key('error_message'),
              ),
            );
          } else {
            return Center(
              child: Text(
                'Detail is empty',
                key: Key('empty_message'),
              ),
            );
          }
        },
      ),
    );
  }
}

class DetailContent extends StatefulWidget {
  final TVDetail tv;
  bool isAddedWatchlist;

  DetailContent(
    this.isAddedWatchlist, {
    Key? key,
    required this.tv,
  }) : super(key: key);

  @override
  State<DetailContent> createState() => _DetailContentState();
}

class _DetailContentState extends State<DetailContent> {
  final messageWatchlistAddSuccess = 'Added to Watchlist';
  final messageWatchlistRemoveSuccess = 'Removed from Watchlist';
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: '$BASE_IMAGE_URL${widget.tv.posterPath}',
          width: screenWidth,
          placeholder: (context, url) => Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: kRichBlack,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 16,
                  right: 16,
                ),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.tv.name,
                              style: kHeading5,
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                if (!widget.isAddedWatchlist) {
                                  context
                                      .read<TvWatchlistBloc>()
                                      .add(AddTvToWatchlist(widget.tv));
                                } else {
                                  context
                                      .read<TvWatchlistBloc>()
                                      .add(RemoveTvFromWatchlist(widget.tv));
                                }

                                final message =
                                    context.select<TvWatchlistBloc, String>(
                                  (value) =>
                                      (value.state as TvIsAddedToWatchlist)
                                                  .isAdded ==
                                              false
                                          ? messageWatchlistAddSuccess
                                          : messageWatchlistRemoveSuccess,
                                );

                                if (message == messageWatchlistAddSuccess ||
                                    message == messageWatchlistRemoveSuccess) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(message)));
                                } else {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          content: Text(message),
                                        );
                                      });
                                }

                                setState(() {
                                  widget.isAddedWatchlist =
                                      !widget.isAddedWatchlist;
                                });
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  widget.isAddedWatchlist
                                      ? Icon(Icons.check)
                                      : Icon(Icons.add),
                                  Text('Watchlist'),
                                ],
                              ),
                            ),
                            Text(
                              _showGenres(widget.tv.genres),
                            ),
                            Row(
                              children: [
                                Text('Status  : '),
                                widget.tv.inProduction
                                    ? Text('In Productions')
                                    : Text('Not In Production'),
                                Text(' (${widget.tv.status})'),
                              ],
                            ),
                            Row(
                              children: [
                                Text('Detail   : '),
                                Text(
                                    '${widget.tv.numberOfSeasons.toString()} Seasons '),
                                Text(
                                    '(${widget.tv.numberOfEpisodes.toString()} Episodes)'),
                              ],
                            ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: widget.tv.voteAverage / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${widget.tv.voteAverage}')
                              ],
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              widget.tv.overview,
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Season',
                              style: kHeading6,
                            ),
                            SizedBox(
                              height: 150,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  final data = widget.tv.seasons[index];
                                  return SeasonsList(
                                    key: Key('season_$index'),
                                    season: data,
                                    tvPosterPath: widget.tv.posterPath,
                                    onTap: () {
                                      Navigator.pushNamed(
                                        context,
                                        seasonDetailRoutes,
                                        arguments: {
                                          'tvId': widget.tv.id,
                                          'seasonNumber': data.seasonNumber,
                                          'tvPosterPath': widget.tv.posterPath,
                                          'seasonList': widget.tv.seasons,
                                          'tvName': widget.tv.name,
                                        },
                                      );
                                    },
                                  );
                                },
                                itemCount: widget.tv.seasons.length,
                              ),
                            ),
                            SizedBox(height: 16),
                            BlocBuilder<TvRecommendationBloc,
                                    TvRecommendationState>(
                                builder: (context, state) {
                              if (state is TvRecommendationLoading ||
                                  state is TvRecommendationHasData) {
                                return Text(
                                  'Recommendations',
                                  style: kHeading6,
                                );
                              } else {
                                return SizedBox();
                              }
                            }),
                            BlocBuilder<TvRecommendationBloc,
                                TvRecommendationState>(
                              builder: (context, state) {
                                if (state is TvRecommendationLoading) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (state is TvRecommendationHasData) {
                                  final listTv = state.result;
                                  return SizedBox(
                                    height: 150,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        final tv = listTv[index];
                                        return TVListLayout(
                                          key: Key('recom_$index'),
                                          tv: tv,
                                          onTap: () {
                                            Navigator.pushReplacementNamed(
                                              context,
                                              tvDetailRoutes,
                                              arguments: tv.id,
                                            );
                                          },
                                        );
                                      },
                                      itemCount: listTv.length,
                                    ),
                                  );
                                } else if (state is TvRecommendationError) {
                                  return Center(
                                    child: Text(
                                      state.message,
                                      key: Key('recom_error'),
                                    ),
                                  );
                                } else {
                                  return SizedBox(
                                    key: Key('recom_empty'),
                                  );
                                }
                              },
                            ),
                            SizedBox(height: 16),
                            BlocBuilder<TvSimilarBloc, TvSimilarState>(
                                builder: (context, state) {
                              if (state is TvSimilarLoading ||
                                  state is TvSimilarHasData) {
                                return Text(
                                  'Similar TV Shows',
                                  style: kHeading6,
                                );
                              } else {
                                return SizedBox();
                              }
                            }),
                            BlocBuilder<TvSimilarBloc, TvSimilarState>(
                              builder: (context, state) {
                                if (state is TvSimilarLoading) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (state is TvSimilarHasData) {
                                  final listTv = state.result;
                                  return SizedBox(
                                    height: 150,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        final tv = listTv[index];
                                        return TVListLayout(
                                          key: Key('similar_$index'),
                                          tv: tv,
                                          onTap: () {
                                            Navigator.pushReplacementNamed(
                                              context,
                                              tvDetailRoutes,
                                              arguments: tv.id,
                                            );
                                          },
                                        );
                                      },
                                      itemCount: listTv.length,
                                    ),
                                  );
                                } else if (state is TvSimilarError) {
                                  return Center(
                                    child: Text(
                                      state.message,
                                      key: Key('similar_error'),
                                    ),
                                  );
                                } else {
                                  return SizedBox(
                                    key: Key('similar_empty'),
                                  );
                                }
                              },
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
                    ),
                  ],
                ),
              );
            },
            // initialChildSize: 0.5,
            minChildSize: 0.25,
            // maxChildSize: 1.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: kRichBlack,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        )
      ],
    );
  }

  String _showGenres(List<Genre> genres) {
    String result = '';
    for (var genre in genres) {
      result += genre.name + ', ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }
}
