import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../../models/customer_models/customer_details_model.dart';
import '../../../../providers/profile_providers/customer_details_provider.dart';

import '../../../../constants.dart';

class UserInfoForm extends StatelessWidget {
  const UserInfoForm({
    super.key, required this.formState,
  });
  final GlobalKey<FormState> formState;

  String formatDate(DateTime date) {
    final DateFormat formatter = DateFormat('dd-MMM-yyyy');
    return formatter.format(date); // e.g. 24-Apr-2025
  }
  @override
  Widget build(BuildContext context) {


    return PopScope(
      onPopInvokedWithResult: (didPop, _){
        context.read<CustomerDetailsProvider>().dateOfBirth = "";
      },
      child: Form(
        key: formState,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
          child: Selector<CustomerDetailsProvider, CustomerDetailsModel?>(
            selector: (_, prov)=> prov.customerDetailsModel,
            builder: (_, customer, child) {
              WidgetsBinding.instance.addPostFrameCallback((_){
                context.read<CustomerDetailsProvider>().setGender(customer?.metadata['gender'] == "" || customer?.metadata['gender'] == null ? "Male" : customer?.metadata['gender']);
              });
              return Column(
                children: [
                  TextFormField(
                    initialValue: "${customer?.firstName ?? ""} ${customer?.lastName ?? ""}",
                    textInputAction: TextInputAction.next,
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
                        context.read<CustomerDetailsProvider>().firstName = firstName;
                        context.read<CustomerDetailsProvider>().lastName = lastName;
                      }
                    },
                    decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: defaultPadding * 0.75),
                        child: SvgPicture.asset(
                          "assets/icons/Profile.svg",
                          color: Theme.of(context).iconTheme.color,
                          height: 24,
                          width: 24,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: defaultPadding),
                    child: TextFormField(
                      readOnly: true,
                      initialValue: customer?.email ?? "",
                      keyboardType: TextInputType.emailAddress,
                      validator: emaildValidator.call,
                      onSaved: (em){
                        context.read<CustomerDetailsProvider>().email = em ??"";
                      },
                      decoration: InputDecoration(
                        prefixIcon: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: defaultPadding * 0.75),
                          child: SvgPicture.asset(
                            "assets/icons/Message.svg",
                            color: Theme.of(context).iconTheme.color,
                            height: 24,
                            width: 24,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Selector<CustomerDetailsProvider, String>(
                    selector: (_, prov) => prov.dateOfBirth,
                    builder: (_, dateOfBirth,child) {
                      return TextFormField(
                        controller: TextEditingController(text: customer?.metadata['date_of_birth'] == "" || customer?.metadata['date_of_birth'] == null ? dateOfBirth.isEmpty ? "Undefined" : dateOfBirth : customer?.metadata['date_of_birth'] ),
                        readOnly: true,
                        onTap: ()async{
                          DateTime? date= await showDatePicker(context: context, firstDate: DateTime(1900), lastDate: DateTime.now());
                          if(date != null){
                            String dateOfBirth = formatDate(date);
                            if(context.mounted){
                              context.read<CustomerDetailsProvider>().setDateOfBirth(dateOfBirth);
                            }
                          }
                        },
                        // initialValue: customer?.metadata['date_of_birth'] == null || customer?.metadata['date_of_birth'] == ""? "Undefined" : customer?.metadata['date_of_birth'],
                        decoration: InputDecoration(
                          prefixIcon: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: defaultPadding * 0.75),
                            child: SvgPicture.asset(
                              "assets/icons/Calender.svg",
                              color: Theme.of(context).iconTheme.color,
                              height: 24,
                              width: 24,
                            ),
                          ),
                        ),
                      );
                    }
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: defaultPadding),
                    child: TextFormField(
                      onSaved: (ph){
                        context.read<CustomerDetailsProvider>().phone = ph ?? "";
                      },
                      initialValue: customer?.phone,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(left: defaultPadding),
                          child: SizedBox(
                            width: 72,
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  "assets/icons/Call.svg",
                                  height: 24,
                                  width: 24,
                                  color:
                                      Theme.of(context).textTheme.bodyLarge!.color!,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: defaultPadding / 2),
                                  child: Text("+1",
                                      style: Theme.of(context).textTheme.bodyLarge),
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
                  Selector<CustomerDetailsProvider, String>(
                    selector: (_, prov) => prov.gender,
                    builder: (_, gender, child){

                      return SizedBox(
                        height: 60,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: (){
                                context.read<CustomerDetailsProvider>().setGender("Male");
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
                                context.read<CustomerDetailsProvider>().setGender("Female");
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
                ],
              );
            }
          ),
        ),
      ),
    );
  }
}
