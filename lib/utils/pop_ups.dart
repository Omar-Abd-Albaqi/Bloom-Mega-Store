
import 'package:flutter/material.dart';



class PopUps {
  static Future apiError (BuildContext context, String message) => showDialog(
      context: context,
      builder: (BuildContext ctx){
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              color: const Color(0xFFffffff),
              borderRadius: BorderRadius.circular(12),
            ),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 9),
                // Image.asset("assets/icons/info.png", width: 40,height: 40,color: Colors.red,),
                Container(
                  width: double.infinity,
                  height: 100,
                  alignment: const Alignment(0, 0),
                  child: Text(message , style: const TextStyle(fontSize: 14 , color: Colors.black , fontWeight: FontWeight.w500),),
                ),
                const Spacer(),
                const Divider(height: 0),
                GestureDetector(
                  onTap: () => Navigator.pop(ctx),
                  child: Container(
                    color: Colors.transparent,
                    width: double.infinity,
                    height: 50,
                    alignment: Alignment.center,
                    child: const Text("OK" , style: TextStyle(fontWeight: FontWeight.w500 , color: Color(0xFF000000)),),
                  ),
                ),
              ],
            ),
          ),
        );
      });

  // static Future selectPhotoPickType (BuildContext context, {bool fromSignUp = false}) => showDialog(
  //     context: context,
  //     builder: (BuildContext ctx){
  //       return  Dialog(
  //         backgroundColor: Colors.transparent,
  //         child: Container(
  //           width: 200,
  //           height: 140,
  //           decoration: BoxDecoration(
  //             color: const Color(0xFFffffff),
  //             borderRadius: BorderRadius.circular(12),
  //           ),
  //           alignment: Alignment.center,
  //           child: Column(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               GestureDetector(
  //                 onTap: () async {
  //                     final XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
  //                     if(image != null){
  //                       if(context.mounted){
  //                         if(fromSignUp){
  //                           context.read<SignUpProvider>().setImage(image);
  //                         }else{
  //                           context.read<CustomerDetailsProvider>().setImage(image);
  //                         }
  //
  //                       }
  //                     }
  //                   Navigator.pop(ctx);
  //                 },
  //                 child: Container(
  //                   padding: const EdgeInsets.only(left: 20),
  //                   color: Colors.transparent,
  //                   width: double.infinity,
  //                   height: 70,
  //                   child: const Row(
  //                     children: [
  //                       Icon(Icons.image_search_outlined),
  //                       SizedBox(
  //                         width: 20,
  //                       ),
  //                       Text("Gallery" , style: TextStyle(color: Colors.black , fontSize: 14 , fontWeight: FontWeight.w600),)
  //                     ],
  //                   ),
  //                 ),
  //               ),
  //               const Divider(
  //                 height: 0,
  //               ),
  //               GestureDetector(
  //                 onTap: () async {
  //
  //                   final XFile? image = await ImagePicker().pickImage(source: ImageSource.camera);
  //                   if (image != null) {
  //                     if(context.mounted){
  //                       if(fromSignUp){
  //                         context.read<SignUpProvider>().setImage(image);
  //                       }else{
  //                         context.read<CustomerDetailsProvider>().setImage(image);
  //                       }
  //                     }
  //                   }
  //                   Navigator.pop(ctx);
  //                 },
  //                 child: Container(
  //                   color: Colors.transparent,
  //                   width: double.infinity,
  //                   padding: const EdgeInsets.only(left: 20),
  //                   height: 70,
  //                   child: const Row(
  //                     children: [
  //                       Icon(Icons.camera_alt_outlined),
  //                       SizedBox(
  //                         width: 20,
  //                       ),
  //                       Text("Camera" , style: TextStyle(color: Colors.black , fontSize: 14 , fontWeight: FontWeight.w600),)
  //                     ],
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       );
  //     });
}