import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit_mobile/features/auth/repository/auth.repository.dart';

final authControllerProvider =
    Provider((ref) => ref.read(authRepositoryProvider));

class AuthController {
  final AuthRepository _authRepository;
  AuthController(AuthRepository authRepository)
      : _authRepository = authRepository;
  void signInWithGoogle() async {
    await _authRepository.signInWithGoogle();
  }
}
