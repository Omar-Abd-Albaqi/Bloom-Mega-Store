import 'package:flutter/widgets.dart';

import '../l10n/app_localizations.dart';

extension LocaleText on BuildContext {
  AppLocalizations get loc => AppLocalizations.of(this)!;
}