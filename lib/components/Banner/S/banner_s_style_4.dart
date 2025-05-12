import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';

import '../../../constants.dart';
import 'banner_s.dart';

class BannerSStyle4 extends StatelessWidget {
  const BannerSStyle4({
    super.key,
    required this.image,
    required this.title,
    required this.press,
    this.subtitle,
    this.bottomText,
    this.buttonText,
  });
  final String? image;
  final String title;
  final String? subtitle, bottomText;
final String? buttonText;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return BannerS(
      image: image!,
      press: press,
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
                    if (subtitle != null)
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: defaultPadding / 2,
                            vertical: defaultPadding / 8),
                        color: Colors.white10,
                        child: Text(
                          subtitle!,
                          style: const TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    const SizedBox(height: defaultPadding ),
                    Text(
                      title.toUpperCase(),
                      style: const TextStyle(
                        fontFamily: grandisExtendedFont,
                        fontSize: 28,
                        fontWeight: FontWeight.w900,
                        color: Colors.black,
                        height: 1,
                      ),
                    ),
                    const SizedBox(height: defaultPadding /2),
                    if (bottomText != null)
                      Text(
                        bottomText!,
                        style: const TextStyle(
                          fontFamily: grandisExtendedFont,
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    const SizedBox(height: defaultPadding /2,),
                    // if(buttonText != null)
                    GestureDetector(
                      child: Container(
                        width: MediaQuery.of(context).size.width - 160,
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          // color: const Color(0XFFf1b245)
                        ),
                        alignment: const Alignment(0, 0),
                        child: const Text("iPhone 14 has the same superspeedy chip that’s in iPhone 13 Pro, A15 Bionic, with a 5‑core GPU, powers all the latest features.",maxLines: 3,overflow: TextOverflow.ellipsis, style: TextStyle(color: Colors.black45 , fontSize: 12),),
                      ),
                    ),
                  ],
                ),
              ),
              // const SizedBox(width: defaultPadding),
              // SizedBox(
              //   height: 48,
              //   width: 48,
              //   child: ElevatedButton(
              //     onPressed: press,
              //     style: ElevatedButton.styleFrom(
              //       shape: const CircleBorder(),
              //       backgroundColor: Colors.white,
              //     ),
              //     child: SvgPicture.asset(
              //       "assets/icons/Arrow - Right.svg",
              //       colorFilter:
              //           const ColorFilter.mode(Colors.black, BlendMode.srcIn),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ],
    );
  }
}
