import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tour_lister_app/models/messages_model.dart';

class GetCurrentUserSms {
  Stream<List<MessagesModel>> getAllMessages(receiverId) {
    var list = FirebaseFirestore.instance
        .collection('messages')
        .snapshots()
        .map((snapShot) {
      return snapShot.docs
          .map(
            (document) => MessagesModel.fromJson(
              document.data(),
            ),
          )
          .toList();
    });

    return list;
  }
}
