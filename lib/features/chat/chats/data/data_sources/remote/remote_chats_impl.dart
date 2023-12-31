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
      final chatsWithUserDocs = values[0].docs;
      final usersDocs = values[1].docs;

      if (chatsWithUserDocs.isNotEmpty && usersDocs.isNotEmpty) {
        return chatsWithUserDocs.map((doc) {
          final recipients = doc.data()['recipients'] as List<dynamic>;
          final messages = doc.data()['messages'] as List<dynamic>;
          final lastMessage = messages.last;

          final otherUserUid = recipients.firstWhere((uid) => uid != user!.uid);

          final userSnapshot = usersDocs
              .where((element) => element.data()["uniqueUid"] == otherUserUid)
              .toList()
              .first;

          int messagesToNotViewed = 0;
          for (int i = messages.length - 1; i >= 0; i--) {
            final message = messages[i];

            if (!message["isViewed"] && message["fromUniqueUid"] != user!.uid) {
              messagesToNotViewed++;
            } else {
              break;
            }
          }

          return ChatModel.fromSnapshot(
              userSnapshot, lastMessage["content"], messagesToNotViewed);
        }).toList();
      } else {
        return <ChatModel>[];
      }
    });
  }

  @override
  Future<void> deleteChat(ChatModel chatModel) async {
    final user = _auth.currentUser;
    final chatsRef = _firestore.collection(firestoreCollectionChats);

    if (user != null) {
      final chatsWithUserSnapshot =
          await chatsRef.where("recipients", arrayContains: user.uid).get();

      if (chatsWithUserSnapshot.docs.isNotEmpty) {
        final deleteDoc = chatsWithUserSnapshot.docs
            .where((doc) {
              final recipients = doc.data()["recipients"] as List;
              return recipients.contains(chatModel.user.uniqueUid);
            })
            .toList()
            .first;

        if (deleteDoc.exists) {
          await deleteDoc.reference.delete();
        }
      }
    }
  }
}
