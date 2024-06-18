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

  Stream<List<Community>> getUserCommunities(String uid) {
    return _communities
        .where("members", arrayContains: uid)
        .snapshots()
        .map((snapshot) {
      final List<Community> communities = [];
      for (final doc in snapshot.docs) {
        communities.add(Community.fromMap(doc.data() as Map<String, dynamic>));
      }
      return communities;
    });
  }
  Stream<Community> getCommunityByName(String name){
    return _communities.doc(name).snapshots().map((snapshot){
        return Community.fromMap(snapshot.data() as Map<String,dynamic>);
    });
  }
}
