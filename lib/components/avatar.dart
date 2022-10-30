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
        child: CircleAvatar(
            radius: radius,
            backgroundColor: Colors.grey[100],
            backgroundImage: avatarUrl != null && avatarUrl != ''
                ? NetworkImage(avatarUrl.toString())
                : null,
            child: avatarUrl == null && avatarUrl != ''
                ? Icon(Icons.photo_camera_outlined, size: radius.toDouble())
                : null));
  }
}
