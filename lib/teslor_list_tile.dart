import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TeslorListTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData leading;
  final Function onTap;
  // todo on click -> navigate

  const TeslorListTile(
      {Key? key,
      required this.title,
      this.subtitle,
      required this.leading,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListTile(
        title: Text(title),
        subtitle: subtitle != null ? Text("more test") : null,
        leading: Icon(leading),
        trailing: Icon(CupertinoIcons.chevron_forward),
        onTap: onTap(),
      ),
    );
  }
}
