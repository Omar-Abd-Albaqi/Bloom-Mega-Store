import 'package:bloom/providers/locale_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../../constants.dart';

import '../../../screens/language/view/components/language_card.dart';
import '../../../theme/input_decoration_theme.dart';


class LocaleModel {
  final Locale locale;
  final String flag;
  final String language;
  LocaleModel(
   {
     required this.locale,
     required this.flag,
     required this.language,
});
}

List<LocaleModel> localesModel = [
  LocaleModel(locale: const Locale('en'), flag: "assets/flags/England.svg", language: "English"),
  // LocaleModel(locale: Locale('de'), flag: "assets/flags/England.svg", language: "English"),
  LocaleModel(locale: const Locale('ar'), flag: "assets/flags/ar.svg", language: "العربية"),
  // LocaleModel(locale: Locale('es'), flag: "assets/flags/England.svg", language: "English"),
  LocaleModel(locale: const Locale('fr'), flag: "assets/flags/france.svg", language: "France"),
  // LocaleModel(locale: Locale('it'), flag: "assets/flags/England.svg", language: "English"),
  // LocaleModel(locale: Locale('ru'), flag: "assets/flags/England.svg", language: "English"),
  // LocaleModel(locale: Locale('ja'), flag: "assets/flags/England.svg", language: "English"),

];

class SelectLanguageScreen extends StatelessWidget {
  const SelectLanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Locale currentLocale = context.read<LocaleProvider>().locale;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Language"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),
              Text(
                "Select your preferred languages",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: defaultPadding / 2),
              const Text("You will use the same language throughout the app."),
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
                      hintText: "Search your language",
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
                flex: localesModel.length,
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
                  Navigator.pop(context);
                },
                child: const Text("Done"),
              ),
              const SizedBox(height: defaultPadding),
            ],
          ),
        ),
      ),
    );
  }
}
