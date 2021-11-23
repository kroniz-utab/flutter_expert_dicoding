// ignore_for_file: prefer_const_constructors

import 'package:core/core.dart';
import 'package:core/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:watchlist/watchlist.dart';

class WatchlistMoviesPage extends StatefulWidget {
  const WatchlistMoviesPage({Key? key}) : super(key: key);

  @override
  _WatchlistMoviesPageState createState() => _WatchlistMoviesPageState();
}

class _WatchlistMoviesPageState extends State<WatchlistMoviesPage>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<MovieWatchlistBloc>().add(OnFetchMovieWatchlist());
      context.read<TvWatchlistBloc>().add(OnFetchTvWatchlist());
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    context.read<MovieWatchlistBloc>().add(OnFetchMovieWatchlist());
    context.read<TvWatchlistBloc>().add(OnFetchTvWatchlist());
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: CustomDrawer(
        location: watchlistRoutes,
        content: Scaffold(
          appBar: AppBar(
            leading: Icon(Icons.menu),
            title: Text('Watchlist'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              key: Key('this_is_watchlist'),
              child: Column(
                children: [
                  BlocBuilder<MovieWatchlistBloc, MovieWatchlistState>(
                    builder: (context, state) {
                      if (state is MovieWatchlistLoading) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is MovieWatchlistHasData) {
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            final movie = state.result[index];
                            return MovieCard(
                              key: Key('movie_card_$index'),
                              movie: movie,
                              isWatchlist: true,
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
                      } else if (state is MovieWatchlistError) {
                        return Center(
                          key: Key('error_message'),
                          child: Text(state.message),
                        );
                      } else {
                        return SizedBox(
                          key: Key('empty_data'),
                        );
                      }
                    },
                  ),
                  BlocBuilder<TvWatchlistBloc, TvWatchlistState>(
                    builder: (context, state) {
                      if (state is TvWatchlistLoading) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is TvWatchlistHasData) {
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            final tv = state.result[index];
                            return TVShowCard(
                              key: Key('tv_card_$index'),
                              tv: tv,
                              isWatchlist: true,
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  tvDetailRoutes,
                                  arguments: tv.id,
                                );
                              },
                            );
                          },
                          itemCount: state.result.length,
                        );
                      } else if (state is TvWatchlistError) {
                        return Center(
                          key: Key('error_message'),
                          child: Text(state.message),
                        );
                      } else {
                        return SizedBox(
                          key: Key('empty_data'),
                        );
                      }
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
