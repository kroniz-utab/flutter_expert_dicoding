// ignore_for_file: prefer_const_constructors

import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/movie.dart';

class PopularMoviesPage extends StatefulWidget {
  const PopularMoviesPage({Key? key}) : super(key: key);

  @override
  _PopularMoviesPageState createState() => _PopularMoviesPageState();
}

class _PopularMoviesPageState extends State<PopularMoviesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => context.read<MoviePopularBloc>().add(OnMoviePopularCalled()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<MoviePopularBloc, MoviePopularState>(
          key: Key('this_is_popular_page'),
          builder: (context, state) {
            if (state is MoviePopularLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is MoviePopularHasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final movie = state.result[index];
                  return MovieCard(
                    key: Key('card_$index'),
                    movie: movie,
                    isWatchlist: false,
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        movieDetailRoutes,
                        arguments: movie.id,
                      );
                    },
                  );
                },
                itemCount: state.result.length,
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
                  key: Key('empty_data'),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
