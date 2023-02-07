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
        child: Stack(children: [
          (avatarUrl == null || selectedAvatar != null)
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
                      )),
          if (onPressed != null)
            Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  margin: const EdgeInsets.only(right: 8, bottom: 8),
                  padding: EdgeInsets.all(radius / 12),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          width: 2.0),
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(50)),
                  child: Icon(Icons.edit,
                      size: radius / 4,
                      color: Theme.of(context).colorScheme.onPrimary),
                ))
        ]));
  }
}
