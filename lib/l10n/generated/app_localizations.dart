import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('zh'),
  ];

  /// No description provided for @appName.
  ///
  /// In zh, this message translates to:
  /// **'晴雨间'**
  String get appName;

  /// No description provided for @appTagline.
  ///
  /// In zh, this message translates to:
  /// **'查找城市，了解天气'**
  String get appTagline;

  /// No description provided for @searchLocationHint.
  ///
  /// In zh, this message translates to:
  /// **'搜索城市，例如：上海、Tokyo'**
  String get searchLocationHint;

  /// No description provided for @clearSearch.
  ///
  /// In zh, this message translates to:
  /// **'清除搜索'**
  String get clearSearch;

  /// No description provided for @enterMoreCharacters.
  ///
  /// In zh, this message translates to:
  /// **'请再输入至少一个字符'**
  String get enterMoreCharacters;

  /// No description provided for @retry.
  ///
  /// In zh, this message translates to:
  /// **'重试'**
  String get retry;

  /// No description provided for @reload.
  ///
  /// In zh, this message translates to:
  /// **'重新加载'**
  String get reload;

  /// No description provided for @noLocationsFound.
  ///
  /// In zh, this message translates to:
  /// **'没有找到匹配的地点'**
  String get noLocationsFound;

  /// No description provided for @loadingWeather.
  ///
  /// In zh, this message translates to:
  /// **'正在加载天气'**
  String get loadingWeather;

  /// No description provided for @networkError.
  ///
  /// In zh, this message translates to:
  /// **'无法连接到天气服务，请检查网络后重试。'**
  String get networkError;

  /// No description provided for @timeoutError.
  ///
  /// In zh, this message translates to:
  /// **'请求超时，请稍后重试。'**
  String get timeoutError;

  /// No description provided for @serviceError.
  ///
  /// In zh, this message translates to:
  /// **'天气服务暂时不可用，请稍后重试。'**
  String get serviceError;

  /// No description provided for @invalidWeatherDataError.
  ///
  /// In zh, this message translates to:
  /// **'天气数据不完整，请重新加载。'**
  String get invalidWeatherDataError;

  /// No description provided for @unexpectedError.
  ///
  /// In zh, this message translates to:
  /// **'出现了意外问题，请稍后重试。'**
  String get unexpectedError;

  /// No description provided for @initialTitle.
  ///
  /// In zh, this message translates to:
  /// **'从一个地点开始'**
  String get initialTitle;

  /// No description provided for @initialDescription.
  ///
  /// In zh, this message translates to:
  /// **'在上方搜索城市，即可查看当前天气和未来 7 天预报。'**
  String get initialDescription;

  /// No description provided for @forecastTitle.
  ///
  /// In zh, this message translates to:
  /// **'未来 7 天'**
  String get forecastTitle;

  /// No description provided for @weatherDataAttribution.
  ///
  /// In zh, this message translates to:
  /// **'天气数据由 Open-Meteo 提供'**
  String get weatherDataAttribution;

  /// No description provided for @humidity.
  ///
  /// In zh, this message translates to:
  /// **'湿度'**
  String get humidity;

  /// No description provided for @windSpeed.
  ///
  /// In zh, this message translates to:
  /// **'风速'**
  String get windSpeed;

  /// No description provided for @precipitation.
  ///
  /// In zh, this message translates to:
  /// **'降水'**
  String get precipitation;

  /// No description provided for @today.
  ///
  /// In zh, this message translates to:
  /// **'今天'**
  String get today;

  /// No description provided for @feelsLike.
  ///
  /// In zh, this message translates to:
  /// **'体感'**
  String get feelsLike;

  /// No description provided for @maximum.
  ///
  /// In zh, this message translates to:
  /// **'最高'**
  String get maximum;

  /// No description provided for @minimum.
  ///
  /// In zh, this message translates to:
  /// **'最低'**
  String get minimum;

  /// No description provided for @updated.
  ///
  /// In zh, this message translates to:
  /// **'更新'**
  String get updated;

  /// No description provided for @currentWeatherSummary.
  ///
  /// In zh, this message translates to:
  /// **'体感 {apparentTemperature}° · 最高 {maximumTemperature}°  最低 {minimumTemperature}°'**
  String currentWeatherSummary(
    int apparentTemperature,
    int maximumTemperature,
    int minimumTemperature,
  );

  /// No description provided for @weatherUpdatedAt.
  ///
  /// In zh, this message translates to:
  /// **'{formattedDate} 更新'**
  String weatherUpdatedAt(Object formattedDate);

  /// No description provided for @clear.
  ///
  /// In zh, this message translates to:
  /// **'晴朗'**
  String get clear;

  /// No description provided for @mostlyClear.
  ///
  /// In zh, this message translates to:
  /// **'少云'**
  String get mostlyClear;

  /// No description provided for @cloudy.
  ///
  /// In zh, this message translates to:
  /// **'多云'**
  String get cloudy;

  /// No description provided for @fog.
  ///
  /// In zh, this message translates to:
  /// **'有雾'**
  String get fog;

  /// No description provided for @drizzle.
  ///
  /// In zh, this message translates to:
  /// **'毛毛雨'**
  String get drizzle;

  /// No description provided for @rain.
  ///
  /// In zh, this message translates to:
  /// **'降雨'**
  String get rain;

  /// No description provided for @snow.
  ///
  /// In zh, this message translates to:
  /// **'降雪'**
  String get snow;

  /// No description provided for @shower.
  ///
  /// In zh, this message translates to:
  /// **'阵雨'**
  String get shower;

  /// No description provided for @thunderstorm.
  ///
  /// In zh, this message translates to:
  /// **'雷暴'**
  String get thunderstorm;

  /// No description provided for @unknownWeather.
  ///
  /// In zh, this message translates to:
  /// **'未知'**
  String get unknownWeather;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
