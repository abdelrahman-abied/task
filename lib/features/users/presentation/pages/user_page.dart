import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/utils/log.dart';
import '../../../../features/login/presentation/pages/login_page.dart';
import '../../../../features/users/presentation/widgets/user_item.dart';

import '../../../../core/constants/key_helper.dart';
import '../provider/user_provider.dart';

class UserPage extends ConsumerStatefulWidget {
  static const String route = "user";
  const UserPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UserPageState();
}

class _UserPageState extends ConsumerState<UserPage> {
  final _scrollController = ScrollController();
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      ref.read(userProvider).getUsers();
    });
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        Future.delayed(Duration.zero, () {
          ref.read(userProvider).getUsers();
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black38,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              Consumer(
                builder: (context, ref, child) {
                  final users = ref.watch(userProvider).user;
                  return users.isNotEmpty
                      ? Expanded(
                          child: ListView.builder(
                            controller: _scrollController,
                            itemCount: users.length,
                            itemBuilder: (context, index) {
                              final user = users[index];
                              return UserItem(
                                key: ValueKey(user.id),
                                user: user,
                                isFirst: index == 0,
                                isLast: index == users.length - 1,
                              );
                            },
                          ),
                        )
                      : const SizedBox.shrink();
                },
              ),
              const SizedBox(height: 5),
              Consumer(
                builder: (context, ref, child) {
                  return ref.watch(userProvider).isLoading
                      ? const Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : const SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
