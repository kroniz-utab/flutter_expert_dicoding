// ignore_for_file: prefer_const_constructors

import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tv/tv.dart';

class HomeTVPage extends StatefulWidget {
  const HomeTVPage({Key? key}) : super(key: key);

  @override
  _HomeTVPageState createState() => _HomeTVPageState();
}

class _HomeTVPageState extends State<HomeTVPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<TvListBloc>().add(OnTvShowListCalled());
      context.read<TvPopularBloc>().add(OnTvPopularCalled());
      context.read<TvTopRatedBloc>().add(OnTvTopRatedCalled());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: CustomDrawer(
        location: tvRoutes,
        content: Scaffold(
          appBar: AppBar(
            leading: Icon(Icons.menu),
            title: Text('TV Show'),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    searchRoutes,
                    arguments: false,
                  );
                },
                icon: Icon(Icons.search),
              )
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              key: Key('this_is_home_tv'),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'On The Air',
                    style: kHeading6,
                  ),
                  BlocBuilder<TvListBloc, TvListState>(
                    builder: (context, state) {
                      if (state is TvListLoading) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is TvListHasData) {
                        final listTv = state.result;
                        return SizedBox(
                          height: 200,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              final tv = listTv[index];
                              return TVListLayout(
                                key: Key('ota_$index'),
                                tv: tv,
                                onTap: () {
                                  Navigator.pushNamed(
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
                      } else if (state is TvListError) {
                        return Center(
                          child: Text(
                            state.message,
                            key: Key('error_message'),
                          ),
                        );
                      } else {
                        return Center(
                          child: Text(
                            'There are no tv currently showing',
                            key: Key('empty_message'),
                          ),
                        );
                      }
                    },
                  ),
                  _buildSubHeading(
                      title: 'Popular TV Shows',
                      onTap: () {
                        Navigator.pushNamed(context, popularTVRoutes);
                      },
                      key: 'see_more_popular'),
                  BlocBuilder<TvPopularBloc, TvPopularState>(
                    builder: (context, state) {
                      if (state is TvPopularLoading) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is TvPopularHasData) {
                        final listTv = state.result;
                        return SizedBox(
                          height: 200,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              final tv = listTv[index];
                              return TVListLayout(
                                key: Key('popular_$index'),
                                tv: tv,
                                onTap: () {
                                  Navigator.pushNamed(
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
                      } else if (state is TvPopularError) {
                        return Center(
                          child: Text(
                            state.message,
                            key: Key('error_message'),
                          ),
                        );
                      } else {
                        return Center(
                          child: Text(
                            'There are no tv popular showing',
                            key: Key('empty_message'),
                          ),
                        );
                      }
                    },
                  ),
                  _buildSubHeading(
                      title: 'Top Rated',
                      onTap: () {
                        Navigator.pushNamed(context, topRatedTVRoutes);
                      },
                      key: 'see_more_top_rated'),
                  BlocBuilder<TvTopRatedBloc, TvTopRatedState>(
                    builder: (context, state) {
                      if (state is TvTopRatedLoading) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is TvTopRatedHasData) {
                        final listTv = state.result;
                        return SizedBox(
                          height: 200,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              final tv = listTv[index];
                              return TVListLayout(
                                key: Key('top_rated_$index'),
                                tv: tv,
                                onTap: () {
                                  Navigator.pushNamed(
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
                      } else if (state is TvTopRatedError) {
                        return Center(
                          child: Text(
                            state.message,
                            key: Key('error_message'),
                          ),
                        );
                      } else {
                        return Center(
                          child: Text(
                            'There are no tv top rated showing',
                            key: Key('empty_message'),
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Row _buildSubHeading({
    required String title,
    required Function() onTap,
    required String key,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              key: Key(key),
              children: const [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}
