// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:core/core.dart';
import 'package:core/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:movie/movie.dart';
import 'package:provider/provider.dart';
import 'package:tv/tv.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => Provider.of<MovieListNotifier>(context, listen: false)
        ..fetchNowPlayingMovies()
        ..fetchPopularMovies(),
    );
    Future.microtask(() => Provider.of<TVListNotifier>(context, listen: false)
      ..fetchTVOnTheAir()
      ..fetchPopularTVShows());
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: CustomDrawer(
        location: mainRoutes,
        content: Scaffold(
          appBar: AppBar(
            leading: Icon(Icons.menu),
            title: Text('Ditonton'),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    watchlistRoutes,
                  );
                },
                icon: Icon(Icons.save_alt),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Movies Now Playing',
                    style: kHeading6,
                  ),
                  SizedBox(height: 10),
                  Consumer<MovieListNotifier>(
                    builder: (context, data, child) {
                      final state = data.nowPlayingState;
                      if (state == RequestState.Loading) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state == RequestState.Loaded) {
                        final listMovies = data.nowPlayingMovies;
                        return _buildMoviesCarousel(listMovies);
                      } else {
                        return Text('Failed');
                      }
                    },
                  ),
                  SizedBox(height: 10),
                  _buildSubHeading(
                    title: 'Hot Movies 🔥',
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        movieRoutes,
                      );
                    },
                  ),
                  SizedBox(height: 10),
                  Consumer<MovieListNotifier>(
                    builder: (context, data, child) {
                      final state = data.nowPlayingState;
                      if (state == RequestState.Loading) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state == RequestState.Loaded) {
                        final listMovies = data.nowPlayingMovies;
                        return MovieList(listMovies);
                      } else {
                        return Text('Failed');
                      }
                    },
                  ),
                  Text(
                    'TV On The Air',
                    style: kHeading6,
                  ),
                  SizedBox(height: 10),
                  Consumer<TVListNotifier>(
                    builder: (context, data, child) {
                      final state = data.tvOnTheAirState;
                      if (state == RequestState.Loading) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state == RequestState.Loaded) {
                        final listTV = data.tvOnTheAir;
                        return _buildTVCarousel(listTV);
                      } else {
                        return Text('Failed');
                      }
                    },
                  ),
                  SizedBox(height: 10),
                  _buildSubHeading(
                    title: 'Hot TV Shows 🔥',
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        tvRoutes,
                      );
                    },
                  ),
                  SizedBox(height: 10),
                  Consumer<TVListNotifier>(
                    builder: (context, data, child) {
                      final state = data.tvOnTheAirState;
                      if (state == RequestState.Loading) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state == RequestState.Loaded) {
                        final listTV = data.tvOnTheAir;
                        return TVListLayout(
                          tv: listTV,
                          height: 200,
                          isReplacement: false,
                        );
                      } else {
                        return Text('Failed');
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

  CarouselSlider _buildMoviesCarousel(List<Movie> list) {
    return CarouselSlider.builder(
      itemCount: list.length,
      itemBuilder: (context, index, realIndex) {
        final content = list[index];
        return InkWell(
          onTap: () {
            Navigator.pushNamed(
              context,
              movieDetailRoutes,
              arguments: content.id,
            );
          },
          child: Stack(
            fit: StackFit.expand,
            children: [
              Positioned.fill(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: content.backdropPath != null
                        ? '$BASE_IMAGE_URL${content.backdropPath}'
                        : '$BASE_IMAGE_URL${content.posterPath}',
                    placeholder: (context, url) => Center(
                      child: CircularProgressIndicator(),
                    ),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(.7),
                      Colors.black.withOpacity(.9),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: const [0.3, 0.6, 0.9],
                  ),
                ),
              ),
              Positioned(
                top: 150,
                left: 10,
                right: 10,
                bottom: 10,
                child: Text(
                  content.title.toString(),
                  style: kHeading5,
                  maxLines: 1,
                  overflow: TextOverflow.clip,
                ),
              )
            ],
          ),
        );
      },
      options: CarouselOptions(
        height: 200,
        viewportFraction: 1.0,
        enlargeCenterPage: true,
        enableInfiniteScroll: true,
        autoPlay: true,
      ),
    );
  }

  CarouselSlider _buildTVCarousel(List<TV> list) {
    return CarouselSlider.builder(
      itemCount: list.length,
      itemBuilder: (context, index, realIndex) {
        final content = list[index];
        return InkWell(
          onTap: () {
            Navigator.pushNamed(
              context,
              tvDetailRoutes,
              arguments: content.id,
            );
          },
          child: Stack(
            fit: StackFit.expand,
            children: [
              Positioned.fill(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: content.backdropPath != null
                        ? '$BASE_IMAGE_URL${content.backdropPath}'
                        : '$BASE_IMAGE_URL${content.posterPath}',
                    placeholder: (context, url) => Center(
                      child: CircularProgressIndicator(),
                    ),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(.7),
                      Colors.black.withOpacity(.9),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: const [0.3, 0.6, 0.9],
                  ),
                ),
              ),
              Positioned(
                top: 150,
                left: 10,
                right: 10,
                bottom: 10,
                child: Text(
                  content.name.toString(),
                  style: kHeading5,
                  maxLines: 1,
                  overflow: TextOverflow.clip,
                ),
              )
            ],
          ),
        );
      },
      options: CarouselOptions(
        height: 200,
        viewportFraction: 1.0,
        enlargeCenterPage: true,
        enableInfiniteScroll: true,
        autoPlay: true,
      ),
    );
  }
}
