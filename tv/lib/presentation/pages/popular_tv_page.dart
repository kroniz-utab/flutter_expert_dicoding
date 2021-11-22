// ignore_for_file: prefer_const_constructors

import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tv/tv.dart';

class PopularTVPage extends StatefulWidget {
  const PopularTVPage({Key? key}) : super(key: key);

  @override
  _PopularTVPageState createState() => _PopularTVPageState();
}

class _PopularTVPageState extends State<PopularTVPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => context.read<TvPopularBloc>().add(OnTvPopularCalled()),
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
        child: BlocBuilder<TvPopularBloc, TvPopularState>(
          builder: (context, state) {
            if (state is TvPopularLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TvPopularHasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tv = state.result[index];
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
                itemCount: state.result.length,
              );
            } else if (state is TvPopularError) {
              return Expanded(
                child: Center(
                  child: Text(state.message),
                ),
              );
            } else if (state is TvPopularEmpty) {
              return Expanded(
                child: Center(
                  child: Text('There are no one popular tv show'),
                ),
              );
            } else {
              return SizedBox();
            }
          },
        ),
      ),
    );
  }
}
