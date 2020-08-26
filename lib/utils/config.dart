class ProjectConfig {
  static const String projectName = 'Base Project';

  static const bool useProd = true;

  static const String androidVersion = "2.2.3";
  static const String iosVersion = "2.2.3";
}

String baseUrl() {
  if (ProjectConfig.useProd == true) {
    return 'PROD_API_URL';
  } else {
    return "DEV_API_URL";
  }
}

String apiKey() {
  if (ProjectConfig.useProd == true) {
    return 'PROD_API_KEY';
  } else {
    return 'DEV_API_KEY';
  }
}

String firebaseTopic() {
  if (ProjectConfig.useProd == true) {
    return 'PROD_FIREBASE_TOPIC';
  } else {
    return 'DEV_FIREBASE_TOPIC';
  }
}
