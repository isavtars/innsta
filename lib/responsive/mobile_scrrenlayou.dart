import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:innsta/utils/app_styles.dart';

import '../screen/account_screen.dart';
import '../screen/add_postscreen.dart';
import '../screen/feed_screen.dart';

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({super.key});

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  String username = "";

  @override
  void initState() {
    userName();
    super.initState();
  }

  //get user name from fireStore
  void userName() async {
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    // debugPrint(
    //     " the user name is ${(snap.data() as Map<String, dynamic>)['username']}");
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
    return Scaffold(
      body: SafeArea(
        child: PageView(
          physics: const NeverScrollableScrollPhysics(),
          children: [
            FeedScreen(),
            Text("Home"),
            AddPostScreen(),
            Text("Home"),
            AccountScreen()
          ],
          controller: _pageController,
          onPageChanged: onPageChangesd,
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
