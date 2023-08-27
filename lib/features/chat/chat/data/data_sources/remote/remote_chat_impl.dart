import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';
import 'package:worlds_away/core/constants/constants.dart';
import 'package:worlds_away/features/chat/chat/data/data_sources/remote/remote_chat_repository.dart';
import 'package:worlds_away/features/chat/chat/data/models/chat_info.dart';
import 'package:worlds_away/features/chat/chat/data/models/message.dart';
import 'package:worlds_away/features/chat/chat/data/models/send_message.dart';
import 'package:worlds_away/features/common/data/models/user.dart';

class RemoteChatImpl implements RemoteChatRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  RemoteChatImpl(this._firestore, this._auth);

  @override
  Future<Stream<ChatInfoModel>> getChatInfoStream(
      String receiverUniqueUid) async {
    final user = _auth.currentUser;

    final chatRef = _firestore.collection(firestoreCollectionChats);
    final userRef = _firestore.collection(firestoreCollectionUsers);

    final chatWithUserSnapshot = chatRef
        .where("recipients", arrayContains: receiverUniqueUid)
        .snapshots();
    final usersSnapshot = userRef.snapshots();

    return CombineLatestStream([chatWithUserSnapshot, usersSnapshot], (values) {
      // return docs where current user and recipient
      final chatWithReceiverUserDocs = values[0].docs.where((doc) {
        final recipients = doc.data()["recipients"] as List<dynamic>;
        return recipients.contains(user!.uid);
      }).toList();
      final usersDocs = values[1].docs;

      if (chatWithReceiverUserDocs.isNotEmpty && usersDocs.isNotEmpty) {
        final messages =
            chatWithReceiverUserDocs.first.data()["messages"] as List<dynamic>;

        final listMessageModel = messages.map((message) {
          final String fromUniqueUid = message["fromUniqueUid"];

          final userSnapshot = usersDocs
              .where((element) => element.data()["uniqueUid"] == fromUniqueUid)
              .toList()
              .first;

          return MessageModel.fromFirestore(
              message,
              UserModel.fromSnapshot(userSnapshot),
              fromUniqueUid == user!.uid ? true : false,
              receiverUniqueUid);
        }).toList();

        final receiverUser = usersDocs
            .where(
                (element) => element.data()["uniqueUid"] == receiverUniqueUid)
            .toList()
            .first;

        return ChatInfoModel(
            messages: listMessageModel,
            receiverUser: UserModel.fromSnapshot(receiverUser));
      } else {
        return const ChatInfoModel(
            messages: <MessageModel>[], receiverUser: null);
      }
    });
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

    final newMessage = {
      "content": messageModel.content,
      "timestamp": messageModel.timestamp,
      "fromUniqueUid": user.uid,
      "isViewed": false,
    };

    if (filteredDocs.isNotEmpty) {
      final chatDoc = filteredDocs.first;

      await chatDoc.reference.update({
        "messages": FieldValue.arrayUnion([newMessage]),
      });
    } else {
      await chatRef.doc().set({
        "recipients": [user.uid, messageModel.receiverUniqueUid],
        "messages": [newMessage]
      });
    }
  }

  @override
  Future<void> setMessagesIsViewed(MessageModel messageModel) async {
    final user = _auth.currentUser;

    final chatRef = _firestore.collection(firestoreCollectionChats);

    if (messageModel.fromUser!.uniqueUid != user!.uid) {
      // return docs where current user

      final chatSnapshot = await chatRef
          .where("recipients", arrayContains: user.uid)
          .get(const GetOptions(source: Source.server));

      // return docs where current user with recipient
      final filteredDocs = chatSnapshot.docs.where((doc) {
        final recipients = doc.data()["recipients"] as List<dynamic>;
        return recipients.contains(messageModel.receiverUniqueUid);
      }).toList();

      if (filteredDocs.isNotEmpty) {
        final chatDoc = filteredDocs.first;
        final data = chatDoc.data();

        final messages = data["messages"] as List<dynamic>;

        for (var message in messages) {
          if (message["isViewed"] == false) {
            message["isViewed"] = true;
          }
        }

        await chatDoc.reference.update({
          "messages": messages,
        });
      }
    }
  }
}
