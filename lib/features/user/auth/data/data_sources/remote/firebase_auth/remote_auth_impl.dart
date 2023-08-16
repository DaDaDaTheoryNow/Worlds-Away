import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:worlds_away/core/constants/constants.dart';
import 'package:worlds_away/core/helpers/firestore_field_is_valid.dart';

import 'remote_auth_repository.dart';

class FirebaseAuthImpl implements RemoteAuthRepository {
  final GoogleSignIn _googleSignIn;
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  FirebaseAuthImpl(this._googleSignIn, this._auth, this._firestore);

  @override
  Future<User?> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

    if (googleUser == null) {
      return null;
    }

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final User? user = (await _auth.signInWithCredential(credential)).user;

    // init document in firestore
    final userRef =
        _firestore.collection(firestoreCollectionUsers).doc(user!.uid);

    final userSnapshot = await userRef.get();
    final Map<String, dynamic>? userData = userSnapshot.data();

    if (!isFirestoreFieldValid(userData, 'uniqueUid') ||
        !isFirestoreFieldValid(userData, 'email')) {
      try {
        await userRef.set({
          'id': "",
          'name': "",
          'email': user.email,
          'uniqueUid': user.uid,
          'about': "",
          'photoUrl': user.photoURL ?? "",
        });

        debugPrint('User document created successfully.');
      } catch (e) {
        debugPrint('Error creating user document: $e');
      }
    }

    return user;
  }

  @override
  Future<void> signOut() async {
    _googleSignIn.disconnect();
    _auth.signOut();
  }
}
