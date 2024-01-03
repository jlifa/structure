import 'dart:ui';

import 'package:flutter/material.dart';

const Color mainColor = Color(0XFF26B6B4);
const Color darkMainColor = Color(0XFF278785);
const Color secondColor = Color(0XFFFDC300);
const Color titleColor = Color(0XFF5B5959);
const Color greyColor = Color(0XFF5B5959);
const Color white = Colors.white;

const LinearGradient background = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0XFF26B6B4),
      Color(0XFF278785),
    ]);

final List<BoxShadow> boxShadow = [
  BoxShadow(
    color: Colors.grey.withOpacity(0.05),
    spreadRadius: 5,
    blurRadius: 7,
    offset: const Offset(0, 3), // changes position of shadow
  ),
];
