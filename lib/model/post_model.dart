class Postmodel {
  final String descriptions;
  final String uid;
  final String postId;
  final dynamic likes;
  final String userName;
  final String postUrl;
  final String postImages;
  final DateTime datePublised;

  Postmodel(
      {required this.descriptions,
      required this.uid,
      required this.postId,
      required this.likes,
      required this.userName,
      required this.postUrl,
      required this.postImages,
      required this.datePublised});

  Map<String, dynamic> toJson() => {
        "descriptions": descriptions,
        "uid": uid,
        "postId": postId,
        "likes": likes,
        "userName": userName,
        "postUrl": postUrl,
        "postImages": postImages,
        "datePublised": datePublised,
      };
}
