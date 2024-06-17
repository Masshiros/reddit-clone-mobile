import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit_mobile/core/utils.dart';
import 'package:reddit_mobile/features/auth/repository/auth.repository.dart';
import 'package:reddit_mobile/models/user.model.dart';

final authControllerProvider =
    Provider((ref) => AuthController(ref.read(authRepositoryProvider)));

class AuthController {
  final AuthRepository _authRepository;
  AuthController(AuthRepository authRepository)
      : _authRepository = authRepository;
  void signInWithGoogle(BuildContext context) async {
    final user = await _authRepository.signInWithGoogle();
    user.fold((l) => showSnackBar(context, l.message), (r) => print(r));
  }
}
