// ignore_for_file: prefer_const_constructors

import 'package:core/core.dart';
import 'package:core/presentation/widgets/movie_card_list.dart';
import 'package:core/presentation/widgets/tv_card_list.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search/bloc/search_bloc.dart';

import '../provider/tv_search_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatelessWidget {
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
          onChanged: (query) {
            context.read<SearchBloc>().add(OnQueryChange(query));
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
        BlocBuilder<SearchBloc, SearchState>(
          builder: (context, state) {
            if (state is SearchLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is SearchHasData) {
              final result = state.result;
              return Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(8.0),
                  itemBuilder: (context, index) {
                    final movie = result[index];
                    return MovieCard(
                      movie: movie,
                      isWatchlist: false,
                    );
                  },
                  itemCount: result.length,
                ),
              );
            } else if (state is SearchError) {
              return Expanded(
                child: Center(
                  child: Text(state.message),
                ),
              );
            } else if (state is SearchEmpty) {
              return Expanded(
                child: Center(
                  child: Text(
                    'Yah, Film yang kamu cari gak ada :(',
                    style: kSubtitle,
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            } else {
              return SizedBox();
            }
          },
        )
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
            } else if (data.state == RequestState.Empty) {
              return Expanded(
                child: Center(
                  child: Text(
                    data.message,
                    style: kSubtitle,
                    textAlign: TextAlign.center,
                  ),
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
