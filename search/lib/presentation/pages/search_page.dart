// ignore_for_file: prefer_const_constructors

import 'package:core/core.dart';
import 'package:core/presentation/widgets/movie_card_list.dart';
import 'package:core/presentation/widgets/tv_card_list.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search/search.dart';

import 'package:flutter/material.dart';

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
            context.read<SearchMoviesBloc>().add(OnQueryMoviesChange(query));
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
        BlocBuilder<SearchMoviesBloc, SearchMoviesState>(
          builder: (context, state) {
            if (state is SearchMoviesLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is SearchMoviesHasData) {
              final result = state.result;
              return Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(8.0),
                  itemBuilder: (context, index) {
                    final movie = result[index];
                    return MovieCard(
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
                  itemCount: result.length,
                ),
              );
            } else if (state is SearchMoviesError) {
              return Expanded(
                child: Center(
                  child: Text(state.message),
                ),
              );
            } else if (state is SearchMoviesEmpty) {
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
          onChanged: (query) {
            context.read<SearchTvBloc>().add(OnQueryTvChange(query));
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
        BlocBuilder<SearchTvBloc, SearchTvState>(
          builder: (context, state) {
            if (state is SearchTvLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is SearchTvHasData) {
              final result = state.result;
              return Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(8.0),
                  itemBuilder: (context, index) {
                    final tv = result[index];
                    return TVShowCard(
                      tv: tv,
                      isWatchlist: false,
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          tvDetailRoutes,
                          arguments: tv.id,
                        );
                      },
                    );
                  },
                  itemCount: result.length,
                ),
              );
            } else if (state is SearchTvError) {
              return Expanded(
                child: Center(
                  child: Text(state.message),
                ),
              );
            } else if (state is SearchTvEmpty) {
              return Expanded(
                child: Center(
                  child: Text(
                    'Yah, Tv Show yang kamu cari gak ada :(',
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
}
