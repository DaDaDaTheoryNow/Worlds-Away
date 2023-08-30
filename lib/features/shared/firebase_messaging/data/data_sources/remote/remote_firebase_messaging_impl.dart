import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:worlds_away/core/constants/constants.dart';
import 'package:worlds_away/features/shared/firebase_messaging/data/data_sources/remote/remote_firebase_messaging_repository.dart';

class RemoteFirebaseMessagingImpl implements RemoteFirebaseMessagingRepository {
  final FirebaseMessaging _firebaseMessaging;
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  RemoteFirebaseMessagingImpl(
      this._firebaseMessaging, this._firestore, this._auth);

  StreamSubscription? listenUserChanges;

  @override
  Future<void> initNotifications() async {
    // listen user changes and update info
    listenUserChanges ??= _auth.userChanges().listen((user) async {
      if (user != null) {
        await _firebaseMessaging.requestPermission();
        final fcmToken = await _firebaseMessaging.getToken();

        if (fcmToken != null) {
          final userRef =
              _firestore.collection(firestoreCollectionUsers).doc(user.uid);
          userRef.update({"fcmToken": fcmToken});
        }
      } else {
        await _firebaseMessaging.deleteToken();
      }
    });
  }
}
