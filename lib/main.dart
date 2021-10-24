import 'package:flutter/cupertino.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'Flutter Demo',
      home: const MyStatefulWidget(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Yondu",
                        style: TextStyle(fontSize: 20),
                      ),
                      Row(children: [
                        Icon(CupertinoIcons.battery_75_percent),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text("282km"),
                        ),
                      ]),
                      Text("Parked"),
                    ],
                  ),
                  Text("annet")
                ],
              ),
            ),
            Image.asset("images/car.png"),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CupertinoButton(
                    onPressed: () {},
                    child: Icon(CupertinoIcons.lock),
                  ),
                  CupertinoButton(
                    onPressed: () {},
                    child: Icon(CupertinoIcons.waveform_circle),
                  ),
                  CupertinoButton(
                    onPressed: () {},
                    child: Icon(CupertinoIcons.battery_charging),
                  ),
                  CupertinoButton(
                    onPressed: () {},
                    child: Icon(CupertinoIcons.car),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
