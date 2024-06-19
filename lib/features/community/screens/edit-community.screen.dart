import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit_mobile/core/common/error-text.dart';
import 'package:reddit_mobile/core/common/loading.dart';
import 'package:reddit_mobile/core/constants/constants.dart';
import 'package:reddit_mobile/core/utils.dart';
import 'package:reddit_mobile/features/community/controller/community.controller.dart';
import 'package:reddit_mobile/theme/palette.dart';

class EditCommunityScreen extends ConsumerStatefulWidget {
  final String name;
  const EditCommunityScreen(this.name, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EditCommunityScreenState();
}

class _EditCommunityScreenState extends ConsumerState<EditCommunityScreen> {
  File? bannerFile;
  File? profileFile;
  void selectBannerImage() async {
    final res = await pickImage();
    setState(() {
      if (res != null) {
        bannerFile = File(res.files.first.path!);
      }
    });
  }

  void selectProfileImage() async {
    final res = await pickImage();
    setState(() {
      if (res != null) {
        profileFile = File(res.files.first.path!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(getCommunityByNameProvider(widget.name)).when(
          data: (community) => Scaffold(
            appBar: AppBar(
              title: const Text("Edit Community"),
              centerTitle: false,
              actions: [
                TextButton(
                  onPressed: () {},
                  child: Text(
                    "Save",
                    style: TextStyle(color: Palette.blueColor),
                  ),
                )
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 200,
                    child: Stack(
                      children: [
                        GestureDetector(
                          onTap: selectBannerImage,
                          child: DottedBorder(
                            borderType: BorderType.RRect,
                            radius: const Radius.circular(10),
                            dashPattern: const [10, 4],
                            strokeCap: StrokeCap.round,
                            color: Palette
                                .darkModeAppTheme.textTheme.bodyMedium!.color!,
                            child: Container(
                              width: double.infinity,
                              height: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: bannerFile != null
                                    ? Image.file(bannerFile!)
                                    : community.banner.isEmpty ||
                                            community.banner ==
                                                Constants.bannerDefault
                                        ? const Icon(Icons.camera_alt_outlined)
                                        : Image.network(community.banner),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 20,
                          bottom: 20,
                          child: GestureDetector(
                            onTap: selectProfileImage,
                            child: profileFile != null
                                ? CircleAvatar(
                                    backgroundImage: FileImage(profileFile!),
                                    radius: 32,
                                  )
                                : CircleAvatar(
                                    backgroundImage:
                                        NetworkImage(community.avatar),
                                    radius: 32,
                                  ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          error: (error, stackTrace) => ErrorText(error: error.toString()),
          loading: () => const Loading(),
        );
  }
}
