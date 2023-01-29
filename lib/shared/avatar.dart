import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar(
      {super.key,
      this.avatarUrl,
      this.selectedAvatar,
      required this.radius,
      this.onPressed});

  final File? selectedAvatar;
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
                child: selectedAvatar != null
                    ? CircleAvatar(
                        radius: radius,
                        backgroundImage:
                            Image.file(selectedAvatar!, fit: BoxFit.cover)
                                .image,
                      )
                    : Icon(Icons.person, size: radius))
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
                    child: const CircularProgressIndicator()),
                errorWidget: (context, url, error) => CircleAvatar(
                      radius: radius,
                      backgroundColor: Colors.grey[100],
                      child: Icon(Icons.error, size: (radius / 2)),
                    )));
  }
}
