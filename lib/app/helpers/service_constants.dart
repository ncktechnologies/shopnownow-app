class Env {
  static late EnvState _env;

  static void setEnvironment(EnvState environment) {
    _env = environment;
  }

  static EnvState getEnvironment() {
    return _env;
  }
}

enum EnvState { test, production }

/// Base url here, for test and live
String baseUrl({int version = 1}) {
  return Env.getEnvironment() == EnvState.test
      ? "https://now.ncktech.com/api/v$version"
      : "https://api.learnafrica.ng/api/v$version";

}
