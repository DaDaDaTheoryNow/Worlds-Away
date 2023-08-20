import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:worlds_away/core/constants/constants.dart';
import 'package:worlds_away/features/chat/chat/data/data_sources/remote/remote_chat_repository.dart';
import 'package:worlds_away/features/chat/chat/data/models/message.dart';
import 'package:worlds_away/features/chat/chat/data/models/send_message.dart';
import 'package:worlds_away/features/common/data/models/user.dart';

class RemoteChatImpl implements RemoteChatRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  RemoteChatImpl(this._firestore, this._auth);

  @override
  Future<Stream<List<MessageModel>>> getMessagesStream(
      String receiverUniqueUid) async {
    final Stream<List<MessageModel>> newMessagesStream;

    final user = _auth.currentUser;

    final chatRef = _firestore.collection(firestoreCollectionChats);
    final userRef = _firestore.collection(firestoreCollectionUsers);

    newMessagesStream = chatRef
        .where("recipients", arrayContains: receiverUniqueUid)
        .snapshots()
        .asyncMap((chatsSnapshot) async {
      // return docs where current user and recipient
      final filteredDocs = chatsSnapshot.docs.where((doc) {
        final recipients = doc.data()["recipients"] as List<dynamic>;
        return recipients.contains(user!.uid);
      }).toList();

      // get messages from firestore
      final messageLists =
          await Future.wait(filteredDocs.map((filteredDoc) async {
        final messages = filteredDoc.data()["messages"] as List<dynamic>;

        final messagesModelList =
            await Future.wait(messages.map((message) async {
          final String fromUniqueUid = message["fromUniqueUid"];

          final userSnapshot = await userRef
              .where("uniqueUid", isEqualTo: fromUniqueUid)
              .get()
              .then((value) => value.docs.first);

          return MessageModel.fromFirestore(
              message,
              UserModel.fromSnapshot(userSnapshot),
              fromUniqueUid == user!.uid ? true : false);
        }).toList());

        return messagesModelList;
      }));

      // Combine all the lists of messages
      final combinedMessagesList = messageLists.expand((list) => list).toList();
      return combinedMessagesList;
    });

    return newMessagesStream;
  }

  @override
  Future<void> sendMessage(SendMessageModel messageModel) async {
    final user = _auth.currentUser;

    final chatRef = _firestore.collection(firestoreCollectionChats);

    // return docs where current user
    final chatSnapshot =
        await chatRef.where("recipients", arrayContains: user!.uid).get();

    // return docs where current user with recipient
    final filteredDocs = chatSnapshot.docs.where((doc) {
      final recipients = doc.data()["recipients"] as List<dynamic>;
      return recipients.contains(messageModel.receiverUniqueUid);
    }).toList();

    if (filteredDocs.isNotEmpty) {
      final chatDoc = filteredDocs.first;
      final messages = chatDoc.data()["messages"] as List<dynamic>;

      final newMessage = {
        "content": messageModel.content,
        "timestamp": messageModel.timestamp,
        "fromUniqueUid": user.uid,
      };

      messages.add(newMessage);

      await chatDoc.reference.update({"messages": messages});
    } else {
      final newMessage = {
        "content": messageModel.content,
        "timestamp": messageModel.timestamp,
        "fromUniqueUid": user.uid,
      };

      await chatRef.doc().set({
        "recipients": [user.uid, messageModel.receiverUniqueUid],
        "messages": [newMessage]
      });
    }
  }
}
