import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Thay đổi FirebaseFirestore thành cloud_firestore

FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore firestore = FirebaseFirestore.instance;
User? currenUser = auth.currentUser;

//collections
const usersCollection = "users";
