class AppUrl {
  static const String liveBaseURL = "http://wekr9.mocklab.io";
  static const String localBaseURL = "http://10.0.2.2:4000/api/v1";

  static const String baseURL = liveBaseURL;
  static const String login = baseURL + "/login";
  static const String register = baseURL + "/registration";
  static const String forgotPassword = baseURL + "/forgot-password";

  static const String examList =
      "https://5f9c1f51856f4c00168c7512.mockapi.io/api/v1/exams/";

  static const String examListSheduled =
      "https://5f9c1f51856f4c00168c7512.mockapi.io/api/v1/users/1/exams/";

  static const String userList =
      "https://5f9c1f51856f4c00168c7512.mockapi.io/api/v1/users/";
}
