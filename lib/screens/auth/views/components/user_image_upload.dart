// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:provider/provider.dart';
// import 'package:shop/providers/auth/sign_up_provider.dart';
// import 'package:shop/utils/pop_ups.dart';
//
// class UserImageUpload extends StatelessWidget {
//   const UserImageUpload({
//     super.key,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         CircleAvatar(
//           backgroundColor: Theme.of(context).inputDecorationTheme.fillColor,
//           radius: 60,
//           child: SizedBox(
//             height: 120,
//             width: 120,
//             child: Stack(
//               alignment: Alignment.center,
//               children: [
//                 Selector<SignUpProvider, XFile?>(
//                   selector: (_ , prov) => prov.image,
//                   builder: (_, image, child) {
//                     return image == null ? SvgPicture.asset(
//                       "assets/icons/Profile.svg",
//                       height: 40,
//                       width: 40,
//                       colorFilter: ColorFilter.mode(
//                         Theme.of(context)
//                             .textTheme
//                             .bodyLarge!
//                             .color!
//                             .withOpacity(0.3),
//                         BlendMode.srcIn,
//                       ),
//                     ): GestureDetector(
//                       onTap: (){
//                         Navigator.push(context, MaterialPageRoute(builder: (ctx) {
//                           return Scaffold(
//                             appBar: AppBar(
//                               actions: [
//                                 IconButton(
//                                     onPressed: (){
//                                   Navigator.pop(ctx);
//                                   // context.read<SignUpProvider>().setImage(null);
//                                 }, icon: const Icon(Icons.delete_forever, color: Colors.red,))
//                               ],
//                             ),
//                             body: Center(
//                               child: Hero(
//                                   tag: image.path,
//                                   child: Image.file(File(image.path))),
//                             ),
//                           );
//                         }));
//                       },
//                       child: ClipRRect(
//                           borderRadius: BorderRadius.circular(100),
//                           child: Hero(
//                               tag: image.path,
//                               child: Image.file(File(image.path), fit: BoxFit.cover,width: 120,))),
//                     );
//                   }
//                 ),
//                 Positioned(
//                   height: 40,
//                   width: 40,
//                   right: 0,
//                   bottom: 0,
//                   child: ElevatedButton(
//                     onPressed: () {
//                       PopUps.selectPhotoPickType(context, fromSignUp: true);
//                     },
//                     style: ElevatedButton.styleFrom(
//                       shape: const CircleBorder(),
//                       padding: EdgeInsets.zero,
//                     ),
//                     child: SvgPicture.asset(
//                       "assets/icons/Camera-Bold.svg",
//                       colorFilter: ColorFilter.mode(
//                         Theme.of(context).scaffoldBackgroundColor,
//                         BlendMode.srcIn,
//                       ),
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ),
//         TextButton(
//           onPressed: () {
//             PopUps.selectPhotoPickType(context, fromSignUp: true);
//           },
//           child: const Text("Upload Image"),
//         )
//       ],
//     );
//   }
// }
