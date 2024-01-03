import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';


class ImageUtils {
  ImageUtils._();

  static String imageResStr(var name) => 'assets/images/$name.webp';

  static String imageResStrPng(var name) => 'assets/images/$name.png';

  // load assets
  static Widget assetsImage(String res,
      {double? width, double? height, BoxFit? fit, Color? color}) {
    return Image.asset(
      imageResStr(res),
      width: width,
      height: height,
      fit: fit,
      color: color,
    );
  }

  static Widget assetsImagePng(String res,
      {double? width, double? height, BoxFit? fit, Color? color}) {
    return Image.asset(
      imageResStrPng(res),
      width: width,
      height: height,
      fit: fit,
      color: color,
    );
  }

  static Widget assetsImageFile(String res,
      {double? width, double? height, BoxFit? fit, Color? color}) {
    return Image.file(
      File(res),
      width: width,
      height: height,
      fit: fit,
      gaplessPlayback: true,
      excludeFromSemantics: true,
      color: color,
    );
  }

  static Widget error({
    double? width,
    double? height,
  }) =>
      assetsImage(
        'ic_load_error',
        height: height,
        width: width,
      );

  static Widget defaultIcon({
    double? width,
    double? height,
  }) =>
      Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
        ),
        child: ImageUtils.assetsImage('login_avater',
            width: width, height: height, fit: BoxFit.fill),
      );

  static Widget failedImage() {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(FeatherIcons.alertCircle, color: Colors.white),
        SizedBox(
          height: 5,
        ),
        Text(
          'Could not load image',
          style: TextStyle(color: Colors.white),
        )
      ],
    );
  }

  static ImageProvider noPfpProvider() {
    return const AssetImage('assets/images/no_pfp.png');
  }

  static ImageProvider customNetworkProvider(String url) {
    return url.isNotEmpty ? CachedNetworkImageProvider(url) : noPfpProvider();
  }
}
