//url endpoint
class ApiEndPoints {

  //login
  static const String userRegister = 'users/create';
  static const String userlogin = 'users/login';
  static const String quotesFetching = 'quotes/getquotes';
  static const String fontFamilyFetching = 'quotes/fontfamily';
  static const String fontColorFetching = 'quotes/fontcolor';
  static const String categoryFetching = 'quotes/category';
  static const String fetchusercategory = 'quotes/fetchusercategory';
  static const String selectusercategory = 'quotes/selectusercategory';


  static const String getImageCategories = 'quotes/imagecategories';
  static const String getImageSubCategories = 'quotes/imagesubcategories';
  static const String getImageWithId = 'quotes/imagewithId';
  static const String sendBackgroundSettings = 'quotes/sendbackgroundsettings';
  static const String getBackgroundSettingsUser = 'quotes/getbackgroundsigneduser';
  static const String sendEmailForForgotPassword = 'users/forgotpassword';
  static const String sendTokenForForgotPassword = 'users/sendresettoken';
  static const String tokenChangePassword = 'users/tokenchangepassword';
 
}
