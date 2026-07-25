part of '_environments.dart';

class EndPoints {
  static const String baseUrl = Config.baseUrlProd;

  // Guards against a trailing slash in the configured base URL (e.g. an
  // ngrok tunnel URL) producing a double slash before the path.
  static String get apiV1 => '${_trimTrailingSlash(baseUrl)}/api/v1';

  /* ----------------------------- Auth endpoints ----------------------------- */
  static String get authRegister => '$apiV1/auth/register';
  static String get authVerifyOtp => '$apiV1/auth/verify-otp';
  static String get authResendOtp => '$apiV1/auth/resend-otp';
  static String get authLogin => '$apiV1/auth/login';
  static String get authRefresh => '$apiV1/auth/refresh';
  static String get authForgotPassword => '$apiV1/auth/forgot-password';
  static String get authVerifyResetOtp => '$apiV1/auth/verify-reset-otp';
  static String get authResetPassword => '$apiV1/auth/reset-password';
  static String get authMe => '$apiV1/auth/me';

  /* ----------------------------- Chat endpoints ----------------------------- */
  static String get chatMessages => '$apiV1/chat/messages';
  static String get chatConversations => '$apiV1/chat/conversations';
  static String chatConversationMessages(String id) =>
      '$apiV1/chat/conversations/$id/messages';
  static String chatMessageFeedback(String messageId) =>
      '$apiV1/chat/messages/$messageId/feedback';
  static String chatMessageReport(String messageId) =>
      '$apiV1/chat/messages/$messageId/report';
  static String get chatExpertContact => '$apiV1/chat/expert-contact';
  static String get chatAvatarSession => '$apiV1/chat/avatar-session';

  static String _trimTrailingSlash(String url) =>
      url.endsWith('/') ? url.substring(0, url.length - 1) : url;
}
