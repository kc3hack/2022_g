import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:team_g/domain/service/auth_api.dart';

class PostPage extends ConsumerWidget {
  const PostPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("投稿"),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text("ログアウト"),
          onPressed: () {
            AuthService().logout();
          },
        ),
      ),
    );
  }
}
