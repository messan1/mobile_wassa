import 'package:get/get.dart';
import 'package:ucolis/src/views/screens/OnboardingScreen/OnboardingScreen.dart';
import 'package:ucolis/src/views/screens/Search/SearchScreen.dart';
import 'package:ucolis/src/views/screens/choixDaddress/choixAdress.dart';
import 'package:ucolis/src/views/screens/choixDaddress/destination.dart';
import 'package:ucolis/src/views/screens/dashboard/dashboard.dart';
import 'package:ucolis/src/views/screens/dashboard/pages/ChooseType.dart';
import 'package:ucolis/src/views/screens/historic/historic.dart';
import 'package:ucolis/src/views/screens/historic/pages/courseDetail.dart';
import 'package:ucolis/src/views/screens/historic/pages/deliverInfo.dart';
import 'package:ucolis/src/views/screens/infoVehicule/infovehicule.dart';
import 'package:ucolis/src/views/screens/information/information.dart';
import 'package:ucolis/src/views/screens/information/pages/addDocument.dart';
import 'package:ucolis/src/views/screens/language/language.dart';
import 'package:ucolis/src/views/screens/login/login.dart';
import 'package:ucolis/src/views/screens/login/pages/resetPassword.dart';
import 'package:ucolis/src/views/screens/mapFromDeliver/mapFromDeliver.dart';
import 'package:ucolis/src/views/screens/mapFromUser/mapFromUser.dart';
import 'package:ucolis/src/views/screens/mapFromUser/pages/cancelDelivery.dart';
import 'package:ucolis/src/views/screens/mapFromUser/pages/successDelivery.dart';
import 'package:ucolis/src/views/screens/profile/profile.dart';
import 'package:ucolis/src/views/screens/promo/pages/addPromoCode.dart';
import 'package:ucolis/src/views/screens/promo/promo.dart';
import 'package:ucolis/src/views/screens/signup/pages/accountAccess.dart';
import 'package:ucolis/src/views/screens/signup/pages/verificationCode.dart';
import 'package:ucolis/src/views/screens/signup/signup.dart';
import 'package:ucolis/src/views/screens/support/pages/contact.dart';
import 'package:ucolis/src/views/screens/support/pages/faq.dart';
import 'package:ucolis/src/views/screens/support/pages/ticket.dart';
import 'package:ucolis/src/views/screens/support/support.dart';
import 'package:ucolis/src/views/screens/wallet/pages/recharge.dart';
import 'package:ucolis/src/views/screens/wallet/wallet.dart';

abstract class AppRoutes {
  static List<GetPage> get routes => [
        GetPage(name: '/Dashboard', page: () => Dashboard()),
        GetPage(
            name: '/choixAdress',
            page: () => ChoixAdress(),
            transition: Transition.downToUp),
        GetPage(
            name: '/destination',
            page: () => Destination(),
            transition: Transition.downToUp),
        GetPage(name: '/profile', page: () => Profile()),
        GetPage(name: '/historic', page: () => Historic()),
        GetPage(name: '/courseDetail', page: () => CourseDetail()),
        GetPage(name: '/deliverInfo', page: () => DeliverInfo()),
        GetPage(name: '/promo', page: () => Promo()),
        GetPage(name: '/addPromoCode', page: () => AddPromoCode()),
        GetPage(name: '/support', page: () => Support()),
        GetPage(name: '/faq', page: () => Faq()),
        GetPage(name: '/ticket', page: () => Ticket()),
        GetPage(name: '/contact', page: () => Contact()),
        GetPage(name: '/wallet', page: () => Wallet()),
        GetPage(name: '/recharge', page: () => Recharge()),
        GetPage(name: '/SearchScreen', page: () => SearchScreen()),
        GetPage(
            name: '/ChooseType',
            page: () => ChooseType(),
            transition: Transition.downToUp),
        GetPage(
            name: '/MapFromUser',
            page: () => MapFromUser(),
            transition: Transition.upToDown),
        GetPage(
            name: '/SuccessDelivery',
            page: () => SuccessDelivery(),
            transition: Transition.downToUp),
        GetPage(
            name: '/CancelDelivery',
            page: () => CancelDelivery(),
            transition: Transition.downToUp),
        GetPage(name: '/MapFromDeliver', page: () => MapFromDeliver()),
        GetPage(name: '/Language', page: () => Language()),
        GetPage(name: '/', page: () => Login()),
        GetPage(name: '/SignUp', page: () => SignUp()),
        GetPage(name: '/VerificationCode', page: () => VerificationCode()),
        GetPage(name: '/ResetPassword', page: () => ResetPassword()),
        GetPage(name: '/OnboardingScreen', page: () => OnboardingScreen()),
        GetPage(name: '/Information', page: () => Information()),
        GetPage(name: '/AddDocument', page: () => AddDocument()),
        GetPage(name: '/AccountAccess', page: () => AccountAccess()),
        GetPage(name: '/InfoVehicule', page: () => InfoVehicule()),
      ];
}
