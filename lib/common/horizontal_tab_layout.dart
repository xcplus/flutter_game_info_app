import 'package:flutter/material.dart';
import 'package:video_game_messaging_app/common/forum_card.dart';
import 'package:video_game_messaging_app/common/tab_text.dart';
import 'package:video_game_messaging_app/model/forum.dart';

class HorizontalTabLayout extends StatefulWidget {
  @override
  _HorizontalTabLayoutState createState() => _HorizontalTabLayoutState();
}


// transition的几种类别
// FadeTransition ScaleTransition SizeTransition SlideTransition


class _HorizontalTabLayoutState extends State<HorizontalTabLayout> with SingleTickerProviderStateMixin {

  int selectedTabIndex = 2;
  AnimationController _controller;
  Animation<Offset> _animation;
  Animation<double> _fadeInAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(milliseconds: 1000));
    _animation = Tween<Offset>(begin: Offset(0,0), end: Offset(-0.05,0)).animate(_controller);
    _fadeInAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
  }

  playAnimation() {
    _controller.reset();
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500.0,
      child: Stack(
        children: <Widget>[
          Positioned(
            left: -25,
            bottom: 0,
            top: 0,
            width: 100.0,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 80.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TabText(
                    text: "Media",
                    isSelected: selectedTabIndex == 0,
                    onTabTap: () => onTabTap(0),
                  ),
                  TabText(
                    text: "Streamers",
                    isSelected: selectedTabIndex == 1,
                    onTabTap: () => onTabTap(1),
                  ),
                  TabText(
                    text: "Forum",
                    isSelected: selectedTabIndex == 2,
                    onTabTap: () => onTabTap(2),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 65.0),
            child: FutureBuilder(
              future: playAnimation(),
              builder: (context, snapshot) {
                return FadeTransition(
                  opacity: _fadeInAnimation,
                  child: SlideTransition(
                    position: _animation,
                    child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: getList(selectedTabIndex),
                      ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> getList(index) {
    return [
      [
        ForumCard(forum: fortniteForum),
        ForumCard(forum: pubgForum),
      ],
      [
        ForumCard(forum: pubgForum),
        ForumCard(forum: fortniteForum),
      ],
      [
        ForumCard(forum: fortniteForum),
        ForumCard(forum: pubgForum),
      ],
    ][index];
  }

  void onTabTap(int index) {
    setState(() {
      selectedTabIndex = index;
    });
  }
}
