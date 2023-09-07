import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:we_chat/models/chat_user.dart';
// import 'package:firebase_core/firebase_core.dart';

class APIs {
  //For authorization
  static FirebaseAuth auth = FirebaseAuth.instance;

  //for saving contents in the data base or communcating with it
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  //to return the current user (if not null)
  static User get user => auth.currentUser!;

  // for checking if the user exists or not
  static Future<bool> checkUser() async {
    return (await firestore
            .collection('users')
            .doc(auth.currentUser!.uid)
            .get())
        .exists;
  }

  //for creating a new user
  static Future<void> createUser() async {
    final time = DateTime.now().millisecondsSinceEpoch.toString();

    final user = ChatUser(
        image: auth.currentUser!.photoURL.toString(),
        name: auth.currentUser!.displayName.toString(),
        about: 'Hey i am using we Chat',
        createdAt: time,
        lastActive: time,
        isOnline: false,
        id: auth.currentUser!.uid,
        pushToken: '');

    return await firestore.collection('users').doc(auth.currentUser!.uid).set(user.toJson());
  }
}
