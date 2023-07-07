import 'dart:typed_data';
import 'package:instagram/model/post_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram/resources/storage_method.dart';
import 'package:logger/logger.dart';
import 'package:uuid/uuid.dart';

class FirebaseStore {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var logger = Logger();

  //upload post
  Future<String> uploadsPost(
    String descriptions,
    Uint8List file,
    String uid,
    String userName,
    String profileImages,
  ) async {
    String res = "Something error occures";
    try {
      String photurl = await StorageMehods().uplodaImages('Posts', file, true);

      String postId = const Uuid().v1(); // creates unique id based on time

      Postmodel post = Postmodel(
        descriptions: descriptions,
        uid: uid,
        postId: postId,
        likes: [],
        userName: userName,
        postUrl: photurl,
        postImages: profileImages,
        datePublised: DateTime.now(),
      );
      await _firestore.collection('posts').doc(postId).set(post.toJson());
      res = "success";
    } catch (err) {
      res = err.toString();
    }

    return res;
  }

  // like post

  Future<String> likePost(String postId, String uid, List likes) async {
    String res = "Something errors ocures";
    try {
      if (likes.contains(uid)) {
        // if the likes list contains the user uid, we need to remove it
        _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayRemove([uid])
        });
      } else {
        // else we need to add uid to the likes array
        await _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayUnion([uid])
        });
      }
      res = "sucess";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  //comments post
  Future<String> comments(String commentstext, String postId, String uid,
      String userName, String profileImages) async {
    String res = "Somethings errors occures";
    try {
      String comentId = const Uuid().v1();
      if (commentstext.isNotEmpty) {
        await _firestore
            .collection('posts')
            .doc(postId)
            .collection('comments')
            .doc(comentId)
            .set({
          "comentstext": commentstext,
          "postId": postId,
          "uid": uid,
          "userName": userName,
          "profileImages": profileImages,
          "commentId": comentId,
          "datePublissed": DateTime.now()
        });
        res = "success";
      } else {
        res = "please do comment first";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  //deleteComments
  Future<String> deleteComments(String postId, String commentsId) async {
    String res = "Something errors ocures";
    try {
      await _firestore
          .collection('posts')
          .doc(postId)
          .collection('comments')
          .doc(commentsId)
          .delete();
      res = "success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  //delete post
  Future<String> deletePost(String postId) async {
    String res = "Something errors ocures";
    try {
      await _firestore.collection('posts').doc(postId).delete();
      res = "sucess";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<void> followUser(String uid, String followId) async {
    try {
      DocumentSnapshot snap =
          await _firestore.collection('users').doc(uid).get();
      List following = (snap.data()! as dynamic)['following'];

      if (following.contains(followId)) {
        await _firestore.collection('users').doc(followId).update({
          'followers': FieldValue.arrayRemove([uid])
        });

        await _firestore.collection('users').doc(uid).update({
          'following': FieldValue.arrayRemove([followId])
        });
      } else {
        await _firestore.collection('users').doc(followId).update({
          'followers': FieldValue.arrayUnion([uid])
        });

        await _firestore.collection('users').doc(uid).update({
          'following': FieldValue.arrayUnion([followId])
        });
      }
    } catch (e) {
      logger.e(e.toString());
    }
  }
}
