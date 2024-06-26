import 'package:get/get.dart';

import '../features/buypremium/buypremium_screen.dart';
import '../features/categories/categories_screen.dart';
import '../features/favourites/favourites.dart';
import '../features/forgotpassword/forgotpassword.dart';
import '../features/onboardfirst/onboardfirst_screen.dart';
import '../features/onboardfourth/onboardfourth_screen.dart';
import '../features/onboardsecond/onboardsecond_screen.dart';
import '../features/onboardseventh/onboardseventh.dart';
import '../features/onboardthird/onboardthird_screen.dart';
import '../features/perlistingsection/perlistingsection.dart';
import '../features/perslisting/perslisting.dart';
import '../features/perssubsection/perssubsection.dart';
import '../features/profile/profile_screen.dart';
import '../features/dashboard/dashboard.dart';
import '../features/general/general.dart';
import '../features/signin/sigin.dart';

import '../features/signup/signup.dart';
import '../features/splash/splash.dart';

List<GetPage> routes() => [
      GetPage(
          name: "/",
          page: () => SplashScreen(),
          transition: Transition.noTransition),
      // GetPage(
      //     name: "/",
      //     page: () =>  SplashScreen(),
      //     transition: Transition.noTransition),
      GetPage(
          name: "/splashscreen",
          page: () => const SplashScreen(),
          transition: Transition.cupertino),
      GetPage(
          name: "/signin",
          page: () => const SignInScreen(),
          transition: Transition.cupertino),
      GetPage(
          name: "/signup",
          page: () => const SignUpScreen(),
          transition: Transition.cupertino),
      GetPage(
          name: "/dashboard",
          page: () => const DashboardScreen(),
          transition: Transition.cupertino),
      GetPage(
          name: "/general",
          page: () => const GeneralScreen(),
          transition: Transition.cupertino),
      GetPage(
          name: "/profile",
          page: () => const ProfileScreen(),
          transition: Transition.downToUp),
      GetPage(
          name: "/perslisting",
          page: () => const PerslistingScreen(),
          transition: Transition.cupertino),
      GetPage(
          name: "/perslistingsection",
          page: () => const PerslistingSectionScreen(),
          transition: Transition.cupertino),
      GetPage(
          name: "/perslistingsub",
          page: () => const PersSubSectionScreen(),
          transition: Transition.cupertino),
      GetPage(
          name: "/categories",
          page: () => const CategoriesScreen(),
          transition: Transition.cupertino),
      GetPage(
          name: "/favorites",
          page: () => const FavouritesScreen(),
          transition: Transition.cupertino),
      GetPage(
          name: "/buypremium",
          page: () => const BuyPremiumScreen(),
          transition: Transition.cupertino),
      GetPage(
          name: "/forgotpassword",
          page: () => const ForgotPasswordScreen(),
          transition: Transition.cupertino),
      GetPage(
          name: "/onboardfirst",
          page: () => const OnboardfirstScreen(),
          transition: Transition.cupertino),
      GetPage(
          name: "/onboardsecond",
          page: () => const OnboardSecondScreen(),
          transition: Transition.cupertino),
      GetPage(
          name: "/onboardthird",
          page: () => const OnBoardThirdScreen(),
          transition: Transition.cupertino),
      GetPage(
          name: "/onboardfourth",
          page: () => const OnboardFourthScreen(),
          transition: Transition.cupertino),

      GetPage(
          name: "/onboardseventh",
          page: () => const OnBoardSeventhScreen(),
          transition: Transition.cupertino)
    ];
