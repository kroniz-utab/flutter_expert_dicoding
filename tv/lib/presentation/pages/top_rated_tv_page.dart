// ignore_for_file: prefer_const_constructors

import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/top_rated_tv_notifier.dart';

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
      () => Provider.of<TopRatedTVNotifier>(context, listen: false)
          .fetchTopRatedTVShows(),
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
        child: Consumer<TopRatedTVNotifier>(
          builder: (context, data, child) {
            if (data.state == RequestState.Loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (data.state == RequestState.Loaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tvShow = data.tvList[index];
                  return TVShowCard(
                    tv: tvShow,
                    isWatchlist: false,
                  );
                },
                itemCount: data.tvList.length,
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
