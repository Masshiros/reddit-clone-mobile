import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit_mobile/core/common/error-text.dart';
import 'package:reddit_mobile/core/common/loading.dart';
import 'package:reddit_mobile/features/auth/controller/auth.controller.dart';
import 'package:reddit_mobile/features/community/controller/community.controller.dart';

class AddModsScreen extends ConsumerStatefulWidget {
  final String name;
  const AddModsScreen(this.name, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddModsScreenState();
}

class _AddModsScreenState extends ConsumerState<AddModsScreen> {
  Set<String> uids = {};
  // count how many times widget build
  int count = 0;
  void addUid(String uid) {
    setState(() {
      uids.add(uid);
    });
  }

  void removeUid(String uid) {
    setState(() {
      uids.remove(uid);
    });
  }

  void addMods() {
    ref
        .read(communityControllerProvider.notifier)
        .addMods(widget.name, uids.toList(), context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {
                addMods();
              },
              icon: const Icon(Icons.done),
            ),
          ],
        ),
        body: ref.watch(getCommunityByNameProvider(widget.name)).when(
              data: (community) => ListView.builder(
                itemCount: community.members.length,
                itemBuilder: (context, index) {
                  final memberUid = community.members[index];
                  return ref.watch(getUserDataProvider(memberUid)).when(
                        data: (member) {
                          // check are there any mods in this community
                          // if widget just build at first time --> add already mods to list mods' uids --> be able to unselect already mods
                          if (community.mods.contains(member.uid) &&
                              count == 0) {
                            uids.add(member.uid);
                          }
                          print(community.mods);
                          count++;

                          return CheckboxListTile(
                            value: uids.contains(member.uid),
                            onChanged: (val) {
                              if (val == true) {
                                addUid(memberUid);
                              } else {
                                removeUid(memberUid);
                              }
                            },
                            title: Text(member.name),
                          );
                        },
                        error: (error, stackTrace) => ErrorText(
                          error: error.toString(),
                        ),
                        loading: () => const Loading(),
                      );
                },
              ),
              error: (error, stackTrace) => ErrorText(
                error: error.toString(),
              ),
              loading: () => const Loading(),
            ));
  }
}
