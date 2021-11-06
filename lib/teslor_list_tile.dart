import 'package:cupertino_list_tile/cupertino_list_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TeslorListTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData leading;
  final Function onTap;

  const TeslorListTile({
    Key? key,
    required this.title,
    this.subtitle,
    required this.leading,
    required this.onTap,
  }) : super(key: key);

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
      subtitle: subtitle != null ? Text(subtitle!) : null,
      title: Text(title),
      trailing: const Icon(
        CupertinoIcons.chevron_forward,
        color: Colors.grey,
      ),
    );
  }
}
