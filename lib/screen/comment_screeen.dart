import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:innsta/provider/user_provider.dart';
import 'package:innsta/utils/app_styles.dart';
import 'package:innsta/utils/utils.dart';
import 'package:provider/provider.dart';

import '../model/user_model.dart';
import '../resources/firestroe_methods.dart';
import '../widgets/comments_cards.dart';

class CommentScreen extends StatefulWidget {
  const CommentScreen({super.key, required this.PostId});

  final String PostId;
  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  final TextEditingController commentEditingController =
      TextEditingController();

  void postComments(String uid, String userName, String profileImages) async {
    try {
      String res = await FirebaseStore().comments(commentEditingController.text,
          widget.PostId, uid, userName, profileImages);

      if (res == 'success') {
        showSnackBar(context, res);

        setState(() {
          commentEditingController.text = "";
        });
      } else {
        showSnackBar(context, res);
      }
    } catch (err) {
      showSnackBar(context, err.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: mobileBackgroundColor,
          title: const Text("Comments"),
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('posts')
              .doc(widget.PostId)
              .collection('comments')
              .snapshots(),
          builder: (context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (ctx, index) => CommentCard(
                snap: snapshot.data!.docs[index],
              ),
            );
          },
        ),
        bottomNavigationBar: SafeArea(
            child: Container(
                height: kToolbarHeight,
                margin: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                padding: const EdgeInsets.only(left: 16, right: 8),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(user.photoUrl),
                      radius: 18,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16, right: 8),
                        child: TextField(
                          controller: commentEditingController,
                          decoration: InputDecoration(
                            hintText: 'Comment as ${user.username}',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 8),
                          child: IconButton(
                              onPressed: () => postComments(
                                  user.uid, user.username, user.photoUrl),
                              icon: const Icon(Icons.send))),
                    )
                  ],
                ))));
  }
}
