// ignore_for_file: prefer_const_constructors

import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/movie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomeMoviePage extends StatefulWidget {
  const HomeMoviePage({Key? key}) : super(key: key);
  @override
  _HomeMoviePageState createState() => _HomeMoviePageState();
}

class _HomeMoviePageState extends State<HomeMoviePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<MovieListBloc>().add(OnMovieListCalled());
      context.read<MoviePopularBloc>().add(OnMoviePopularCalled());
      context.read<MovieTopRatedBloc>().add(OnMovieTopRatedCalled());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: CustomDrawer(
        location: movieRoutes,
        content: Scaffold(
          appBar: AppBar(
            leading: Icon(Icons.menu),
            title: Text('Movies'),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    searchRoutes,
                    arguments: true,
                  );
                },
                icon: Icon(Icons.search),
              )
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              key: Key('this_is_home_movie'),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Now Playing',
                    style: kHeading6,
                  ),
                  BlocBuilder<MovieListBloc, MovieListState>(
                    builder: (context, state) {
                      if (state is MovieListLoading) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is MovieListHasData) {
                        final listMovie = state.result;
                        return SizedBox(
                          height: 200,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              final movie = listMovie[index];
                              return MovieList(
                                key: Key('now_play_$index'),
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
                      } else if (state is MovieListError) {
                        return Center(
                          child: Text(
                            state.message,
                            key: Key('error_message'),
                          ),
                        );
                      } else {
                        return Center(
                          child: Text(
                            'There are no movies currently showing',
                            key: Key('empty_message'),
                          ),
                        );
                      }
                    },
                  ),
                  _buildSubHeading(
                      title: 'Popular',
                      onTap: () =>
                          Navigator.pushNamed(context, popularMovieRoutes),
                      key: Key('see_more_popular')),
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
                                key: Key('popular_$index'),
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
                        return Center(
                          child: Text(
                            state.message,
                            key: Key('error_message'),
                          ),
                        );
                      } else {
                        return Center(
                          child: Text(
                            'There are no one popular movie',
                            key: Key('empty_message'),
                          ),
                        );
                      }
                    },
                  ),
                  _buildSubHeading(
                    title: 'Top Rated',
                    onTap: () =>
                        Navigator.pushNamed(context, topRatedMovieRoutes),
                    key: Key('see_more_top_rated'),
                  ),
                  BlocBuilder<MovieTopRatedBloc, MovieTopRatedState>(
                    builder: (context, state) {
                      if (state is MovieTopRatedLoading) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is MovieTopRatedHasData) {
                        final listMovie = state.result;
                        return SizedBox(
                          height: 200,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              final movie = listMovie[index];
                              return MovieList(
                                key: Key('top_rated_$index'),
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
                      } else if (state is MovieTopRatedError) {
                        return Center(
                          child: Text(
                            state.message,
                            key: Key('error_message'),
                          ),
                        );
                      } else {
                        return Center(
                          child: Text(
                            'There are no top rated movies',
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
    required Key key,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          key: key,
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: const [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}
