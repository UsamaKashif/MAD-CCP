import 'package:cloud_firestore/cloud_firestore.dart';

class ProgressMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // get Progress
  Future<Map<String, dynamic>> getProgress(String userId) async {
    try {
      DocumentSnapshot documentSnapshot =
          await _firestore.collection('progress').doc(userId).get();
      if (documentSnapshot.exists) {
        Map<String, dynamic> progress =
            documentSnapshot.data() as Map<String, dynamic>;
        return progress;
      }
      return {};
    } catch (e) {
      // ignore: avoid_print
      print(e);
      return {};
    }
  }

  // update Progress
  Future<void> updateProgress(String userId, String gameId, int level) async {
    try {
      await _firestore
          .collection('progress')
          .doc(userId)
          .set({gameId: level}, SetOptions(merge: true));
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }
}
