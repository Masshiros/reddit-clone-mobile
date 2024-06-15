import 'package:flutter/material.dart';
import 'package:reddit_mobile/core/common/sign-in.button.dart';
import 'package:reddit_mobile/core/constants/constants.dart';
import 'package:reddit_mobile/theme/palette.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
        body: Column(
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
