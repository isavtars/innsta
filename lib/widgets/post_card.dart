import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:social_share/social_share.dart';
import '../model/user_model.dart';
import '../provider/user_provider.dart';
import '../resources/firestroe_methods.dart';
import '../screen/comment_screeen.dart';
import '../utils/app_styles.dart';
import '../utils/utils.dart';
import 'like_animation.dart';
import 'package:intl/intl.dart';

class PostCard extends StatefulWidget {
  final dynamic snap;
  const PostCard({
    Key? key,
    required this.snap,
  }) : super(key: key);

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  int commentLen = 0;
  bool isLikeAnimating = false;

  @override
  void initState() {
    super.initState();
    fetchCommentLen();
  }

  fetchCommentLen() async {
    try {
      QuerySnapshot snap = await FirebaseFirestore.instance
          .collection('posts')
          .doc(widget.snap['postId'])
          .collection('comments')
          .get();
      commentLen = snap.docs.length;
    } catch (err) {
      showSnackBar(
        context,
        err.toString(),
      );
    }
  }

  deletePost(String postId) async {
    try {
      await FirebaseStore().deletePost(postId);
    } catch (err) {
      showSnackBar(
        context,
        err.toString(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<UserProvider>(context).getUser;
    // final width = MediaQuery.of(context).size.width;
    final logger = Logger();

    return Container(
      // boundary needed for web
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black
            // width > webScreenSize ? secondaryColor : mobileBackgroundColor,
            ),
        color: Colors.black,
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: Column(
        children: [
          // HEADER SECTION OF THE POST
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 4,
              horizontal: 16,
            ).copyWith(right: 0),
            child: Row(
              children: <Widget>[
                CircleAvatar(
                  radius: 18,
                  backgroundImage: NetworkImage(
                    widget.snap['postImages'].toString(),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 8,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          widget.snap['userName'].toString(),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
                widget.snap['uid'].toString() == user.uid
                    ? IconButton(
                        color: Colors.white,
                        onPressed: () {
                          showDialog(
                            useRootNavigator: false,
                            context: context,
                            builder: (context) {
                              return Dialog(
                                child: ListView(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16),
                                    shrinkWrap: true,
                                    children: [
                                      'Delete',
                                    ]
                                        .map(
                                          (e) => InkWell(
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 12,
                                                        horizontal: 16),
                                                child: Row(
                                                  children: [
                                                    const Padding(
                                                      padding: EdgeInsets.only(
                                                          right: 8.0),
                                                      child: Icon(
                                                        Icons.delete,
                                                        color: Colors.red,
                                                      ),
                                                    ),
                                                    Text(e,
                                                        style: const TextStyle(
                                                          color: Colors.red,
                                                        )),
                                                  ],
                                                ),
                                              ),
                                              onTap: () => deletePost(
                                                  widget.snap['postId'])),
                                        )
                                        .toList()),
                              );
                            },
                          );
                        },
                        icon: const Icon(Icons.more_vert),
                      )
                    : Container(),
              ],
            ),
          ),
          // IMAGE SECTION OF THE POST
          GestureDetector(
            onDoubleTap: () {
              FirebaseStore().likePost(
                  widget.snap['postId'], user.uid, widget.snap['likes']);
              setState(() {
                isLikeAnimating = true;
              });
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.35,
                  width: double.infinity,
                  child: Image.network(
                    widget.snap['postUrl'].toString(),
                    fit: BoxFit.cover,
                  ),
                ),
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: isLikeAnimating ? 1 : 0,
                  child: LikeAnimation(
                    isAnimating: isLikeAnimating,
                    duration: const Duration(
                      milliseconds: 400,
                    ),
                    onEnd: () {
                      setState(() {
                        isLikeAnimating = false;
                      });
                    },
                    child: const Icon(
                      Icons.favorite,
                      color: Color.fromARGB(255, 241, 15, 15),
                      size: 100,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // LIKE, COMMENT SECTION OF THE POST
          Row(
            children: <Widget>[
              LikeAnimation(
                isAnimating: widget.snap['likes'].contains(user.uid),
                smallLike: true,
                child: IconButton(
                    icon: widget.snap['likes'].contains(user.uid)
                        ? const Icon(
                            Icons.favorite,
                            color: Colors.red,
                          )
                        : const Icon(
                            Icons.favorite_border,
                            color: Colors.white,
                          ),
                    onPressed: () {
                      FirebaseStore().likePost(widget.snap['postId'], user.uid,
                          widget.snap['likes']);
                    }),
              ),
              IconButton(
                  icon: const Icon(
                    Icons.comment_outlined,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CommentScreen(
                                  postId: widget.snap['postId'].toString(),
                                )));
                  }),
              IconButton(
                  icon: const Icon(
                    Icons.send,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    showModalBottomSheet(
                      backgroundColor: Colors.black,
                      context: context,
                      builder: (BuildContext context) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ListTile(
                              leading: const Icon(
                                Icons.repeat,
                                color: Colors.white,
                              ),
                              title: const Text('Repost'),
                              onTap: () {
                                // Handle repost functionality here
                                Navigator.pop(
                                    context); // Close the bottom sheet
                              },
                            ),
                            ListTile(
                              leading: const Icon(
                                Icons.share,
                                color: Colors.white,
                              ),
                              title: const Text(
                                'Share',
                              ),
                              onTap: () {
                                // Share the post externally
                                SocialShare.shareOptions(
                                  'Check out this post: ${widget.snap['postUrl']}',
                                );
                                // Close the bottom sheet
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        );
                      },
                    );
                  }),
              Expanded(
                  child: Align(
                alignment: Alignment.bottomRight,
                child: IconButton(
                    icon: const Icon(
                      Icons.bookmark_border,
                      color: Colors.white,
                    ),
                    onPressed: () {}),
              ))
            ],
          ),
          //DESCRIPTION AND NUMBER OF COMMENTS
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                DefaultTextStyle(
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(fontWeight: FontWeight.w800),
                    child: Text(
                      '${widget.snap['likes'].length} likes',
                      style: Theme.of(context).textTheme.bodyMedium,
                    )),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(
                    top: 8,
                  ),
                  child: RichText(
                    text: TextSpan(
                      style: const TextStyle(color: primaryColor),
                      children: [
                        TextSpan(
                          text: widget.snap['userName'].toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: ' ${widget.snap['descriptions']}',
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Text(
                        'View all $commentLen comments',
                        style: const TextStyle(
                          fontSize: 16,
                          color: secondaryColor,
                        ),
                      ),
                    ),
                    onTap: () {
                      logger.e("All Comments");
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CommentScreen(
                                    postId: widget.snap['postId'].toString(),
                                  )));
                    }),
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    DateFormat.yMMMd().format(
                      widget.snap['datePublised'].toDate(),
                    ),
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
