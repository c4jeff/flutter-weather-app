# 晴雨间

[![CI/CD](https://github.com/c4jeff/flutter-weather-app/actions/workflows/ci.yml/badge.svg)](https://github.com/c4jeff/flutter-weather-app/actions/workflows/ci.yml)

一个使用 Flutter 构建的轻量天气应用。用户可以搜索地点，查看当前天气和未来 7 天预报。

项目将重点放在清晰的数据边界、可测试的状态管理和完整的 Loading/Error 体验上，而不是堆叠功能。

## 功能

- 使用中文或英文搜索城市
- 展示城市、行政区和国家，区分同名地点
- 查看当前温度、体感温度和天气状况
- 查看湿度、风速和降水量
- 查看未来 7 天最高温、最低温和降水概率
- 独立处理地点搜索和天气请求的 Loading、空结果及 Error 状态
- 支持失败重试
- 响应式适配 Android、iOS 和 Web

## 技术栈

- Flutter / Dart
- Material 3
- Riverpod：异步状态管理与依赖注入
- `http`：网络请求
- `intl`：日期格式化
- Open-Meteo：地点搜索与天气数据

Open-Meteo 的公开接口无需在项目内配置 API Key：

- [Geocoding API](https://open-meteo.com/en/docs/geocoding-api)
- [Weather Forecast API](https://open-meteo.com/en/docs)

## 架构

代码按业务功能组织，并在每个功能内划分数据、领域和展示层：

```text
lib/
├── app/                         # 应用入口、主题
├── core/
│   ├── error/                   # 统一错误类型和用户提示
│   ├── network/                 # JSON HTTP 客户端
│   └── widgets/                 # 通用 Loading、Error 组件
└── features/
    ├── location/
    │   ├── data/                # 地点 Repository 与 API 映射
    │   ├── domain/              # Location 模型
    │   └── presentation/        # Provider 与搜索组件
    └── weather/
        ├── data/                # 天气 Repository 与 Mapper
        ├── domain/              # 天气领域模型
        └── presentation/        # Provider、页面和天气组件
```

数据流：

```text
Widget → Riverpod Provider → Repository → Open-Meteo
                                      ↓
Widget ← Domain Model ← Mapper ← API JSON
```

界面不直接读取第三方 API 响应。`WeatherMapper` 会校验 Open-Meteo 返回的数据，并将并行的每日数据数组转换为 `DailyForecast` 对象列表。API 字段变化或数据不完整时会得到明确的数据错误，而不是在 Widget 中产生类型异常。

## 状态管理

- 搜索框文本、焦点和 350ms 防抖属于局部交互状态，由 Widget 管理。
- 地点搜索使用参数化的 `FutureProvider.autoDispose`。
- 当前选择地点使用 `NotifierProvider`。
- 天气请求使用以 `Location` 为参数的 `FutureProvider.autoDispose`。
- Repository 和网络客户端通过 Provider 注入，测试中可以直接替换为 Fake。

地点搜索与天气请求各自拥有独立的 `AsyncValue`，一个请求失败不会污染另一个请求的状态。快速修改搜索词时，旧 Provider 会被释放，旧结果不会覆盖当前查询。

## 错误处理

网络层将异常归一化为以下类别：

```dart
enum AppErrorKind {
  network,
  timeout,
  service,
  invalidData,
  unknown,
}
```

技术错误不会直接展示给用户。界面根据错误类别提供简短提示，并保留地点或输入内容供用户重试。

## 运行项目

环境要求：

- Flutter Stable
- Dart 3.11 或兼容版本
- Gradle 8.13（由项目 `.tool-versions` 配置）

安装依赖：

```bash
flutter pub get
```

检查 asdf 中的 Gradle 版本：

```bash
asdf current gradle
```

运行：

```bash
flutter run
```

指定平台：

```bash
flutter run -d chrome
flutter run -d android
flutter run -d ios
```

## 质量检查

格式化与静态分析：

```bash
dart format --output=none --set-exit-if-changed lib test
flutter analyze
```

运行测试：

```bash
flutter test
```

构建 Web：

```bash
flutter build web
```

## CI/CD

GitHub Actions 会在推送到 `main`、提交 Pull Request 或手动触发时执行：

1. 从项目 `.tool-versions` 安装 Flutter、Java 和 Gradle。
2. 检查代码格式并运行静态分析。
3. 运行全部测试并生成覆盖率数据。
4. 构建 Web Release。
5. 通过 `asdf exec gradle` 构建 Android Debug APK。
6. 将 Web 压缩包和 APK 保存为 14 天有效的 Actions Artifact。

工作流只授予只读仓库权限，不需要配置 API Key 或其他 GitHub Secrets。

测试覆盖以下关键行为：

- WMO 天气代码到领域枚举的映射
- Open-Meteo 响应到领域模型的转换
- 每日预报数组长度不一致时的错误处理
- 地点请求参数和中文响应解析
- 搜索、选择地点并展示天气的完整 Widget 流程

## 设计取舍

- 应用只有一个主要页面，因此没有引入路由框架。
- 服务端数据由 Riverpod 管理，没有再引入额外全局状态库。
- 网络调用简单，使用 `http` 和薄封装即可满足超时、状态码和 JSON 校验需求。
- 当前版本不申请设备定位权限，让首次使用流程保持明确且易于测试。
- 当前版本不持久化最近地点，刷新应用后回到搜索引导页。

## 可扩展方向

- 收藏和最近访问地点
- 摄氏度与华氏度切换
- 小时级预报
- 根据当前位置获取天气
- 本地缓存与离线展示
- 深色主题

## 数据来源

Weather data by [Open-Meteo.com](https://open-meteo.com/)，天气描述基于 WMO Weather Interpretation Codes。
