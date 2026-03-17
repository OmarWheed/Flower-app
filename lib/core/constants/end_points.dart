class EndPoints {
  //>>>>>>>>>keys for api<<<<<<<<<<
  static const String quantity = 'quantity';
  static const String signUpEndpoint = "auth/signup";
  static const String forgetPassword = 'auth/forgotPassword';
  static const String verifyResetCode = 'auth/verifyResetCode';
  static const String resetPassword = 'auth/resetPassword';
  static const String login = "auth/signin";
  static const String profileData = "auth/profile-data";
  static const String bestSeller = 'best-seller';
  static const String home = "home";
  static const String products = "products/";
  static const String categories = "categories";
  static const String changePassword = "auth/change-password";
  static const String logout = "auth/logout";
  static const String cart = "cart";
  static const String deleteProductFromCard = "cart/{id}";
  static const String updateProductQuantity = "cart/{id}";
  static const String checkoutCreditCard = "orders/checkout";
  static const String checkoutCash = "orders";
  static const String uploadPhoto = "auth/upload-photo";
  static const String editProfile = "auth/editProfile";
  static const String getUserAddresses = "addresses";
  static const String addAddress = "addresses";
  static const String updateAddress = "addresses/{id}";
  static const String deleteAddress = "addresses/{id}";
  static const String getLoggedUserAddress = "addresses";
  static const String notifications = "notifications/user";
  static const String orders = "orders";
  static const String callFirebaseServer =
      'https://fcm.googleapis.com/v1/projects/flower-app-8de14/messages:send';
}
