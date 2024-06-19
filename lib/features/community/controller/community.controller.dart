import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:reddit_mobile/core/constants/constants.dart';
import 'package:reddit_mobile/core/failure.dart';
import 'package:reddit_mobile/core/providers/storage-firebase.provider.dart';
import 'package:reddit_mobile/core/utils.dart';
import 'package:reddit_mobile/features/auth/controller/auth.controller.dart';
import 'package:reddit_mobile/features/community/repository/community.repository.dart';
import 'package:reddit_mobile/models/commuity.model.dart';
import 'package:routemaster/routemaster.dart';

final communityControllerProvider =
    StateNotifierProvider<CommunityController, bool>((ref) {
  return CommunityController(
    ref.watch(communityRepoProvider),
    ref,
    ref.watch(
      storageRepositoryProvider,
    ),
  );
});
final getUserCommunitiesProvider = StreamProvider((ref) =>
    ref.read(communityControllerProvider.notifier).getUserCommunities());

final getCommunityByNameProvider = StreamProvider.family(
  (ref, String name) =>
      ref.read(communityControllerProvider.notifier).getCommunityByName(name),
);
final searchCommunityProvider = StreamProvider.family((ref, String query) {
  return ref.watch(communityControllerProvider.notifier).searchCommunity(query);
});

class CommunityController extends StateNotifier<bool> {
  final CommunityRepository _repository;
  final Ref _ref;
  final StorageRepository _storageRepository;
  CommunityController(CommunityRepository repository, Ref ref,
      StorageRepository storageRepository)
      : _repository = repository,
        _ref = ref,
        _storageRepository = storageRepository,
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

  void editCommunity({
    required File? profileFile,
    required File? bannerFile,
    required Community community,
    required BuildContext context,
  }) async {
    state = true;
    if (bannerFile != null) {
      final res = await _storageRepository.storeFile(
          path: "communities/banner", id: community.name, file: bannerFile);
      res.fold(
        (l) => showSnackBar(context, l.message),
        (res) => community = community.copyWith(banner: res),
      );
    }
    if (profileFile != null) {
      final res = await _storageRepository.storeFile(
          path: "communities/profile", id: community.name, file: profileFile);
      res.fold(
        (l) => showSnackBar(context, l.message),
        (res) => community = community.copyWith(avatar: res),
      );
    }
    final res = await _repository.editCommunity(community);
    state = false;
    res.fold(
      (l) => showSnackBar(context, l.message),
      (res) {
        showSnackBar(context, "Edit success");
        Routemaster.of(context).pop();
      },
    );
  }

  void joinCommunity(Community community, BuildContext context) async {
    final user = _ref.read(userProvider)!;

    Either<Failure, void> res;
    if (community.members.contains(user.uid)) {
      res = await _repository.leaveCommunity(community.name, user.uid);
    } else {
      res = await _repository.joinCommunity(community.name, user.uid);
    }

    res.fold((l) => showSnackBar(context, l.message), (r) {
      if (community.members.contains(user.uid)) {
        showSnackBar(context, 'Community left successfully!');
      } else {
        showSnackBar(context, 'Community joined successfully!');
      }
    });
  }

  void addMods(
      String communityName, List<String> uids, BuildContext context) async {
    final res = await _repository.addMods(communityName, uids);
    res.fold(
      (l) => showSnackBar(context, l.message),
      (r) => Routemaster.of(context).pop(),
    );
  }

  Stream<List<Community>> searchCommunity(String query) {
    return _repository.searchCommunity(query);
  }
}
