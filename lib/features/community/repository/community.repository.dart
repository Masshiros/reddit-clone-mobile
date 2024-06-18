import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:reddit_mobile/core/constants/firebase.constants.dart';
import 'package:reddit_mobile/core/failure.dart';
import 'package:reddit_mobile/core/providers/firebase.provider.dart';
import 'package:reddit_mobile/core/type.defs.dart';
import 'package:reddit_mobile/models/commuity.model.dart';

final communityRepoProvider = Provider<CommunityRepository>((ref) {
  return CommunityRepository(ref.watch(firestoreProvider));
});

class CommunityRepository {
  final FirebaseFirestore _fireStore;
  CommunityRepository(FirebaseFirestore fireStore) : _fireStore = fireStore;
  CollectionReference get _communities =>
      _fireStore.collection(FirebaseConstants.communitiesCollection);
  VoidEither createCommunity(Community community) async {
    try {
      // check community name exist
      final existCommunity = await _communities.doc(community.name).get();
      if (existCommunity.exists) {
        throw "Community already exist";
      }
      return right(_communities.doc(community.name).set(community.toMap()));
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
