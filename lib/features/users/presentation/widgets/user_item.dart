import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_butler_task/features/add_location/presentation/pages/add_location_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../user_details/presentation/pages/user_details.dart';
import '../../../user_details/presentation/provider/user_details.dart';
import '../../data/models/user_model.dart';

class UserItem extends ConsumerWidget {
  final User user;
  final bool isFirst;
  final bool isLast;
  const UserItem({
    super.key,
    required this.user,
    this.isFirst = false,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        ref.read(userDetailsProvider).changeCurrentUser(user);
        GoRouter.of(context).pushNamed(UserDetails.route, extra: user);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 2, top: 2),
        decoration: BoxDecoration(
          color: Colors.grey[850],
          borderRadius: isFirst
              ? const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                )
              : isLast
                  ? const BorderRadius.only(
                      bottomRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                    )
                  : null,
        ),
        child: Row(
          children: [
            Hero(
              tag: user.id!,
              child: Material(
                type: MaterialType.transparency,
                child: Container(
                  margin: const EdgeInsets.all(5),
                  padding: const EdgeInsets.all(5),
                  width: 50,
                  height: 50,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50.0),
                    child: CachedNetworkImage(
                      imageUrl:
                          user.avatar ?? "https://via.placeholder.com/350x150",
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                      fit: BoxFit.fill,
                      width: 50,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: DefaultTextStyle(
                style: const TextStyle(color: Colors.white),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.name ?? "",
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      user.email ?? "",
                      style: const TextStyle(
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: GestureDetector(
                        onTap: () {
                          GoRouter.of(context).goNamed(AddLocationPage.route);
                        },
                        child: const Text(
                          'Add Location',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
