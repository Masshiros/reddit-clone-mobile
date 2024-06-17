import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:reddit_mobile/core/constants/constants.dart';
import 'package:reddit_mobile/core/constants/firebase.constants.dart';
import 'package:reddit_mobile/core/providers/firebase.provider.dart';
import 'package:reddit_mobile/models/user.model.dart';

final authRepositoryProvider = Provider(
  (ref) => AuthRepository(
    fireStore: ref.read(firestoreProvider),
    googleSignIn: ref.read(googleProvider),
    auth: ref.read(authProvider),
  ),
);

class AuthRepository {
  final FirebaseFirestore _fireStore;
  final GoogleSignIn _googleSignIn;
  final FirebaseAuth _auth;
  AuthRepository(
      {required FirebaseFirestore fireStore,
      required GoogleSignIn googleSignIn,
      required FirebaseAuth auth})
      : _fireStore = fireStore,
        _googleSignIn = googleSignIn,
        _auth = auth;
  CollectionReference get _users =>
      _fireStore.collection(FirebaseConstants.usersCollection);
  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final googleAuth = await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth?.idToken,
        accessToken: googleAuth?.accessToken,
      );
      UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      UserModel userModel;
      if (userCredential.additionalUserInfo!.isNewUser) {
        userModel = UserModel(
          name: userCredential.user!.displayName ?? 'Anonymous',
          profilePic: userCredential.user!.photoURL ?? Constants.avatarDefault,
          banner: Constants.bannerDefault,
          uid: userCredential.user!.uid,
          isAuthenticated: true,
          karma: 0,
          awards: [],
        );
        await _users.doc(userModel.uid).set(userModel);
      }
    } catch (e) {
      print(e);
    }
  }
}
