import 'dart:math';

import 'package:package_info/package_info.dart';

int createUniqueId() {
  return DateTime.now().millisecondsSinceEpoch.remainder(100000);
}

Future<String?> getAppName() async {
  String? appName;
  await PackageInfo.fromPlatform().then((packageInfo) {
    appName = packageInfo.appName;
  });
  return appName;
}

Future<String?> getAppVersion() async {
  String? version;
  await PackageInfo.fromPlatform().then((packageInfo) {
    version = packageInfo.version;
  });
  return version;
}

Future<String?> getPackageName() async {
  String? packageName;
  await PackageInfo.fromPlatform().then((packageInfo) {
    packageName = packageInfo.packageName;
  });
  return packageName;
}

Future<String?> getBuildNumber() async {
  String? buildNumber;
  await PackageInfo.fromPlatform().then((packageInfo) {
    buildNumber = packageInfo.buildNumber;
  });
  return buildNumber;
}

int getRandomInt(int max) {
  return Random().nextInt(max) + 1;
}