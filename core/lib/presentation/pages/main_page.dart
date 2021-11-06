// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:core/styles/text_styles.dart';
import '../../utils/constants.dart';
import '../../utils/state_enum.dart';
import '../../domain/entities/movie_entities/movie.dart';
import '../../domain/entities/tv_entities/tv.dart';
import 'home_movie_page.dart';
import 'home_tv_page.dart';
import 'movie_detail_page.dart';
import 'tv_detail_page.dart';
import 'watchlist_movies_page.dart';
import '../../presentation/provider/movies_provider/movie_list_notifier.dart';
import '../../presentation/provider/tv_provider/tv_list_notifier.dart';
import '../../presentation/widgets/custom_drawer.dart';
import '../../presentation/widgets/movie_list.dart';
import '../../presentation/widgets/tv_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  static const ROUTE_NAME = '/main-pages';
  static const LOCATION = 'main_pages';

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
        location: MainPage.LOCATION,
        content: Scaffold(
          appBar: AppBar(
            leading: Icon(Icons.menu),
            title: Text('Ditonton'),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    WatchlistMoviesPage.ROUTE_NAME,
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
                        HomeMoviePage.ROUTE_NAME,
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
                        HomeTVPage.ROUTE_NAME,
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
              MovieDetailPage.ROUTE_NAME,
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
              TVDetailPage.ROUTE_NAME,
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
