import 'package:dio/dio.dart';
import 'package:flower_app/core/app/data/models/product_response.dart';
import 'package:flower_app/core/app/data/models/response/get_current_user_data_response_dto.dart';
import 'package:flower_app/core/error_handling/base_response_result_dto.dart';
import 'package:flower_app/features/address/data/models/address_request_dto.dart';
import 'package:flower_app/features/address/data/models/address_response_dto.dart';
import 'package:flower_app/features/auth/data/models/requests/change_password_request.dart';
import 'package:flower_app/features/auth/data/models/requests/reset_password_request.dart';
import 'package:flower_app/features/auth/data/models/requests/send_reset_password_code_request.dart';
import 'package:flower_app/features/auth/data/models/requests/verify_reset_code_request.dart';
import 'package:flower_app/features/auth/data/models/response/change_password_response.dart';
import 'package:flower_app/features/auth/data/models/response/reset_password_response.dart';
import 'package:flower_app/features/auth/data/models/response/send_reset_password_code_response.dart';
import 'package:flower_app/features/auth/data/models/response/verify_reset_code_response.dart';
import 'package:flower_app/features/auth/data/models_dto/login/login_request.dart';
import 'package:flower_app/features/auth/data/models_dto/login/login_response_dto.dart';
import 'package:flower_app/features/auth/data/models_dto/logout/logout_response_dto.dart';
import 'package:flower_app/features/categories/data/models/categories_response.dart';
import 'package:flower_app/features/checkout/data/models/request/check_out_order_request.dart';
import 'package:flower_app/features/checkout/data/models/response/check_out_cash_response_dto.dart';
import 'package:flower_app/features/checkout/data/models/response/check_out_order_response.dart';
import 'package:flower_app/features/checkout/data/models/response/user_addresses_response_dto.dart';
import 'package:flower_app/features/home/data/models/best_seller_response.dart';
import 'package:flower_app/features/home/data/models/home_response_dto.dart';
import 'package:flower_app/features/orders/data/models/cart_request_dto.dart';
import 'package:flower_app/features/orders/data/models/order_response_dto.dart';
import 'package:flower_app/features/profile/data/models/edit_profile_request.dart';
import 'package:flower_app/features/profile/data/models/get_notifications_response_dto.dart';
import 'package:flower_app/features/profile/data/models/get_user_data_response.dart';
import 'package:flower_app/features/profile/data/models/upload_photo_response.dart';
import 'package:flower_app/features/saved_orders/data/models/response/saved_order_response.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../constants/end_points.dart';
import 'models/requests/user_request.dart';
import 'models/response/signup_response.dart';

part 'api_client.g.dart';

@RestApi()
abstract class ApiClient {
  @factoryMethod
  factory ApiClient(Dio dio, {String? baseUrl}) = _ApiClient;

  @POST(EndPoints.login)
  Future<LoginResponseDto> login({@Body() required LoginRequest loginRequest});

  @POST(EndPoints.signUpEndpoint)
  Future<SignupResponse> signUp(@Body() UserSignupRequest userRequest);

  @POST(EndPoints.forgetPassword)
  Future<SendResetPasswordCodeResponse> sendResetPasswordCode({
    @Body() required SendResetPasswordCodeRequest sendResetPasswordCodeRequest,
  });

  @POST(EndPoints.verifyResetCode)
  Future<VerifyResetCodeResponse> verifyResetPasswordCode({
    @Body() required VerifyResetCodeRequest verifyResetCodeRequest,
  });

  @PUT(EndPoints.resetPassword)
  Future<ResetPasswordResponse> resetPassword({
    @Body() required ResetPasswordRequest resetPasswordRequest,
  });

  @GET(EndPoints.profileData)
  Future<GetCurrentUserDataResponseDto> getCurrentUserData();

  @GET(EndPoints.bestSeller)
  Future<BestSellerResponse> getBestSeller();

  @GET(EndPoints.products)
  Future<ProductResponse> getProducts({
    @Query("occasion") String? occasionId,
    @Query("category") String? categoryId,
    @Query("keyword") String? keyword,
    @Query("sort") String? sort,
  });

  @GET(EndPoints.categories)
  Future<CategoriesResponse> getCategories();

  @GET(EndPoints.home)
  Future<HomeResponseDto> fetchHomeData();

  @GET(EndPoints.logout)
  Future<LogoutResponseDto> logout();

  //Cart [Orders]
  @POST(EndPoints.cart)
  Future<CartResponseDto> addProductToCart(
    @Body() CartRequestDto cartRequestDto,
  );

  @DELETE(EndPoints.deleteProductFromCard)
  Future<CartResponseDto> removeProductFromCart(@Path() String id);

  @DELETE(EndPoints.cart)
  Future<SuccessResponseDto> clearCart();

  @GET(EndPoints.cart)
  Future<CartResponseDto> getLoggedUserCart();

  @PUT(EndPoints.updateProductQuantity)
  Future<CartResponseDto> updateProductQuantity(
    @Path() String id,
    @Body() Map<String, int> quantity,
  );

  @PATCH(EndPoints.changePassword)
  Future<ChangePasswordResponse> changePassword(
    @Body() ChangePasswordRequest changePasswordRequest,
  );

  @GET(EndPoints.profileData)
  Future<GetUserDataResponse> getProfileData();

  @PUT(EndPoints.editProfile)
  Future<GetUserDataResponse> editProfile({
    @Body() required EditProfileRequest editProfileRequest,
  });

  @PUT(EndPoints.uploadPhoto)
  @MultiPart()
  Future<UploadPhotoResponse> uploadPhoto(
    @Part(name: 'photo') MultipartFile photo,
  );

  @POST(EndPoints.checkoutCreditCard)
  Future<CheckOutCreditCardResponseDto> checkoutCreditCard(
    @Body() CheckOutOrderRequest checkOutOrderRequest,
  );

  @POST(EndPoints.checkoutCash)
  Future<CheckOutCashResponseDto> checkoutCash(
    @Body() CheckOutOrderRequest checkOutOrderRequest,
  );

  @GET(EndPoints.getUserAddresses)
  Future<UserAddressesResponseDto> getUserAddresses();

  //||||||||||||||||||||||||||||Address||||||||||||||||||||||||
  @PATCH(EndPoints.addAddress)
  Future<AddressResponseDto> addAddress(@Body() AddressRequestDto addressDto);

  @PATCH(EndPoints.updateAddress)
  Future<AddressResponseDto> updateAddress(
    @Body() AddressRequestDto addressDto,
    @Path() String id,
  );

  @DELETE(EndPoints.deleteAddress)
  Future<AddressResponseDto> deleteAddress(@Path() String id);

  @GET(EndPoints.getLoggedUserAddress)
  Future<AddressResponseDto> getLoggedUserAddress();

  @GET(EndPoints.orders)
  Future<SavedOrderResponse> getSavedOrders();

  @GET(EndPoints.notifications)
  Future<GetNotificationsResponseDTO> getNotifications();
}
