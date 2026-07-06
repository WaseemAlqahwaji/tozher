class ApiConstants {
  static const String baseUrl = "http://localhost:3000/";
  static const String sections = "sections";
  static String levels(String sectionId) => "sections/$sectionId/levels";

  // auth
  static const String register = "api/auth/register";
  static const String login = "api/auth/login";
  static const String requestPasswordReset = "api/auth/request-password-reset";
  static const String confirmCode = "api/auth/email/confirm-code";
  static const String passwordReset = "api/auth/password-reset";
  static const String me = "api/auth/me";
  static const String refresh = "api/auth/refresh";
}

class ApiErrors {
  static const String badRequestError = "badRequestError";
  static const String noContent = "noContent";
  static const String forbiddenError = "forbiddenError";
  static const String unauthorizedError = "unauthorizedError";
  static const String notFoundError = "notFoundError";
  static const String conflictError = "conflictError";
  static const String internalServerError = "internalServerError";
  static const String unknownError = "unknownError";
  static const String timeoutError = "timeoutError";
  static const String defaultError = "defaultError";
  static const String cacheError = "cacheError";
  static const String noInternetError = "noInternetError";
  static const String loadingMessage = "loading_message";
  static const String retryAgainMessage = "retry_again_message";
  static const String ok = "Ok";
}
