import 'package:flutter/material.dart';


import '../../../constants.dart';
import 'banner_s.dart';

class BannerSStyle4 extends StatelessWidget {
  const BannerSStyle4({
    super.key,
    required this.image,
    this.title,
    required this.press,
    this.subtitle,
    this.bottomText,
    this.buttonText,
    this.aspectRatio = 2.3
  });
  final String? image;
  final String? title;
  final String? subtitle, bottomText;
final String? buttonText;
  final VoidCallback press;
  final double aspectRatio;

  @override
  Widget build(BuildContext context) {
    return BannerS(
      image: image!,
      press: press,
      aspectRatio: aspectRatio,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(defaultPadding , defaultPadding, defaultPadding, 0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // if (subtitle != null)
                    //   Container(
                    //     padding: const EdgeInsets.symmetric(
                    //         horizontal: defaultPadding / 2,
                    //         vertical: defaultPadding / 8),
                    //     color: Colors.white10,
                    //     child: Text(
                    //       subtitle!,
                    //       style: const TextStyle(
                    //         color: Colors.black54,
                    //         fontWeight: FontWeight.bold,
                    //         fontSize: 12,
                    //       ),
                    //     ),
                    //   ),
                    // const SizedBox(height: defaultPadding ),
                    // if(title != null)
                    // Text(
                    //   title!.toUpperCase(),
                    //   style: const TextStyle(
                    //     fontFamily: grandisExtendedFont,
                    //     fontSize: 28,
                    //     fontWeight: FontWeight.w900,
                    //     color: Colors.black,
                    //     height: 1,
                    //   ),
                    // ),
                    // const SizedBox(height: defaultPadding /2),
                    // if (bottomText != null)
                    //   Text(
                    //     bottomText!,
                    //     style: const TextStyle(
                    //       fontFamily: grandisExtendedFont,
                    //       color: Colors.black,
                    //       fontSize: 12,
                    //       fontWeight: FontWeight.bold,
                    //     ),
                    //   ),
                    // const SizedBox(height: defaultPadding /2,),

                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
