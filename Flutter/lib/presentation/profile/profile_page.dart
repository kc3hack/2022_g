import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:team_g/domain/service/auth_api.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("プロフィール"),
      ),
      body: Container(
        child: TextButton(
          child: Text("ログアウト"),
          onPressed: () {
            AuthService().logout();
          },
        ),
      ),
    );
  }
}
