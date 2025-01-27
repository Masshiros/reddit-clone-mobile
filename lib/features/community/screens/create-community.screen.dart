import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit_mobile/core/common/loading.dart';
import 'package:reddit_mobile/features/community/controller/community.controller.dart';
import 'package:reddit_mobile/theme/palette.dart';
import 'package:routemaster/routemaster.dart';

class CreateCommunityScreen extends ConsumerStatefulWidget {
  const CreateCommunityScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CreateCommunityScreenState();
}

class _CreateCommunityScreenState extends ConsumerState<CreateCommunityScreen> {
  final TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  void createCommunity() {
    ref
        .read(communityControllerProvider.notifier)
        .createCommunity(controller.text.trim(), context);
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(communityControllerProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create a community"),
        leading: IconButton(
            onPressed: () {
              Routemaster.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back)),
        centerTitle: true,
      ),
      body: isLoading
          ? const Loading()
          : Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Text('Community name'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    decoration: const InputDecoration(
                      hintText: "r/Community_name",
                      contentPadding: EdgeInsets.all(18),
                      border: InputBorder.none,
                      fillColor: Colors.black54,
                      filled: true,
                    ),
                    controller: controller,
                    maxLength: 21,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: createCommunity,
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      minimumSize: const Size(double.infinity, 50),
                      backgroundColor: Colors.blue[500],
                    ),
                    child: const Text(
                      "Create community",
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
