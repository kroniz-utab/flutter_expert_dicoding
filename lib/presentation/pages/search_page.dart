import 'package:ditonton/presentation/provider/tv_provider/tv_search_notifier.dart';
import 'package:ditonton/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/provider/movies_provider/movie_search_notifier.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';

class SearchPage extends StatelessWidget {
  static const ROUTE_NAME = '/search';
  final bool isMovieSearch;
  const SearchPage({
    Key? key,
    required this.isMovieSearch,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: isMovieSearch
            ? _buildSearchForMovies(context)
            : _buildSearchForTVShow(context),
      ),
    );
  }

  Column _buildSearchForMovies(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          onSubmitted: (query) {
            Provider.of<MovieSearchNotifier>(context, listen: false)
                .fetchMovieSearch(query);
          },
          decoration: InputDecoration(
            hintText: 'Search Movies Title',
            prefixIcon: Icon(Icons.search),
            border: OutlineInputBorder(),
          ),
          textInputAction: TextInputAction.search,
        ),
        SizedBox(height: 16),
        Text(
          'Search Result',
          style: kHeading6,
        ),
        Consumer<MovieSearchNotifier>(
          builder: (context, data, child) {
            if (data.state == RequestState.Loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (data.state == RequestState.Loaded) {
              final result = data.searchResult;
              return Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemBuilder: (context, index) {
                    final movie = data.searchResult[index];
                    return MovieCard(
                      movie: movie,
                      isWatchlist: false,
                    );
                  },
                  itemCount: result.length,
                ),
              );
            } else {
              return Expanded(
                child: Container(),
              );
            }
          },
        ),
      ],
    );
  }

  Column _buildSearchForTVShow(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          onSubmitted: (query) {
            Provider.of<TVSearchNotifier>(context, listen: false)
                .fetchTVSerach(query);
          },
          decoration: InputDecoration(
            hintText: 'Search TV Show Title',
            prefixIcon: Icon(Icons.search),
            border: OutlineInputBorder(),
          ),
          textInputAction: TextInputAction.search,
        ),
        SizedBox(height: 16),
        Text(
          'Search Result',
          style: kHeading6,
        ),
        Consumer<TVSearchNotifier>(
          builder: (context, data, child) {
            if (data.state == RequestState.Loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (data.state == RequestState.Loaded) {
              final result = data.searchResult;
              return Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemBuilder: (context, index) {
                    final tv = data.searchResult[index];
                    return TVShowCard(
                      tv: tv,
                      isWatchlist: false,
                    );
                  },
                  itemCount: result.length,
                ),
              );
            } else {
              return Expanded(
                child: Container(),
              );
            }
          },
        ),
      ],
    );
  }
}
