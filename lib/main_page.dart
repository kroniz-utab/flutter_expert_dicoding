// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:core/core.dart';
import 'package:core/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/movie.dart';
import 'package:tv/tv.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<MovieListBloc>().add(OnMovieListCalled());
      context.read<MoviePopularBloc>().add(OnMoviePopularCalled());
      context.read<TvListBloc>().add(OnTvShowListCalled());
      context.read<TvPopularBloc>().add(OnTvPopularCalled());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      key: Key('main_page'),
      child: CustomDrawer(
        location: mainRoutes,
        content: Scaffold(
          appBar: AppBar(
            leading: Icon(Icons.menu),
            title: Text('Ditonton'),
            actions: [
              IconButton(
                key: Key('go_to_watchlist'),
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    watchlistRoutes,
                  );
                },
                icon: Icon(Icons.save_alt),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Movies Now Playing',
                    style: kHeading6,
                  ),
                  SizedBox(height: 10),
                  BlocBuilder<MovieListBloc, MovieListState>(
                    builder: (context, state) {
                      if (state is MovieListLoading) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is MovieListHasData) {
                        final listMovies = state.result;
                        return _buildMoviesCarousel(listMovies);
                      } else if (state is MovieListError) {
                        return Container(
                          key: Key('data_error'),
                          height: 200,
                          child: Center(
                            child: Text(state.message),
                          ),
                        );
                      } else {
                        return Container(
                          key: Key('data_kosong'),
                          height: 200,
                          child: Center(
                            child: Text('No one movie is playing'),
                          ),
                        );
                      }
                    },
                  ),
                  SizedBox(height: 10),
                  _buildSubHeading(
                    title: 'Hot Movies ????',
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        movieRoutes,
                      );
                    },
                    key: 'hot_movies',
                  ),
                  SizedBox(height: 10),
                  BlocBuilder<MoviePopularBloc, MoviePopularState>(
                    builder: (context, state) {
                      if (state is MoviePopularLoading) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is MoviePopularHasData) {
                        final listMovie = state.result;
                        return SizedBox(
                          height: 200,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              final movie = listMovie[index];
                              return MovieList(
                                key: Key('mCard_$index'),
                                movies: movie,
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    movieDetailRoutes,
                                    arguments: movie.id,
                                  );
                                },
                              );
                            },
                            itemCount: listMovie.length,
                          ),
                        );
                      } else if (state is MoviePopularError) {
                        return Container(
                          key: Key('data_error'),
                          height: 200,
                          child: Center(
                            child: Text(state.message),
                          ),
                        );
                      } else {
                        return Container(
                          key: Key('data_kosong'),
                          height: 200,
                          child: Center(
                            child: Text('No one popular movies'),
                          ),
                        );
                      }
                    },
                  ),
                  Text(
                    'TV On The Air',
                    style: kHeading6,
                  ),
                  SizedBox(height: 10),
                  BlocBuilder<TvListBloc, TvListState>(
                    builder: (context, state) {
                      if (state is TvListLoading) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is TvListHasData) {
                        final listTv = state.result;
                        return _buildTVCarousel(listTv);
                      } else if (state is TvListError) {
                        return Container(
                          key: Key('data_error'),
                          height: 200,
                          child: Center(
                            child: Text(state.message),
                          ),
                        );
                      } else {
                        return Container(
                          key: Key('data_kosong'),
                          height: 200,
                          child: Center(
                            child: Text('No one tv show is playing'),
                          ),
                        );
                      }
                    },
                  ),
                  SizedBox(height: 10),
                  _buildSubHeading(
                    title: 'Hot TV Shows ????',
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        tvRoutes,
                      );
                    },
                    key: 'hot_tv',
                  ),
                  SizedBox(height: 10),
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
                                key: Key('tCard_$index'),
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
                        return Container(
                          key: Key('data_error'),
                          height: 200,
                          child: Center(
                            child: Text(state.message),
                          ),
                        );
                      } else {
                        return Container(
                          key: Key('data_kosong'),
                          height: 200,
                          child: Center(
                            child: Text('No one popular tv show'),
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
              children: const [
                Text(
                  'See More',
                ),
                Icon(Icons.arrow_forward_ios)
              ],
            ),
          ),
        ),
      ],
    );
  }

  CarouselSlider _buildMoviesCarousel(List<Movie> list) {
    return CarouselSlider.builder(
      itemCount: list.length,
      itemBuilder: (context, index, realIndex) {
        final content = list[index];
        return InkWell(
          key: Key('mCarousel_$index'),
          onTap: () {
            Navigator.pushNamed(
              context,
              movieDetailRoutes,
              arguments: content.id,
            );
          },
          child: Stack(
            fit: StackFit.expand,
            children: [
              Positioned.fill(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: content.backdropPath != null
                        ? '$BASE_IMAGE_URL${content.backdropPath}'
                        : '$BASE_IMAGE_URL${content.posterPath}',
                    placeholder: (context, url) => Center(
                      child: CircularProgressIndicator(),
                    ),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(.7),
                      Colors.black.withOpacity(.9),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: const [0.3, 0.6, 0.9],
                  ),
                ),
              ),
              Positioned(
                top: 150,
                left: 10,
                right: 10,
                bottom: 10,
                child: Text(
                  content.title.toString(),
                  style: kHeading5,
                  maxLines: 1,
                  overflow: TextOverflow.clip,
                ),
              )
            ],
          ),
        );
      },
      options: CarouselOptions(
        height: 200,
        viewportFraction: 1.0,
        enlargeCenterPage: true,
        enableInfiniteScroll: true,
        autoPlay: true,
      ),
    );
  }

  CarouselSlider _buildTVCarousel(List<TV> list) {
    return CarouselSlider.builder(
      itemCount: list.length,
      itemBuilder: (context, index, realIndex) {
        final content = list[index];
        return InkWell(
          key: Key('tCarousel_$index'),
          onTap: () {
            Navigator.pushNamed(
              context,
              tvDetailRoutes,
              arguments: content.id,
            );
          },
          child: Stack(
            fit: StackFit.expand,
            children: [
              Positioned.fill(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: content.backdropPath != null
                        ? '$BASE_IMAGE_URL${content.backdropPath}'
                        : '$BASE_IMAGE_URL${content.posterPath}',
                    placeholder: (context, url) => Center(
                      child: CircularProgressIndicator(),
                    ),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(.7),
                      Colors.black.withOpacity(.9),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: const [0.3, 0.6, 0.9],
                  ),
                ),
              ),
              Positioned(
                top: 150,
                left: 10,
                right: 10,
                bottom: 10,
                child: Text(
                  content.name.toString(),
                  style: kHeading5,
                  maxLines: 1,
                  overflow: TextOverflow.clip,
                ),
              )
            ],
          ),
        );
      },
      options: CarouselOptions(
        height: 200,
        viewportFraction: 1.0,
        enlargeCenterPage: true,
        enableInfiniteScroll: true,
        autoPlay: true,
      ),
    );
  }
}
