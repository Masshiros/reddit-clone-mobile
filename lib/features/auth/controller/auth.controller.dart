import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit_mobile/core/utils.dart';
import 'package:reddit_mobile/features/auth/repository/auth.repository.dart';
import 'package:reddit_mobile/models/user.model.dart';

final userProvider = StateProvider<UserModel?>((ref) => null);

final authControllerProvider =
    Provider((ref) => AuthController(ref.read(authRepositoryProvider),ref));

class AuthController  {
  final AuthRepository _authRepository;
  final Ref _ref;
  AuthController(AuthRepository authRepository, Ref ref)
      : _authRepository = authRepository, _ref = ref;
  void signInWithGoogle(BuildContext context) async {
    final user = await _authRepository.signInWithGoogle();
    user.fold((l) => showSnackBar(context, l.message), (userModel) => _ref.read(userProvider.notifier).update((state) => userModel));
  }
}
