// ignore_for_file: prefer_const_constructors

import 'package:core/core.dart';
import '../provider/movie_list_notifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class HomeMoviePage extends StatefulWidget {
  const HomeMoviePage({Key? key}) : super(key: key);
  @override
  _HomeMoviePageState createState() => _HomeMoviePageState();
}

class _HomeMoviePageState extends State<HomeMoviePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => Provider.of<MovieListNotifier>(context, listen: false)
          ..fetchNowPlayingMovies()
          ..fetchPopularMovies()
          ..fetchTopRatedMovies());
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
                  Consumer<MovieListNotifier>(
                    builder: (context, data, child) {
                      final state = data.nowPlayingState;
                      if (state == RequestState.Loading) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state == RequestState.Loaded) {
                        return MovieList(data.nowPlayingMovies);
                      } else {
                        return Text('Failed');
                      }
                    },
                  ),
                  _buildSubHeading(
                    title: 'Popular',
                    onTap: () =>
                        Navigator.pushNamed(context, popularMovieRoutes),
                  ),
                  Consumer<MovieListNotifier>(
                    builder: (context, data, child) {
                      final state = data.popularMoviesState;
                      if (state == RequestState.Loading) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state == RequestState.Loaded) {
                        return MovieList(data.popularMovies);
                      } else {
                        return Text('Failed');
                      }
                    },
                  ),
                  _buildSubHeading(
                    title: 'Top Rated',
                    onTap: () =>
                        Navigator.pushNamed(context, topRatedMovieRoutes),
                  ),
                  Consumer<MovieListNotifier>(builder: (context, data, child) {
                    final state = data.topRatedMoviesState;
                    if (state == RequestState.Loading) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state == RequestState.Loaded) {
                      return MovieList(data.topRatedMovies);
                    } else {
                      return Text('Failed');
                    }
                  }),
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
