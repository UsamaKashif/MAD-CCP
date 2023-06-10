import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mad_ccp/models/user_model.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserModel> getUserDetails() async {
    User user = _auth.currentUser!;
    DocumentSnapshot doc =
        await _firestore.collection("users").doc(user.uid).get();
    return UserModel.fromSnap(doc);
  }

  Future<String> signUpUser({
    required String email,
    required String password,
    required String fullName,
  }) async {
    try {
      if (email.isEmpty || password.isEmpty) {
        return "Please fill all the fields";
      }
      UserCredential cred = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      UserModel user = UserModel(
        email: email,
        fullName: fullName,
      );

      await _firestore.collection("users").doc(cred.user!.uid).set(
            user.toJson(),
          );

      return "Success";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      } else if (e.code == 'invalid-email') {
        return 'The email address is not valid.';
      } else {
        return e.message!;
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      if (email.isEmpty || password.isEmpty) {
        return "Please fill all the fields";
      }
      await _auth.signInWithEmailAndPassword(email: email, password: password);

      return "Success";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        return 'Wrong password provided for that user.';
      } else if (e.code == 'invalid-email') {
        return 'The email address is not valid.';
      } else {
        return e.message!;
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> signOut() async {
    try {
      await _auth.signOut();
      return "Signed out successfully";
    } catch (e) {
      return Future.value(e.toString());
    }
  }
}
