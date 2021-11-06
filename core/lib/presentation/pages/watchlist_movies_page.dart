// ignore_for_file: prefer_const_constructors

import '../../utils/state_enum.dart';
import '../../utils/utils.dart';
import '../../presentation/provider/movies_provider/watchlist_movie_notifier.dart';
import '../../presentation/provider/tv_provider/watchlist_tv_notifier.dart';
import '../../presentation/widgets/custom_drawer.dart';
import '../../presentation/widgets/movie_card_list.dart';
import '../../presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WatchlistMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist';
  static const LOCATION = 'watchlist';

  const WatchlistMoviesPage({Key? key}) : super(key: key);

  @override
  _WatchlistMoviesPageState createState() => _WatchlistMoviesPageState();
}

class _WatchlistMoviesPageState extends State<WatchlistMoviesPage>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<WatchlistMovieNotifier>(context, listen: false)
            .fetchWatchlistMovies());
    Future.microtask(() =>
        Provider.of<WatchlistTVNotifier>(context, listen: false)
            .fetchWatchlistTVShow());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    Provider.of<WatchlistMovieNotifier>(context, listen: false)
        .fetchWatchlistMovies();
    Provider.of<WatchlistTVNotifier>(context, listen: false)
        .fetchWatchlistTVShow();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: CustomDrawer(
        location: WatchlistMoviesPage.LOCATION,
        content: Scaffold(
          appBar: AppBar(
            leading: Icon(Icons.menu),
            title: Text('Watchlist'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Consumer<WatchlistMovieNotifier>(
                    builder: (context, data, child) {
                      if (data.watchlistState == RequestState.Loading) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (data.watchlistState == RequestState.Empty) {
                        return SizedBox();
                      } else if (data.watchlistState == RequestState.Loaded) {
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            final movie = data.watchlistMovies[index];
                            return MovieCard(
                              movie: movie,
                              isWatchlist: true,
                            );
                          },
                          itemCount: data.watchlistMovies.length,
                        );
                      } else {
                        return Center(
                          key: Key('error_message'),
                          child: Text(data.message),
                        );
                      }
                    },
                  ),
                  Consumer<WatchlistTVNotifier>(
                    builder: (context, data, child) {
                      if (data.watchlistState == RequestState.Loading) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (data.watchlistState == RequestState.Empty) {
                        return SizedBox();
                      } else if (data.watchlistState == RequestState.Loaded) {
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            final tv = data.watchlistTVShow[index];
                            return TVShowCard(
                              tv: tv,
                              isWatchlist: true,
                            );
                          },
                          itemCount: data.watchlistTVShow.length,
                        );
                      } else {
                        return Center(
                          key: Key('error_message'),
                          child: Text(data.message),
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

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
