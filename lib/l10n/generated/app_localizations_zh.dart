// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appName => '晴雨间';

  @override
  String get appTagline => '查找城市，了解天气';

  @override
  String get searchLocationHint => '搜索城市，例如：上海、Tokyo';

  @override
  String get clearSearch => '清除搜索';

  @override
  String get enterMoreCharacters => '请再输入至少一个字符';

  @override
  String get retry => '重试';

  @override
  String get reload => '重新加载';

  @override
  String get noLocationsFound => '没有找到匹配的地点';

  @override
  String get loadingWeather => '正在加载天气';

  @override
  String get networkError => '无法连接到天气服务，请检查网络后重试。';

  @override
  String get timeoutError => '请求超时，请稍后重试。';

  @override
  String get serviceError => '天气服务暂时不可用，请稍后重试。';

  @override
  String get invalidWeatherDataError => '天气数据不完整，请重新加载。';

  @override
  String get unexpectedError => '出现了意外问题，请稍后重试。';

  @override
  String get initialTitle => '从一个地点开始';

  @override
  String get initialDescription => '在上方搜索城市，即可查看当前天气和未来 7 天预报。';

  @override
  String get forecastTitle => '未来 7 天';

  @override
  String get weatherDataAttribution => '天气数据由 Open-Meteo 提供';

  @override
  String get humidity => '湿度';

  @override
  String get windSpeed => '风速';

  @override
  String get precipitation => '降水';

  @override
  String get today => '今天';

  @override
  String get feelsLike => '体感';

  @override
  String get maximum => '最高';

  @override
  String get minimum => '最低';

  @override
  String get updated => '更新';

  @override
  String currentWeatherSummary(
    int apparentTemperature,
    int maximumTemperature,
    int minimumTemperature,
  ) {
    return '体感 $apparentTemperature° · 最高 $maximumTemperature°  最低 $minimumTemperature°';
  }

  @override
  String weatherUpdatedAt(Object formattedDate) {
    return '$formattedDate 更新';
  }

  @override
  String get clear => '晴朗';

  @override
  String get mostlyClear => '少云';

  @override
  String get cloudy => '多云';

  @override
  String get fog => '有雾';

  @override
  String get drizzle => '毛毛雨';

  @override
  String get rain => '降雨';

  @override
  String get snow => '降雪';

  @override
  String get shower => '阵雨';

  @override
  String get thunderstorm => '雷暴';

  @override
  String get unknownWeather => '未知';
}
