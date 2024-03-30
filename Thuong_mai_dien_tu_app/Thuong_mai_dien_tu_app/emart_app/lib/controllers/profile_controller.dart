import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class ProfileController extends GetxController {
  var profileImgPath = ''.obs;
  var profileImageLink = '';
  var isloading = false.obs;

  // Text fields
  var nameController = TextEditingController();
  var oldpassController = TextEditingController();
  var newpassController = TextEditingController();

  void changeImage(BuildContext context) async {
    try {
      final img = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 70,
      );
      if (img == null) return;
      profileImgPath.value = img.path;
    } on PlatformException catch (e) {
      VxToast.show(context as BuildContext, msg: e.toString());
    }
  }

  Future<void> uploadProfileImage() async {
    var filename = basename(profileImgPath.value);
    var destination = 'image/${currenUser!.uid}/$filename';
    Reference ref = FirebaseStorage.instance.ref().child(destination);
    await ref.putFile(File(profileImgPath.value));
    profileImageLink = await ref.getDownloadURL();
  }

  Future<void> updateProfile(
      {required String name,
      required String password,
      required String imgUrl}) async {
    var store = FirebaseFirestore.instance
        .collection(usersCollection)
        .doc(currenUser!.uid);
    await store.set({
      'name': name,
      'password': password,
      'imageUrl': imgUrl,
    }, SetOptions(merge: true));
    isloading.value = false;
  }

  changeAuthPassword({email, passord, newpassword}) async {
    final cred = EmailAuthProvider.credential(email: email, password: password);

    await currenUser!.reauthenticateWithCredential(cred).then((value) {
      currenUser!.updatePassword(newpassword);
    }).catchError((error) {
      print(error.toString());
    });
  }
}
