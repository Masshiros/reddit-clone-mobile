import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit_mobile/core/common/loading.dart';
import 'package:reddit_mobile/core/common/sign-in.button.dart';
import 'package:reddit_mobile/core/constants/constants.dart';
import 'package:reddit_mobile/features/auth/controller/auth.controller.dart';
import 'package:reddit_mobile/theme/palette.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(authControllerProvider);
    return Scaffold(
        appBar: AppBar(
          title: Image.asset(
            Constants.logoPath,
            height: 40,
          ),
          centerTitle: true,
          actions: [
            TextButton(
              onPressed: () {},
              child: Text(
                "Skip",
                style: TextStyle(
                  color: Palette.blueColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
        body: isLoading
            ? const Loading()
            : Column(
                children: [
                  const Text(
                    "Dive into anything",
                    style: TextStyle(
                      letterSpacing: 0.5,
                      fontSize: 24,
                      color: Palette.whiteColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      Constants.loginEmotePath,
                      height: 400,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  // login button
                  const SignInButton(),
                ],
              ));
  }
}
