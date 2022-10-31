import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar(
      {super.key, this.avatarUrl, required this.radius, this.onPressed});

  final String? avatarUrl;
  final double radius;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onPressed,
        child: (avatarUrl == null)
            ? CircleAvatar(
                radius: radius,
                backgroundColor: Colors.grey[100],
                child: Icon(Icons.person))
            : CachedNetworkImage(
                imageUrl: avatarUrl.toString(),
                imageBuilder: (context, imageProvider) => CircleAvatar(
                  radius: radius,
                  backgroundColor: Colors.grey[100],
                  backgroundImage: imageProvider,
                ),
                placeholder: (context, url) => CircleAvatar(
                    radius: radius,
                    backgroundColor: Colors.grey[100],
                    child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => CircleAvatar(
                    radius: radius,
                    backgroundColor: Colors.grey[100],
                    child: Icon(Icons.error)),
              ));
  }
}
