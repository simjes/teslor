import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tosler/utils/constants.dart';

class TextShimmer extends StatelessWidget {
  const TextShimmer({Key? key, this.width = 50, this.height = 15})
      : super(key: key);
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 2.0),
      child: SizedBox(
        height: height,
        width: width,
        child: const SkeletonShimmer(),
      ),
    );
  }
}

class SkeletonShimmer extends StatelessWidget {
  const SkeletonShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.grey,
        highlightColor: Colors.white,
        child: Container(
          color: Colors.white,
        ));
  }
}

// final TextStyle style = theme.textTheme.bodyText2!;
