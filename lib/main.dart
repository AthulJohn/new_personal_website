import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:i_am_rich/models/first_scroll.dart';

import 'functions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Athul John",
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: MainBody(),
    );
  }
}

class MainBody extends StatefulWidget {
  const MainBody({
    Key? key,
  }) : super(key: key);

  @override
  State<MainBody> createState() => _MainBodyState();
}

class _MainBodyState extends State<MainBody> {
  bool changed = false;
  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerSignal: (event) {
        if (event is PointerScrollEvent &&
            event.scrollDelta.direction > 0 &&
            !changed) {
          setState(() {
            changed = true;
          });
        } else if (event is PointerScrollEvent &&
            event.scrollDelta.direction < 0 &&
            changed) {
          setState(() {
            changed = false;
          });
        }
      },
      child: Stack(
        fit: StackFit.expand,
        alignment: Alignment.center,
        children: [
          Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.black, Colors.black, Colors.indigo],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter)),
          ),
          AnimatedPositioned(
              duration: const Duration(milliseconds: 500),
              top: -ht(context) * (changed ? 0.75 : 0.35),
              // left: -MediaQuery.of(context).size.width * 1.5,
              height: ht(context) * (changed ? 3.5 : 2.7),
              width: ht(context) * (changed ? 3.5 : 2.7),
              left: changed
                  ? -(ht(context) * 1.35 - wt(context) * 0.2)
                  : (wt(context) / 2 - ht(context) * 1.35),
              child: const ImageRotate('assets/stars.png', 140)),
          AnimatedPositioned(
              duration: const Duration(milliseconds: 500),
              // left: -MediaQuery.of(context).size.width * 1.5,
              top: 0,
              height: MediaQuery.of(context).size.height * 2,
              width: MediaQuery.of(context).size.height * 2,
              child: const ImageRotate('assets/companies.png', 90)),
          AnimatedPositioned(
              duration: const Duration(milliseconds: 500),
              top: MediaQuery.of(context).size.height * 0.375,
              // left: -MediaQuery.of(context).size.width * 1.5,
              height: MediaQuery.of(context).size.height * 1.25,
              width: MediaQuery.of(context).size.height * 1.25,
              child: const ImageRotate('assets/skills.png', 60)),
          AnimatedPositioned(
              duration: const Duration(milliseconds: 500),
              child: Image.asset(
                "assets/hills.png",
                fit: BoxFit.contain,
              ),
              bottom: 0,
              left: changed ? -MediaQuery.of(context).size.width * 1.8 : 0,
              width: changed
                  ? MediaQuery.of(context).size.width * 4
                  : MediaQuery.of(context).size.width),
          Positioned(
            top: 150,
            width: 500,
            height: 250,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 500),
              opacity: changed ? 0 : 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: const [
                  Text(
                    "I'm Athul John",
                    style: TextStyle(
                        fontSize: 70,
                        color: Colors.white,
                        fontStyle: FontStyle.italic),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    "a tech aspirant",
                    style: TextStyle(
                        fontSize: 40,
                        color: Colors.white,
                        fontStyle: FontStyle.italic),
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 500),
            child: Image.asset("assets/person.png"),
            width: changed
                ? MediaQuery.of(context).size.width * 0.4
                : MediaQuery.of(context).size.width * 0.1,
            bottom: 0,
            left: changed ? 0 : MediaQuery.of(context).size.width * 0.45,
          ),
        ],
      ),
    );
  }
}

class ImageRotate extends StatefulWidget {
  final String dest;
  final int rotTime;
  const ImageRotate(this.dest, this.rotTime, {Key? key}) : super(key: key);
  @override
  _ImageRotateState createState() => new _ImageRotateState();
}

class _ImageRotateState extends State<ImageRotate>
    with SingleTickerProviderStateMixin {
  AnimationController? animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: widget.rotTime),
    );

    animationController!.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController!,
      child: Opacity(
          opacity: 0.7, child: Image.network(widget.dest, fit: BoxFit.contain)),
      builder: (BuildContext context, Widget? _widget) {
        return Transform.rotate(
          angle: animationController!.value * 6.3,
          child: _widget,
        );
      },
    );
  }
}
