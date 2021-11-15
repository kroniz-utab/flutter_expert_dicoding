// ignore_for_file: prefer_const_constructors

import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tv/presentation/provider/tv_list_notifier.dart';

class HomeTVPage extends StatefulWidget {
  const HomeTVPage({Key? key}) : super(key: key);

  @override
  _HomeTVPageState createState() => _HomeTVPageState();
}

class _HomeTVPageState extends State<HomeTVPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => Provider.of<TVListNotifier>(context, listen: false)
        ..fetchTVOnTheAir()
        ..fetchPopularTVShows()
        ..fetchTopRatedTVShows(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: CustomDrawer(
        location: tvRoutes,
        content: Scaffold(
          appBar: AppBar(
            leading: Icon(Icons.menu),
            title: Text('TV Show'),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    searchRoutes,
                    arguments: false,
                  );
                },
                icon: Icon(Icons.search),
              )
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'On The Air',
                    style: kHeading6,
                  ),
                  Consumer<TVListNotifier>(builder: (context, data, child) {
                    final state = data.tvOnTheAirState;
                    if (state == RequestState.Loading) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state == RequestState.Loaded) {
                      return TVListLayout(
                        tv: data.tvOnTheAir,
                        height: 200,
                        isReplacement: false,
                      );
                    } else {
                      return Text('Failed');
                    }
                  }),
                  _buildSubHeading(
                    title: 'Popular TV Shows',
                    onTap: () {
                      Navigator.pushNamed(context, popularTVRoutes);
                    },
                  ),
                  Consumer<TVListNotifier>(builder: (context, data, child) {
                    final state = data.popularTVShowsState;
                    if (state == RequestState.Loading) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state == RequestState.Loaded) {
                      return TVListLayout(
                        tv: data.popularTVShows,
                        height: 200,
                        isReplacement: false,
                      );
                    } else {
                      return Text('Failed');
                    }
                  }),
                  _buildSubHeading(
                    title: 'Top Rated',
                    onTap: () {
                      Navigator.pushNamed(context, topRatedTVRoutes);
                    },
                  ),
                  Consumer<TVListNotifier>(builder: (context, data, child) {
                    final state = data.topRatedTVShowsState;
                    if (state == RequestState.Loading) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state == RequestState.Loaded) {
                      return TVListLayout(
                        tv: data.topRatedTVShows,
                        height: 200,
                        isReplacement: false,
                      );
                    } else {
                      return Text('Failed');
                    }
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: const [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}
