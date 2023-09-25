import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: SkeletonAvatar(
        style: SkeletonAvatarStyle(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 5,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
