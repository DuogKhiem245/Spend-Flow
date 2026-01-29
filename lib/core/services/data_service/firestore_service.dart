import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:spend_flow/core/model/user_model.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  final String _collection = 'info_users';

  Future<void> saveUser(UserModel user) async {
    try {
      await _db
          .collection(_collection)
          .doc(user.uid)
          .set(user.toMap(), SetOptions(merge: true));
    } catch (e) {
      throw Exception('$e');
    }
  }

  Future<UserModel?> getUser(String uid) async {
    try {
      DocumentSnapshot doc = await _db.collection(_collection).doc(uid).get();

      if (doc.exists && doc.data() != null) {
        return UserModel.fromMap(doc.data() as Map<String, dynamic>);
      }
      return null;
    } catch (e) {
      throw Exception('$e');
    }
  }
}
