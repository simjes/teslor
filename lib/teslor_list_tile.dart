import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tosler/components/skeleton_shimmer.dart';

class TeslorListTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData leading;
  final Function onTap;
  final bool isLoading;
  // todo on click -> navigate

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
    return Material(
      child: ListTile(
        title: isLoading
            ? TextShimmer(
                height: 16,
              )
            : Text(title),
        subtitle: subtitle != null
            ? isLoading
                ? null
                : Text(subtitle!)
            : null,
        leading: Icon(leading),
        trailing: Icon(CupertinoIcons.chevron_forward),
        onTap: onTap(),
      ),
    );
  }
}
