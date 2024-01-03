import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class IconUtils {
  IconUtils._();
  static String imagePath(String path) => "assets/icons/$path.svg";

  static Widget getSvgImage(String res,
      {double? width, double? height, BoxFit? fit, Color? color}) {
    return SvgPicture.asset(
      imagePath(res),
      width: width,
      height: height,
      color: color,
    );
  }

  static Widget getSvgImageInternet(String res,
      {double? width, double? height, BoxFit? fit, Color? color}) {
    return SvgPicture.network(
      res,
      width: width,
      height: height,
      color: color,
    );
  }

  static Widget getSvgImageFull(String res,
      {double? width, double? height, BoxFit? fit, Color? color}) {
    return SvgPicture.asset(
      res,
      width: width,
      height: height,
      color: color,
    );
  }


}
