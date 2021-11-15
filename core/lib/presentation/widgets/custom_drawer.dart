// ignore_for_file: prefer_const_constructors

import 'package:core/utils/routes.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatefulWidget {
  final String location;
  final Widget content;

  const CustomDrawer({
    Key? key,
    required this.location,
    required this.content,
  }) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
  }

  void toggle() => _animationController.isDismissed
      ? _animationController.forward()
      : _animationController.reverse();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: toggle,
      child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            double slide = 250.0 * _animationController.value;

            return Stack(
              children: [
                _buildDrawer(),
                Transform(
                  transform: Matrix4.identity()..translate(slide),
                  alignment: Alignment.centerLeft,
                  child: widget.content,
                ),
              ],
            );
          }),
    );
  }

  Widget _buildDrawer() {
    return Column(
      children: [
        UserAccountsDrawerHeader(
          currentAccountPicture: CircleAvatar(
            backgroundImage: AssetImage('assets/circle-g.png'),
          ),
          accountName: Text('Ditonton'),
          accountEmail: Text('ditonton@dicoding.com'),
        ),
        ListTile(
          leading: Icon(Icons.home),
          title: Text('Home'),
          onTap: () {
            if (widget.location != mainRoutes) {
              Navigator.pushNamed(context, mainRoutes);
              toggle();
            } else {
              toggle();
            }
          },
        ),
        ListTile(
          leading: Icon(Icons.movie),
          title: Text('Movies'),
          onTap: () {
            if (widget.location != movieRoutes) {
              Navigator.pushNamed(context, movieRoutes);
              toggle();
            } else {
              toggle();
            }
          },
        ),
        ListTile(
          leading: Icon(Icons.live_tv),
          title: Text('TV Show'),
          onTap: () {
            if (widget.location != tvRoutes) {
              Navigator.pushNamed(context, tvRoutes);
              toggle();
            } else {
              toggle();
            }
          },
        ),
        ListTile(
          leading: Icon(Icons.save_alt),
          title: Text('Watchlist'),
          onTap: () {
            if (widget.location != watchlistRoutes) {
              Navigator.pushNamed(context, watchlistRoutes);
              toggle();
            } else {
              toggle();
            }
          },
        ),
        ListTile(
          onTap: () {
            if (widget.location != aboutRoutes) {
              Navigator.pushNamed(context, aboutRoutes);
              toggle();
            } else {
              toggle();
            }
          },
          leading: Icon(Icons.info_outline),
          title: Text('About'),
        ),
      ],
    );
  }
}
