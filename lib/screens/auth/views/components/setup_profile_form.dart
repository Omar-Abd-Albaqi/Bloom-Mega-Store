import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../../providers/auth/sign_up_provider.dart';

import '../../../../constants.dart';

class SetupProfileForm extends StatelessWidget {
  const SetupProfileForm({
    super.key, required this.setupFormKey,
  });
  final GlobalKey<FormState> setupFormKey;

  String formatDate(DateTime date) {
    final DateFormat formatter = DateFormat('dd-MMM-yyyy');
    return formatter.format(date); // e.g. 24-Apr-2025
  }
  @override
  Widget build(BuildContext context) {

    return Form(
      key: setupFormKey,
      child: Column(
        children: [
          TextFormField(
            textCapitalization: TextCapitalization.words,
            onSaved: (fullName) {
              if (fullName != null && fullName.trim().isNotEmpty) {
                final trimmedName = fullName.trim();
                final spaceIndex = trimmedName.indexOf(' ');

                String firstName;
                String lastName;

                if (spaceIndex == -1) {
                  // No space found → treat whole name as first name
                  firstName = trimmedName;
                  lastName = '';
                } else {
                  firstName = trimmedName.substring(0, spaceIndex);
                  lastName = trimmedName.substring(spaceIndex + 1).trim();
                }

                context.read<SignUpProvider>().firstName = firstName;
                context.read<SignUpProvider>().lastName = lastName;
              }
            },
            // validator: nameValidator.call,
            decoration: InputDecoration(
              hintText: "Full name",
              prefixIcon: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: defaultPadding * 0.75),
                child: SvgPicture.asset(
                  "assets/icons/Profile.svg",
                  height: 24,
                  width: 24,
                  colorFilter: ColorFilter.mode(
                      Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .color!
                          .withOpacity(0.3),
                      BlendMode.srcIn),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: Selector<SignUpProvider, String>(
              selector: (_ , prov) => prov.dateOfBirth,
              builder: (_, dateOfBirth, child) {
                return TextFormField(
                  controller: TextEditingController(text: dateOfBirth),
                  onTap: ()async{
                    DateTime? date= await showDatePicker(context: context, firstDate: DateTime(1900), lastDate: DateTime.now());
                    if(date != null){
                      String dateOfBirth = formatDate(date);
                      if(context.mounted){
                        context.read<SignUpProvider>().setDateOfBirth(dateOfBirth);
                      }
                    }
                  },
                  // validator: dateOfBirthValidator.call,
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: "Date of birth",
                    prefixIcon: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: defaultPadding * 0.75),
                      child: SvgPicture.asset(
                        "assets/icons/Calender.svg",
                        height: 24,
                        width: 24,
                        colorFilter: ColorFilter.mode(
                            Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .color!
                                .withOpacity(0.3),
                            BlendMode.srcIn),
                      ),
                    ),
                  ),
                );
              }
            ),
          ),
          TextFormField(
            keyboardType: TextInputType.phone,
            onSaved: (phone){
              context.read<SignUpProvider>().phone = phone ?? "";
            },
            // validator: phoneValidator.call,
            decoration: InputDecoration(

              hintText: "Phone number",
              prefixIcon: GestureDetector(
                onTap: (){
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: defaultPadding),
                  child: SizedBox(
                    width: 80,
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          "assets/icons/Call.svg",
                          height: 24,
                          width: 24,
                          colorFilter: ColorFilter.mode(
                              Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .color!
                                  .withOpacity(0.3),
                              BlendMode.srcIn),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: defaultPadding / 2),
                          child: Text(
                            "+961",
                            style:
                                Theme.of(context).inputDecorationTheme.hintStyle,
                          ),
                        ),
                        const SizedBox(
                          height: 24,
                          child: VerticalDivider(
                            thickness: 1,
                            width: defaultPadding / 2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding /2),
            child: Selector<SignUpProvider, String>(
              selector: (_, prov) => prov.gender,
              builder: (_, gender, child){
                return SizedBox(
                  height: 60,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: (){
                          context.read<SignUpProvider>().setGender("Male");
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 150),
                          width: (MediaQuery.of(context).size.width /2) - (defaultPadding +4),
                          height: 50,
                          decoration: BoxDecoration(
                            color: lightGreyColor,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: gender == "Male"? primaryColor : Colors.transparent, width: 1)
                          ),
                          alignment: const Alignment(0, 0),
                          child: const Text("Male" , style: TextStyle(color: Colors.black),),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          context.read<SignUpProvider>().setGender("Female");
                },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 150),
                          width: (MediaQuery.of(context).size.width /2) - (defaultPadding + 4),
                          height: 50,
                          decoration: BoxDecoration(
                              color: lightGreyColor,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: gender == "Female" ?  primaryColor : Colors.transparent, width: 1)
                        
                          ),
                          alignment: const Alignment(0, 0),
                          child: const Text("Female" , style: TextStyle(color: Colors.black),),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          )

        ],
      ),
    );
  }
}
