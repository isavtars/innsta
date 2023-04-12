import 'dart:typed_data';
import 'package:innsta/model/postmodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:innsta/resources/storage_method.dart';
import 'package:uuid/uuid.dart';

class FirebaseStore {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //upload post

  Future<String> uploadsPost(
      String descriptions,
    Uint8List file,
   String userName,
    String uid,
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
}
