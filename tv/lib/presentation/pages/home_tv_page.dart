// ignore_for_file: prefer_const_constructors

import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tv/tv.dart';

class HomeTVPage extends StatefulWidget {
  const HomeTVPage({Key? key}) : super(key: key);

  @override
  _HomeTVPageState createState() => _HomeTVPageState();
}

class _HomeTVPageState extends State<HomeTVPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<TvListBloc>().add(OnTvShowListCalled());
      context.read<TvPopularBloc>().add(OnTvPopularCalled());
      context.read<TvTopRatedBloc>().add(OnTvTopRatedCalled());
    });
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
                  BlocBuilder<TvListBloc, TvListState>(
                    builder: (context, state) {
                      if (state is TvListLoading) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is TvListHasData) {
                        return TVListLayout(
                          tv: state.result,
                          height: 200,
                          isReplacement: false,
                        );
                      } else if (state is TvListEmpty) {
                        return Center(
                          child: Text('There are no tv currently showing'),
                        );
                      } else if (state is TvListError) {
                        return Center(
                          child: Text(state.message),
                        );
                      } else {
                        return SizedBox();
                      }
                    },
                  ),
                  _buildSubHeading(
                    title: 'Popular TV Shows',
                    onTap: () {
                      Navigator.pushNamed(context, popularTVRoutes);
                    },
                  ),
                  BlocBuilder<TvPopularBloc, TvPopularState>(
                    builder: (context, state) {
                      if (state is TvPopularLoading) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is TvPopularHasData) {
                        return TVListLayout(
                          tv: state.result,
                          height: 200,
                          isReplacement: false,
                        );
                      } else if (state is TvPopularEmpty) {
                        return Center(
                          child: Text('There are no tv popular showing'),
                        );
                      } else if (state is TvPopularError) {
                        return Center(
                          child: Text(state.message),
                        );
                      } else {
                        return SizedBox();
                      }
                    },
                  ),
                  _buildSubHeading(
                    title: 'Top Rated',
                    onTap: () {
                      Navigator.pushNamed(context, topRatedTVRoutes);
                    },
                  ),
                  BlocBuilder<TvTopRatedBloc, TvTopRatedState>(
                    builder: (context, state) {
                      if (state is TvTopRatedLoading) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is TvTopRatedHasData) {
                        return TVListLayout(
                          tv: state.result,
                          height: 200,
                          isReplacement: false,
                        );
                      } else if (state is TvTopRatedEmpty) {
                        return Center(
                          child: Text('There are no tv top rated showing'),
                        );
                      } else if (state is TvTopRatedError) {
                        return Center(
                          child: Text(state.message),
                        );
                      } else {
                        return SizedBox();
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
