import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tosler/components/skeleton_shimmer.dart';

class CarSummary extends StatelessWidget {
  const CarSummary({this.name, this.range, this.parked, Key? key})
      : super(key: key);

  final String? name;
  final int? range;
  final bool? parked;

  @override
  Widget build(BuildContext context) {
    var textColor =
        CupertinoDynamicColor.resolve(CupertinoColors.label, context);

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      name != null
          ? Text(name!,
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(color: textColor))
          : const TextShimmer(
              height: 20,
              width: 100,
            ),
      range != null
          ? Row(children: [
              const Icon(
                CupertinoIcons.battery_75_percent,
                color: Colors.grey,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text("${range! * 5}km",
                    style: Theme.of(context).textTheme.subtitle1!.copyWith(
                          color: textColor,
                        )),
              ),
            ])
          : const TextShimmer(
              width: 70,
            ),
      parked != null
          ? Text(parked! ? 'Parked' : 'Driving',
              style: Theme.of(context)
                  .textTheme
                  .subtitle2!
                  .copyWith(color: textColor))
          : const TextShimmer(),
    ]);
  }
}
