import 'package:flutter/material.dart';

class FirstScroll with ChangeNotifier {
  ValueNotifier<bool> changed = ValueNotifier<bool>(false);
}

FirstScroll firstScroll = FirstScroll();
