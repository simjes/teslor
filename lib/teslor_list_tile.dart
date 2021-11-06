import 'package:cupertino_list_tile/cupertino_list_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tosler/components/skeleton_shimmer.dart';

class TeslorListTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData leading;
  final Function onTap;
  final bool isLoading;

  const TeslorListTile(
      {Key? key,
      required this.title,
      this.subtitle,
      required this.leading,
      required this.onTap,
      this.isLoading = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoListTile(
      border: const Border(bottom: BorderSide.none),
      leading: Icon(
        leading,
        color: Colors.grey,
      ),
      onTap: () {
        onTap();
      },
      subtitle: subtitle != null
          ? isLoading
              ? null
              : Text(subtitle!)
          : null,
      title: isLoading
          ? const TextShimmer(
              height: 14,
            )
          : Text(title),
      trailing: const Icon(
        CupertinoIcons.chevron_forward,
        color: Colors.grey,
      ),
    );
  }
}
