import 'package:emart_app/consts/consts.dart';

class FirestoreServices {
  //get user dataaaa
  static getUser(uid) {
    return firestore
        .collection(usersCollection)
        .where('id', isEqualTo: uid)
        .snapshots();
  }
}
