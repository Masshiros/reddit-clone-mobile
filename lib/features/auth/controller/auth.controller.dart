import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit_mobile/core/utils.dart';
import 'package:reddit_mobile/features/auth/repository/auth.repository.dart';
import 'package:reddit_mobile/models/user.model.dart';

final userProvider = StateProvider<UserModel?>((ref) => null);

final authControllerProvider = StateNotifierProvider<AuthController, bool>(
  (ref) => AuthController(
    ref.watch(authRepositoryProvider),
    ref,
  ),
);
final authStateChangeProvider = StreamProvider(
  (ref) => ref.watch(authControllerProvider.notifier).getAuthStateChange(),
);
final getUserDataProvider = StreamProvider.family(
  (ref, String uid) =>
      ref.watch(authControllerProvider.notifier).getUserData(uid),
);

class AuthController extends StateNotifier<bool> {
  final AuthRepository _authRepository;
  final Ref _ref;
  AuthController(AuthRepository authRepository, Ref ref)
      : _authRepository = authRepository,
        _ref = ref,
        super(false);
  void signInWithGoogle(BuildContext context) async {
    state = true;
    final user = await _authRepository.signInWithGoogle();
    state = false;
    user.fold(
        (l) => showSnackBar(context, l.message),
        (userModel) =>
            _ref.read(userProvider.notifier).update((state) => userModel));
  }

  Stream<User?> getAuthStateChange() {
    return _authRepository.authStateChange;
  }

  Stream<UserModel> getUserData(String uid) {
    return _authRepository.getUserData(uid);
  }
}
