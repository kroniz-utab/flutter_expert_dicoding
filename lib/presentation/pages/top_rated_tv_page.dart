import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/provider/tv_provider/top_rated_tv_notifier.dart';
import 'package:ditonton/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TopRatedTVPage extends StatefulWidget {
  static const ROUTE_NAME = '/top-rated-tv';

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
