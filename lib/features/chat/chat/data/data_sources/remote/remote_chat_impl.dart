import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:worlds_away/core/constants/constants.dart';
import 'package:worlds_away/features/chat/chat/data/data_sources/remote/remote_chat_repository.dart';
import 'package:worlds_away/features/chat/chat/data/models/message.dart';
import 'package:worlds_away/features/common/data/models/user.dart';

class RemoteChatImpl implements RemoteChatRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  RemoteChatImpl(this._firestore, this._auth);

  @override
  Future<Stream<List<MessageModel>>> getMessagesStream(
      String receiverUniqueUid) async {
    final user = _auth.currentUser;

    final chatRef = _firestore.collection(firestoreCollectionChats);
    final userRef = _firestore.collection(firestoreCollectionUsers);

    return chatRef
        .where("recipients", arrayContains: [user!.uid, receiverUniqueUid])
        .snapshots()
        .asyncMap((chatsSnapshot) async {
          if (chatsSnapshot.docs.isNotEmpty) {
            final messageLists =
                await Future.wait(chatsSnapshot.docs.map((doc) async {
              final recipients = doc.data()['recipients'] as List<dynamic>;
              final messages =
                  doc.data()["messages"] as List<Map<String, dynamic>>;

              final otherUserUid =
                  recipients.firstWhere((uid) => uid != user.uid);

              final userSnapshot = await userRef
                  .where("uniqueUid", isEqualTo: otherUserUid)
                  .get()
                  .then((value) => value.docs.first);

              final messagesModelList = messages
                  .map((message) => MessageModel.fromFirestore(
                      message,
                      UserModel.fromSnapshot(userSnapshot),
                      message["fromUniqueUid"] == user.uid ? true : false))
                  .toList();

              return messagesModelList;
            }));

            // Combine all the lists of messages
            final combinedMessagesList =
                messageLists.expand((list) => list).toList();
            return combinedMessagesList;
          } else {
            return <MessageModel>[];
          }
        });
  }
}
