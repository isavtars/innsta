import 'package:flutter/material.dart';
import 'package:innsta/model/user_model.dart' as model;
import 'package:innsta/provider/user_provider.dart';

import 'package:innsta/utils/app_styles.dart';
import 'package:provider/provider.dart';

import '../screen/profile_screen.dart';
import '../screen/add_postscreen.dart';
import '../screen/feed_screen.dart';
import '../screen/search_screen.dart';

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({super.key});

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  @override
  void initState() {
    super.initState();
  }

  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void onPageIabe(int page) {
    _pageController.jumpToPage(page);
  }

  void onPageChangesd(int page) {
    setState(() {
      _page = page;
    });
  }

  int _page = 0;

  @override
  Widget build(BuildContext context) {
    final model.User user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      body: SafeArea(
        child: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: _pageController,
          onPageChanged: onPageChangesd,
          children: [
            const FeedScreen(),
            const Searchscreen(),
            const AddPostScreen(),
            const Text("Home"),
            ProfileScreen(
              uid: user.uid,
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
          onTap: onPageIabe,
          currentIndex: _page,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              backgroundColor: mobileBackgroundColor,
              icon: Icon(
                Icons.home,
                color: _page == 0 ? kWhite : Colors.grey,
              ),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
                color: _page == 1 ? kWhite : Colors.grey,
              ),
              label: "",
            ),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.add_circle,
                  color: _page == 2 ? kWhite : Colors.grey,
                ),
                label: ""),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.favorite,
                  color: _page == 3 ? kWhite : Colors.grey,
                ),
                label: ""),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                  color: _page == 4 ? kWhite : Colors.grey,
                ),
                label: "")
          ]),
    );
  }
}
