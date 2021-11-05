import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tosler/components/skeleton_shimmer.dart';

class CarSummary extends StatelessWidget {
  CarSummary({this.name, this.range, this.parked, Key? key}) : super(key: key);

  String? name;
  int? range;
  bool? parked;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      name != null
          ? Text(
              name!,
              style: const TextStyle(fontSize: 20),
            )
          : TextShimmer(
              height: 20,
              width: 100,
            ),
      range != null
          ? Row(children: [
              Icon(CupertinoIcons.battery_75_percent),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text("${range! * 5}km"),
              ),
            ])
          : TextShimmer(
              width: 70,
            ),
      parked != null ? Text(parked! ? 'Parked' : 'Driving') : TextShimmer(),
    ]);
  }
}

// SizedBox(
//                 width: 200.0,
//                 height: 100.0,
//                 child: Shimmer.fromColors(
//                   baseColor: Colors.red,
//                   highlightColor: Colors.yellow,
//                   child: Container(
//                     color: Colors.white,
//                   ),
//                 ),
//               )
