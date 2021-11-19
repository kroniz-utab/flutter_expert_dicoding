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
                        return MovieList(state.result);
                      } else if (state is MovieListError) {
                        return Center(
                          child: Text(state.message),
                        );
                      } else if (state is MovieListEmpty) {
                        return Center(
                          child: Text('There are no movies currently showing'),
                        );
                      } else {
                        return SizedBox();
                      }
                    },
                  ),
                  _buildSubHeading(
                    title: 'Popular',
                    onTap: () =>
                        Navigator.pushNamed(context, popularMovieRoutes),
                  ),
                  BlocBuilder<MoviePopularBloc, MoviePopularState>(
                    builder: (context, state) {
                      if (state is MoviePopularLoading) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is MoviePopularHasData) {
                        return MovieList(state.result);
                      } else if (state is MoviePopularError) {
                        return Center(
                          child: Text(state.message),
                        );
                      } else if (state is MoviePopularEmpty) {
                        return Center(
                          child: Text('There are no one popular movie'),
                        );
                      } else {
                        return SizedBox();
                      }
                    },
                  ),
                  _buildSubHeading(
                    title: 'Top Rated',
                    onTap: () =>
                        Navigator.pushNamed(context, topRatedMovieRoutes),
                  ),
                  BlocBuilder<MovieTopRatedBloc, MovieTopRatedState>(
                    builder: (context, state) {
                      if (state is MovieTopRatedLoading) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is MovieTopRatedHasData) {
                        return MovieList(state.result);
                      } else if (state is MovieTopRatedError) {
                        return Center(
                          child: Text(state.message),
                        );
                      } else if (state is MovieTopRatedEmpty) {
                        return Center(
                          child: Text('There are no top rated movies'),
                        );
                      } else {
                        return SizedBox();
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

  Row _buildSubHeading({required String title, required Function() onTap}) {
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
              children: const [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}
