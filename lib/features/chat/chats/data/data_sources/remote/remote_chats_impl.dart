import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/streams.dart';
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

    final chatsWithUserSnapshot =
        chatsRef.where("recipients", arrayContains: user?.uid).snapshots();

    final usersSnapshot = userRef.snapshots();

    return CombineLatestStream([chatsWithUserSnapshot, usersSnapshot],
        (values) {
      final chatsWithUserDocs = values[0];
      final usersDocs = values[1];

      if (chatsWithUserDocs.docs.isNotEmpty && usersDocs.docs.isNotEmpty) {
        return chatsWithUserDocs.docs.map((doc) {
          final recipients = doc.data()['recipients'] as List<dynamic>;
          final messages = doc.data()['messages'] as List<dynamic>;
          final String lastMessage = messages.last["content"];

          final otherUserUid = recipients.firstWhere((uid) => uid != user!.uid);

          final userSnapshot = usersDocs.docs
              .where((element) => element.data()["uniqueUid"] == otherUserUid)
              .toList()
              .first;

          return ChatModel.fromSnapshot(userSnapshot, lastMessage);
        }).toList();
      } else {
        return <ChatModel>[];
      }
    });
  }
}
