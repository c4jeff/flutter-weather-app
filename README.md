# 晴雨间

[![CI/CD](https://github.com/c4jeff/flutter-weather-app/actions/workflows/ci.yml/badge.svg)](https://github.com/c4jeff/flutter-weather-app/actions/workflows/ci.yml)

一个使用 Flutter 构建的天气应用。搜索地点后，可查看当前天气和未来 7 天预报。

## 功能

- 按中文或英文搜索地点，并显示行政区和国家
- 查看当前温度、体感温度、天气状况、湿度、风速与降水
- 查看未来 7 天最高温、最低温和降水概率
- 分别呈现搜索与天气请求的 Loading、Error 和空结果状态
- 失败后可重试；页面切换时取消不再需要的网络请求
- 按系统语言显示简体中文或英文
- 响应式适配 Android、iOS 和 Web

## 技术栈

- Flutter / Dart
- Riverpod：状态管理和依赖注入
- Dio：HTTP 客户端、拦截器和请求取消
- Flutter gen-l10n / ARB：本地化资源
- `intl`：日期和星期格式化
- Open-Meteo：地点搜索与天气数据，无需 API Key

API 文档：[Geocoding API](https://open-meteo.com/en/docs/geocoding-api) · [Weather Forecast API](https://open-meteo.com/en/docs)

## 架构

项目按功能组织，并在每个功能中区分 Clean Architecture 的展示层、领域层和数据层。依赖关系朝向领域规则：展示层只调用用例，领域层持有模型、用例和 Repository 契约，数据层实现契约并处理 Open-Meteo 的网络格式。`app` 是组合根，负责将数据实现注入展示层声明的依赖。

```text
lib/
├── main.dart                             # 启动应用
├── app/                                  # 应用壳、主题和依赖装配
│   ├── di/app_dependencies.dart          # 绑定领域契约与数据实现
│   └── theme/                            # 应用级颜色和主题
├── core/                                 # 网络、错误、取消信号和全局配置
├── shared/presentation/widgets/          # 多功能共享 UI 组件
├── features/
│   ├── home/presentation/                # 页面级组合：连接地点与天气功能
│   ├── location/
│   │   ├── data/repositories/            # Open-Meteo 地点数据实现
│   │   ├── domain/{entities,repositories,use_cases}/
│   │   └── presentation/{providers,widgets}/
│   └── weather/
│       ├── data/{mappers,repositories}/  # 响应映射和 Open-Meteo 实现
│       ├── domain/{entities,repositories,use_cases,value_objects}/
│       └── presentation/{formatters,providers,widgets}/
└── l10n/
    ├── arb/                              # 简体中文和英文文案源文件
    └── generated/                        # Flutter 生成文件，不手工修改
```

### 依赖与数据流

```text
Widget → Presentation Provider → Domain Use Case → Domain Repository contract
                                                        ↑
App composition root → Data Repository implementation → JsonApiClient / Dio → Open-Meteo
                                                        ↓
Widget ← Domain model ← Data Mapper ←──────────────── API response
```

- `domain` 不依赖 Flutter、Riverpod、Dio 或 Open-Meteo。Repository 接口表达应用需要的能力，而不暴露 HTTP 请求细节。
- `presentation` 通过用例发起搜索和天气查询，并使用 Riverpod 管理请求状态；它只依赖领域模型、契约和用例。
- `data` 实现领域 Repository 契约，负责端点参数、响应校验与模型映射。Open-Meteo 的 WMO 天气代码在 `WeatherMapper` 中转换为领域枚举。
- `app/di/app_dependencies.dart` 将具体实现绑定到抽象 Provider。测试可以直接替换领域 Repository 契约。
- `features/home` 负责主页级别的功能组合；它读取选中的地点并构造天气查询参数，搜索和天气展示仍由各自功能负责。
- `core/network` 封装 Dio、JSON 响应校验和拦截器。取消信号位于 `core/cancellation`，Dio `CancelToken` 只在网络客户端内部创建，因此 Dio 不会渗入领域层。
- 跨功能通用组件放在 `shared/presentation/widgets`；功能专属组件放在各自的 `presentation/widgets`。
- 手写 Dart 文件统一使用 `package:weather_app/...` 导入。`always_use_package_imports` lint 会检查此约定；gen-l10n 生成文件由工具维护。

## 状态与网络

- 搜索词和焦点由搜索 Widget 管理；搜索防抖、请求超时和页面过渡时长统一定义在 `AppDurations`。
- 搜索使用地点功能的 `SearchLocations` 用例；天气使用 `GetWeatherForecast` 用例。两个请求分别使用 `FutureProvider.autoDispose`，释放时经由取消信号停止底层 Dio 请求。
- 当前选择地点由 `NotifierProvider` 持有；天气请求参数为经纬度和时区，不依赖地点功能的数据模型。
- 每个请求有独立的 `AsyncValue`，失败后可单独重试。Repository 和客户端通过 Provider 注入。
- Repository 将 API 响应交给 Mapper。字段缺失、类型错误或数组长度不一致时转换为 `AppException`；错误码不携带展示文案，由 `l10n/app_error_messages.dart` 映射成当前语言的提示。
- `JsonApiClient` 设置超时并提供统一的 JSON 对象响应；默认拦截器添加 JSON `Accept` 请求头，并将超时、连接、HTTP 状态、取消和 JSON 解码错误归类为 `AppExceptionCode`。额外 Dio 拦截器通过 `apiInterceptorsProvider` 注入。
- API 主机和路径集中在 `core/network/api_endpoints.dart`。

## 本地化

文案源文件位于 `lib/l10n/arb`，包含简体中文和英文。界面通过生成的 `AppLocalizations` 读取字符串，并使用当前 locale 格式化日期。新增语言时增加对应 ARB 资源，然后运行：

```bash
flutter gen-l10n
```

不要手动修改 `lib/l10n/generated` 下的文件。

## 环境与运行

项目版本由 `.tool-versions` 管理：Flutter `3.41.9-stable`、Java `17`、Gradle `8.13`。

```bash
flutter pub get
flutter run
```

指定目标设备：

```bash
flutter run -d chrome
flutter run -d android
flutter run -d ios
```

检查 asdf 提供的 Gradle：

```bash
asdf current gradle
```

## 质量检查

```bash
dart format --output=none --set-exit-if-changed lib test
flutter analyze
flutter test
flutter build web --release
```

测试覆盖天气代码和响应映射、地点请求与响应解析，以及搜索地点后展示天气的 Widget 流程。

## CI/CD

GitHub Actions 在推送到 `main`、提交 Pull Request 或手动触发时，从 `.tool-versions` 安装 Flutter、Java 和 Gradle，然后安装依赖、检查格式、运行静态分析和测试、构建 Web Release 与 Android Debug APK，并将产物上传为 14 天有效的 Actions Artifact。工作流不需要 API Key 或 GitHub Secrets。

## 当前范围

应用包含一个天气主页，支持地点搜索、当前天气和 7 天预报；不包含小时预报。应用不申请设备定位权限，不保存收藏或最近地点，也不提供离线缓存。

## 数据来源

Weather data by [Open-Meteo.com](https://open-meteo.com/)。天气描述基于 WMO Weather Interpretation Codes。
