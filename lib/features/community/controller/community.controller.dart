import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit_mobile/core/constants/constants.dart';
import 'package:reddit_mobile/core/utils.dart';
import 'package:reddit_mobile/features/auth/controller/auth.controller.dart';
import 'package:reddit_mobile/features/community/repository/community.repository.dart';
import 'package:reddit_mobile/models/commuity.model.dart';
import 'package:routemaster/routemaster.dart';

final communityControllerProvider =
    StateNotifierProvider<CommunityController, bool>((ref) {
  return CommunityController(ref.watch(communityRepoProvider), ref);
});
final getUserCommunitiesProvider = StreamProvider((ref) =>
    ref.read(communityControllerProvider.notifier).getUserCommunities());

final getCommunityByNameProvider = StreamProvider.family(
  (ref, String name) =>
      ref.read(communityControllerProvider.notifier).getCommunityByName(name),
);

class CommunityController extends StateNotifier<bool> {
  final CommunityRepository _repository;
  final Ref _ref;
  CommunityController(CommunityRepository repository, Ref ref)
      : _repository = repository,
        _ref = ref,
        super(false);
  void createCommunity(String name, BuildContext context) async {
    state = true;
    final uid = _ref.read(userProvider)?.uid ?? '';
    Community community = Community(
      id: name,
      name: name,
      banner: Constants.bannerDefault,
      avatar: Constants.avatarDefault,
      members: [uid],
      mods: [uid],
    );
    final result = await _repository.createCommunity(community);
    state = false;
    result.fold((err) => showSnackBar(context, err.message), (community) {
      showSnackBar(context, "Create community success");
      Routemaster.of(context).pop();
    });
  }

  Stream<List<Community>> getUserCommunities() {
    final uid = _ref.read(userProvider)!.uid;
    return _repository.getUserCommunities(uid);
  }

  Stream<Community> getCommunityByName(String name) {
    return _repository.getCommunityByName(name);
  }
}
