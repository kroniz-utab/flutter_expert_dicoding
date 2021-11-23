// ignore_for_file: prefer_const_constructors

import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tv/tv.dart';

class TopRatedTVPage extends StatefulWidget {
  const TopRatedTVPage({Key? key}) : super(key: key);

  @override
  _TopRatedTVPageState createState() => _TopRatedTVPageState();
}

class _TopRatedTVPageState extends State<TopRatedTVPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => context.read<TvTopRatedBloc>().add(OnTvTopRatedCalled()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular TV Shows'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TvTopRatedBloc, TvTopRatedState>(
          key: Key('this_is_top_rated'),
          builder: (context, state) {
            if (state is TvTopRatedLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TvTopRatedHasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tv = state.result[index];
                  return TVShowCard(
                    key: Key('card_$index'),
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
                itemCount: state.result.length,
              );
            } else if (state is TvTopRatedError) {
              return Center(
                child: Text(
                  state.message,
                  key: Key('error_message'),
                ),
              );
            } else {
              return Center(
                child: Text(
                  'There are no one top rated tv show',
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
