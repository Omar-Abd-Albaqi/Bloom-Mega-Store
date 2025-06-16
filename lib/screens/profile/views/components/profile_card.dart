import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../components/network_image_with_loader.dart';
import '../../../../utils/hive_manager.dart';

import '../../../../constants.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    super.key,
    required this.name,
    required this.email,
    required this.imageSrc,
    this.proLableText = "Pro",
    this.isPro = false,
    this.press,
    this.isShowHi = true,
    this.isShowArrow = true,
  });

  final String? name, email, imageSrc;
  final String proLableText;
  final bool isPro, isShowHi, isShowArrow;
  final VoidCallback? press;

  @override
  Widget build(BuildContext context) {
    final bool isNameAvailable = name != null && name!.trim().isNotEmpty;
    final bool isEmailAvailable = email != null && email!.trim().isNotEmpty;
    final bool isLoggedIn = HiveStorageManager.signedInNotifier.value;

    return ListTile(
      onTap: press,
      leading: Hero(
        tag: email ?? "",
        child: CircleAvatar(
          radius: 28,
          backgroundColor: Colors.transparent,
          child: imageSrc == null
              ? Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              width: 56,
              height: 56,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
            ),
          )
              : ClipOval(
            child: imageSrc!.isNotEmpty ? NetworkImageWithLoader(
              imageSrc!,
              radius: 100,
            ): Image.asset("assets/transparent B.png"),
          ),
        ),
      ),
      title: isLoggedIn? Row(
        children: [
      isNameAvailable
      ? Text(
      isShowHi ? "Hi, $name" : name!,
        style: const TextStyle(fontWeight: FontWeight.w500),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      )
          : Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: 16,
        width: 100,
        color: Colors.white,
      ),
    ),
          const SizedBox(width: defaultPadding / 2),
          if (isPro)
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: defaultPadding / 2, vertical: defaultPadding / 4),
              decoration: const BoxDecoration(
                color: primaryColor,
                borderRadius:
                    BorderRadius.all(Radius.circular(defaultBorderRadious)),
              ),
              child: Text(
                proLableText,
                style: const TextStyle(
                  fontFamily: grandisExtendedFont,
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  letterSpacing: 0.7,
                  height: 1,
                ),
              ),
            ),
        ],
      ) : Container(
        color: Colors.transparent,
        height: 50,
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Text("You are not logged in!", textAlign: TextAlign.center,),
             Text("Please login to see your profile.", textAlign: TextAlign.center,style: TextStyle(color: Colors.black45),),
          ],
        ),
      ),
      subtitle: isLoggedIn ? isEmailAvailable
          ? Text(
        email!,
        style: const TextStyle(fontWeight: FontWeight.w400),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      )
          : Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          height: 14,
          width: 180, // Adjust as needed
          color: Colors.white,
        ),
      ) : null,
      trailing: isShowArrow
          ? SvgPicture.asset(
              "assets/icons/miniRight.svg",
              color: Theme.of(context).iconTheme.color!.withOpacity(0.4),
            )
          : null ,
    );
  }
}
