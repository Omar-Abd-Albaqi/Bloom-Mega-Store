import 'package:bloom/extensions/locale_extension.dart';
import 'package:bloom/screens/language/view/select_language_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../../constants.dart';
import '../../../providers/locale_provider.dart';
import '../../../route/route_constants.dart';
import '../../../theme/input_decoration_theme.dart';

import 'components/language_card.dart';

class PreferredLanguageScreen extends StatelessWidget {
  const PreferredLanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Locale currentLocale = context.read<LocaleProvider>().locale;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),
              Text(
                context.loc.selectyourpreferredlanguage,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: defaultPadding / 2),
               Text(context.loc.youwillusethesamelanguagethroughouttheapp),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: defaultPadding),
                child: Form(
                  child: TextFormField(
                    onSaved: (language) {},
                    validator: (value) {
                      return null;
                    }, // validate your textfield
                    decoration: InputDecoration(
                      hintText: context.loc.searchyourlanguage,
                      filled: false,
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(defaultPadding / 2),
                        child: SvgPicture.asset(
                          "assets/icons/Search.svg",
                          height: 24,
                          width: 24,
                          colorFilter: ColorFilter.mode(
                            Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .color!
                                .withOpacity(0.25),
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                      border: secodaryOutlineInputBorder(context),
                      enabledBorder: secodaryOutlineInputBorder(context),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 6,
                child: ListView.separated(
                  itemCount: localesModel.length,
                  itemBuilder: (context, index) => LanguageCard(
                    localeModel: localesModel[index],
                    isActive: localesModel[index].locale == currentLocale,
                    press: () {
                      context.read<LocaleProvider>().setLocale(localesModel[index].locale);
                    },
                  ),
                  separatorBuilder: (context, index) => const SizedBox(
                    height: defaultPadding / 2,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, logInScreenRoute);
                },
                child:  Text(context.loc.next),
              ),
              const SizedBox(height: defaultPadding),
            ],
          ),
        ),
      ),
    );
  }
}


