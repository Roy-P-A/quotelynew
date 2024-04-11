import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../dtos/api_dtos/categories_screen/fetchcategory/fetch_category.dart';
import '../dtos/api_dtos/categories_screen/fetchusercategory/fetchusercategory.dart';
import '../dtos/api_dtos/categories_screen/selectusercategory/selectusercategory.dart';
import '../dtos/api_dtos/dashboard_screen/backgroundsettingsuser/backgroundsettingsuser.dart';
import '../dtos/api_dtos/dashboard_screen/quotes_fetching/quotes_fetching.dart';
import '../dtos/api_dtos/forgotpassword/changepassbyforgot/changepassbyforgot.dart';
import '../dtos/api_dtos/forgotpassword/sendemail/sendemail.dart';
import '../dtos/api_dtos/forgotpassword/sendresettoken/sendresettoken.dart';
import '../dtos/api_dtos/login/login.dart';
import '../dtos/api_dtos/perslisting/getcategoryimages/getcategoryimages.dart';
import '../dtos/api_dtos/perslistingsection/getimagesubcategories/getimagesubcategories.dart';
import '../dtos/api_dtos/perssubsection/fontFamilyfetching/fetchfontfamily.dart';
import '../dtos/api_dtos/perssubsection/fontcolorfetching/fetchfontcolor.dart';
import '../dtos/api_dtos/perssubsection/getimagewithid/getimagewithid.dart';
import '../dtos/api_dtos/perssubsection/sendbackgroundsettings/sendbackgroundsettings.dart';
import '../dtos/api_dtos/signup/signup.dart';
import '../managers/api/api.dart';

abstract class ApiRepository extends GetxController {
  static ApiRepository get to => Get.find();

  Future<SignUpResponse> signup({required SignUpRequest request});
  Future<LoginResponse> login({required LoginRequest request});

  Future<QuotesFetchingResponse> quotesFetching(
      {required QuotesFetchingRequest request});

  Future<FetchFontFamilyRespnse> fetchFontFamily(
      {required FetchFontFamilyRequest request});

  Future<FetchFontColorRespnse> fetchFontColor(
      {required FetchFontColorRequest request});

  Future<FetchCategoryResponse> fetchCategory(
      {required FetchCategoryRequest request});

  Future<FetchUserCategoryResponse> fetchUserCategory(
      {required FetchUserCategoryRequest request});

  Future<SelectedUserCategoryResponse> selectUserCategory(
      {required SelectUserCategoryRequest request});

  Future<GetCategoryImagesResponse> getImageCategories(
      {required GetCategoryImagesRequest request});

  Future<GetImagesSubCategoryResponse> getImageSubCategories(
      {required GetImagesSubCategoryRequest request});

  Future<GetImageWithIdResponse> getImageWithId(
      {required GetImageWithIdRequest request});

  Future<SendBackgroundSettingsResponse> sendBackgroundSettings(
      {required SendBackgroundSettingsRequest request}); 

  Future<BackgroundSettingsUserResponse> getBackgroundSettingsUser(
      {required BackgroundSettingsUserRequest request}); 

  Future<SendEmailResponse> sendEmailForForgotPassword(
      {required SendEmailRequest request});  

  Future<SendResetTokenResponse> sendResetTokenForgotPassword(
      {required SendResetTokenRequest request});

  Future<ChangePasswordForgotResponse> tokenChangePassword(
      {required ChangePasswordForgotRequest request});                      
}

class ApiRepositoryImpl extends GetxController implements ApiRepository {
  final _helper = ApiBaseHelper();

  final Map<String, String> _headersWithoutToken = {
    'Content-Type': 'application/json'
  };

  @override
  Future<SignUpResponse> signup({required SignUpRequest request}) async {
    final response = await _helper.postWithBody(
        endpoint: ApiEndPoints.userRegister,
        body: request.toBody(),
        params: {},
        headers: request.toHeaders());
    debugPrint("response $response");
    return SignUpResponse.fromJson(response);
  }

  @override
  Future<LoginResponse> login({required LoginRequest request}) async {
    final response = await _helper.postWithBody(
        endpoint: ApiEndPoints.userlogin,
        body: request.toBody(),
        params: {},
        headers: request.toHeaders());
    debugPrint("response $response");
    return LoginResponse.fromJson(response);
  }

  @override
  Future<QuotesFetchingResponse> quotesFetching(
      {required QuotesFetchingRequest request}) async {
    final response = await _helper.postWithBody(
        endpoint: ApiEndPoints.quotesFetching,
        params: request.toMap(),
        body: request.toBody(),
        headers: request.toHeaders());
    debugPrint("fetch category- $response");

    return QuotesFetchingResponse.fromJson(response);
  }

  @override
  Future<FetchFontFamilyRespnse> fetchFontFamily(
      {required FetchFontFamilyRequest request}) async {
    final response = await _helper.get(
        endpoint: ApiEndPoints.fontFamilyFetching,
        params: request.toMap(),
        headers: request.toHeaders());
    debugPrint("fetch category- $response");

    return FetchFontFamilyRespnse.fromJson(response);
  }

  @override
  Future<FetchFontColorRespnse> fetchFontColor(
      {required FetchFontColorRequest request}) async {
    final response = await _helper.get(
        endpoint: ApiEndPoints.fontColorFetching,
        params: request.toMap(),
        headers: request.toHeaders());
    debugPrint("fetch category- $response");

    return FetchFontColorRespnse.fromJson(response);
  }

  @override
  Future<FetchCategoryResponse> fetchCategory(
      {required FetchCategoryRequest request}) async {
    final response = await _helper.get(
        endpoint: ApiEndPoints.categoryFetching,
        params: request.toMap(),
        headers: request.toHeaders());
    debugPrint("fetch category- $response");

    return FetchCategoryResponse.fromJson(response);
  }

  @override
  Future<FetchUserCategoryResponse> fetchUserCategory(
      {required FetchUserCategoryRequest request}) async {
    final response = await _helper.getWithId(
        endpoint: ApiEndPoints.fetchusercategory,
        id: request.toId(),
        headers: request.toHeaders());
    debugPrint("fetch category- $response");

    return FetchUserCategoryResponse.fromJson(response);
  }

  @override
  Future<SelectedUserCategoryResponse> selectUserCategory(
      {required SelectUserCategoryRequest request}) async {
    final response = await _helper.postWithBody(
        endpoint: ApiEndPoints.selectusercategory,
        body: request.toBody(),
        params: {},
        headers: request.toHeaders());
    debugPrint("response $response");
    return SelectedUserCategoryResponse.fromJson(response);
  }
  //

  @override
  Future<GetCategoryImagesResponse> getImageCategories(
      {required GetCategoryImagesRequest request}) async {
    final response = await _helper.get(
        endpoint: ApiEndPoints.getImageCategories,
        params: request.toMap(),
        headers: _headersWithoutToken);
    debugPrint("fetch category- $response");

    return GetCategoryImagesResponse.fromJson(response);
  }

  @override
  Future<GetImagesSubCategoryResponse> getImageSubCategories(
      {required GetImagesSubCategoryRequest request}) async {
    final response = await _helper.get(
        endpoint: ApiEndPoints.getImageSubCategories,
        params: request.toMap(),
        headers: _headersWithoutToken);
    debugPrint("fetch category- $response");

    return GetImagesSubCategoryResponse.fromJson(response);
  }

  //
  @override
  Future<GetImageWithIdResponse> getImageWithId(
      {required GetImageWithIdRequest request}) async {
    final response = await _helper.get(
        endpoint: ApiEndPoints.getImageWithId,
        params: request.toMap(),
        headers: _headersWithoutToken);
    debugPrint("fetch category- $response");

    return GetImageWithIdResponse.fromJson(response);
  }


   @override
  Future<SendBackgroundSettingsResponse> sendBackgroundSettings(
      {required SendBackgroundSettingsRequest request}) async {
    final response = await _helper.postWithBody(
        endpoint: ApiEndPoints.sendBackgroundSettings,
        body: request.toBody(),
        params: {},
        headers: request.toHeaders());
    debugPrint("response $response");
    return SendBackgroundSettingsResponse.fromJson(response);
  }


  @override
  Future<BackgroundSettingsUserResponse> getBackgroundSettingsUser(
      {required BackgroundSettingsUserRequest request}) async {
    final response = await _helper.getWithId(
        endpoint: ApiEndPoints.getBackgroundSettingsUser,
        id: request.toId(),
        headers: request.toHeaders());
    debugPrint("fetch category- $response");

    return BackgroundSettingsUserResponse.fromJson(response);
  }


   @override
  Future<SendEmailResponse> sendEmailForForgotPassword(
      {required SendEmailRequest request}) async {
    final response = await _helper.postWithBody(
        endpoint: ApiEndPoints.sendEmailForForgotPassword,
        body: request.toBody(),
        params: {},
        headers: request.toHeaders());
    debugPrint("response $response");
    return SendEmailResponse.fromJson(response);
  }

  @override
  Future<SendResetTokenResponse> sendResetTokenForgotPassword(
      {required SendResetTokenRequest request}) async {
    final response = await _helper.postWithBody(
        endpoint: ApiEndPoints.sendTokenForForgotPassword,
        body: request.toBody(),
        params: {},
        headers: request.toHeaders());
    debugPrint("response $response");
    return SendResetTokenResponse.fromJson(response);
  }

    @override
  Future<ChangePasswordForgotResponse> tokenChangePassword(
      {required ChangePasswordForgotRequest request}) async {
    final response = await _helper.postWithBody(
        endpoint: ApiEndPoints.tokenChangePassword,
        body: request.toBody(),
        params: {},
        headers: request.toHeaders());
    debugPrint("response $response");
    return ChangePasswordForgotResponse.fromJson(response);
  }

  //
}
