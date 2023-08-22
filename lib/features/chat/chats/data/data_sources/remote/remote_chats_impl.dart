import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:worlds_away/core/constants/constants.dart';
import 'package:worlds_away/features/chat/chats/data/data_sources/remote/remote_chats_repository.dart';
import 'package:worlds_away/features/chat/chats/data/models/chat.dart';

class RemoteChatsImpl implements RemoteChatsRepository {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  RemoteChatsImpl(this._auth, this._firestore);

  @override
  Future<Stream<List<ChatModel>>> getChatsStream() async {
    final user = _auth.currentUser;
    final userRef = _firestore.collection(firestoreCollectionUsers);
    final chatsRef = _firestore.collection(firestoreCollectionChats);

    return chatsRef
        .where("recipients", arrayContains: user?.uid)
        .snapshots()
        .asyncMap((chatsSnapshot) async {
      if (chatsSnapshot.docs.isNotEmpty) {
        return await Future.wait(chatsSnapshot.docs.map((doc) async {
          final recipients = doc.data()['recipients'] as List<dynamic>;
          final messages = doc.data()['messages'] as List<dynamic>;

          final otherUserUid = recipients.firstWhere((uid) => uid != user!.uid);

          final userSnapshot = await userRef
              .where("uniqueUid", isEqualTo: otherUserUid)
              .get()
              .then((value) => value.docs.first);

          final String lastMessage = messages.last["content"];

          return ChatModel.fromSnapshot(userSnapshot, lastMessage);
        }).toList());
      } else {
        return <ChatModel>[];
      }
    });
  }
}
