// ignore_for_file: prefer_const_constructors

import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../presentation/provider/popular_tv_notifier.dart';

class PopularTVPage extends StatefulWidget {
  const PopularTVPage({Key? key}) : super(key: key);

  @override
  _PopularTVPageState createState() => _PopularTVPageState();
}

class _PopularTVPageState extends State<PopularTVPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<PopularTVNotifier>(context, listen: false)
            .fetchPopularTVShows());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular TV Shows'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<PopularTVNotifier>(
          builder: (context, data, child) {
            if (data.state == RequestState.Loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (data.state == RequestState.Loaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tvShow = data.tvShows[index];
                  return TVShowCard(
                    tv: tvShow,
                    isWatchlist: false,
                  );
                },
                itemCount: data.tvShows.length,
              );
            } else {
              return Center(
                child: Text(data.message),
                key: Key('error_message'),
              );
            }
          },
        ),
      ),
    );
  }
}
