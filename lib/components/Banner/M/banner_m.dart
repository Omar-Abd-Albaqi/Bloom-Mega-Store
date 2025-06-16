import 'package:flutter/material.dart';

import '../../network_image_with_loader.dart';

class BannerM extends StatelessWidget {
  const BannerM(
      {super.key,
      required this.image,
      required this.press,
        required this.children,
      });

  final String image;
  final VoidCallback press;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: press,
      child: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                stops: [0.0, 0.1], // Adjusted stops to give more space for white
                colors: [
                  Color(0xFFEBECFD), // light bluish-purple
                  Colors.white,
                ],
                begin: Alignment(1.0, 1.0),
                end: Alignment(-0.73, -0.42),
              ),
            ),
            child: Image.asset("assets/hero-bg.png" , fit: BoxFit.fill,),
          ),
          NetworkImageWithLoader(image, radius: 0, fit: BoxFit.fill,),
          ...children,
        ],
      ),
    );
  }
}
