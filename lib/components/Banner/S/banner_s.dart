import 'package:flutter/material.dart';

import '../../network_image_with_loader.dart';

class BannerS extends StatelessWidget {
  const BannerS(
      {super.key,
      required this.image,
      required this.press,
      required this.children,
        this.aspectRatio = 2.3
      });

  final String image;
  final VoidCallback press;
  final List<Widget> children;
  final double? aspectRatio;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: aspectRatio!,
      child: GestureDetector(
        onTap: press,
        child: Stack(
          children: [
            Container(
              width: double.infinity,
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
            NetworkImageWithLoader(image, radius: 0 , fit: BoxFit.fitHeight,),
            ...children,
          ],
        ),
      ),
    );
  }
}
