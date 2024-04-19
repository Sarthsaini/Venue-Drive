// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'dart:convert' as convert;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:venue_drive/login.dart';

// // ******BUILD********//
// const appTenant = String.fromEnvironment('TENANT', defaultValue: 'prod');

// // ******Paths********//
// var webPath = "https://stormboard.com";
// var baseDomain = "https://sushmadev.nmf.im";
var baseDomain = "https://event-backend.isdemo.in";

var baseUrl = "$baseDomain/api/v1";

// // ******Default Stormboard Colors********//
const primaryColor = Color(0xFFFFFFFF);
const textColor = Color(0xFF000000);
const iconColor = Color(0xFF000000);
const colorLocalTheme = Color(0xFFFFF2ED);
const colorLocalGrey = Color(0xFF6D6E70);
const colorLocalLightBlue = Color(0xFF68C0E3);
const colorLocalDarkBlue = Color(0xFF3789A4);
const colorLocalDarkestBlue = Color(0xFF0B325C);
const colorLocalLightGrey = Color(0xFF8D8F91);
const colorLocalVeryLightGrey = Color(0xFFB3B3B3);
const colorLocalDarkGrey = Color(0xFF9D9D9D);
const colorLocalBackgroundLightGrey = Color(0xFFF2F2F2);
const colorLocalCyan = Color(0xFF35F0F1);
const colorLocalRoyalBlue = Color(0xFF358DF1);
const colorLocalCobaltBlue = Color(0xFF3357E7);
const colorLocalGreen = Color(0xFF33E7B5);
const colorLocalRed = Color(0xFFEB7C63);
const colorLocalOrange = Color(0xFFF39C12);
const colorLocalLightRed = Color(0xFFFFE7E1);
const colorLocalPink = Color(0xFFEA3C75);
const cardBackgroundColor = Color(0xFFf2f4f7);
const placeholderColor = colorLocalGrey;

// // ******Color Code********//
const appBackgroundColor = Color(0xFFFFFFFF);
const appThemeColor1 = colorLocalTheme;
// final appThemeColor1Light = Color(0xFFE0F6FF);
// final buttonBorderColor = colorStormboardVeryLightGrey;
const labelColor = colorLocalGrey;

// final placeholderColor = colorStormboardGrey;
// final colorCancelButton = colorStormboardRed;
// final colorStormboardShadow = Color(0xFFD6D6D6);
// final colorStormboardTile = Color(0xFF9D9D9D);
// final colorStormboardTileSelected = Color(0xFF0B325C);
// final colorStormboardTileDropShadow = Color(0xFFAAAAAA);
// final colorStormboardMyVotes = Color(0xFF747474);
// final colorStormboardStarFill = Color(0xFFEFF351);
// final colorStormboardOnline = Color(0xFF00D181);

// final String helpLink = "https://help.stormboard.com/mobile-and-tablet-apps";
// final String privacyPolicyLink = "https://stormboard.com/legal/privacy-policy";
// final String termsLink = "https://stormboard.com/legal/terms-of-service";
// final String linkedinRedirectUrl = 'https://stormboard.com/auth/index';
// final String linkedinClientId = '78qm7wcygn43gk';
// final String linkedinClientSecret = 'e79PpdY9wtvwVdmB';

// // ****** Google ********//
// const String GOOGLE_API_KEY = 'AIzaSyCy7X-4J9QGg4J05THqY_0wlR50bWqbxpA';

// ****** Fonts ********//
const globalFont = "Quicksand";

double globalFontSize = 22.0;
var globalFontWeight = FontWeight.w800;

// Constants
const methodLogin = "login";
const methodSignup = "signup";
const methodGetMessagesList = "getMessages";
const methodPushMessage = "pushMessage";

const kDataLoginUser = "loginuser";
const kDataData = "data";
const kDataID = "id";
const kDataName = "name";
const kDataMobileNo = "mobileno";
const kDataCreatedDate = "createddate";
const kDataCreated = "created";
const kDataLastLoginDate = "lastlogindate";
const kDataCode = "code";
const kDataError = "error";
const kDataErrors = "errors";
const kDataSuccess = "success";
const kDataAPS = "aps";
const kDataMessage = "msg";
const kDataMessages = "messages";
const kDataNotification = "notification";
const kDataNotifications = "notifications";
const kDataPayload = "payload";
const kDataBody = "body";
const kDataAlert = "alert";
const kDataSender = "sender";
const kDatacreatedDate = "createdDate";
const kDataTime = "time";
const kDataDate = "date";
const kDataDeviceToken = "devicetoken";
const kDataUser = "user";
const kDataUsers = "Users";
const kDatausers = "users";
const kDataToken = "token";
const kDataDashboard = "dashboard";
const kDataPhone = "phone";
const kDataPhoneNumber = "phone_number";
const kDataCountry = "country";
const kDataEmail = "email";
const kDataPassword = "password";
const kDataFirstname = "firstname";
const kDataLastname = "lastname";
const kDataStartDate = "start_date";
const kDataDueDate = "due_date";
const kDataDescription = "description";
const kDataMonth = "month";
const kDataYear = "year";
const kDataCountries = "countries";
const kDataTitle = "title";
const kDataFullName = "fullname";
const kDataStates = "states";
const kDataCities = "cities";
const kDataAddress = "address";
const kDataMobile = "mobile";
const kDataAvatar = "avatar";
const kDataOtpCode = "otpCode";
const kDataStatus = "status";
const kDataStatusCode = "status_code";
const kDataOtp = "otp";
const kDataIsAdmin = "is_admin";
const kDataRemembered = "remembered";
const kDataHex = "hex";
const kDataKey = "key";
const kDataLat = "lat";
const kDataLon = "lon";
const kDataResult = "result";
const kDataImageUrl = "path";
const kDataWbi = "wbi";
const kDataUserProfile = "userprofile";
const kDataUsername = "username";
const kDataUserImg = "userimg";
const kDataWikImages = "wikimages";
const kDataIndex = 0;
const kDataMsg = "msg";
const kDataRoleId = "role_id";
const kDataCategory = "category";
const kDataValidationMsg = "Please enter all fields";

// ************************************Image Icons************************
const iconPendingTasks = "assets/images/pending-task.png";
const iconFirstAppointment = "assets/images/first-appointment.png";
const iconPendingDues = "assets/images/pending-dues.png";
const iconDeSnagging = "assets/images/de-snagging.png";
const iconSecondAppointment = "assets/images/second-appointment.png";
const iconUpdateCop = "assets/images/update-cop.png";
const iconFeedback = "assets/images/feedback.png";
const iconHandover = "assets/images/key-handover.png";
const iconCreateOOP = "assets/images/create-oop.png";
const iconFinalDeSnagging = "assets/images/final-desnagging.png";
const iconTargetSetting = "assets/images/settings.png";
const iconProject = "assets/images/project.png";
const imageQuality = 50;
const maxHeightWidth = 500.0;

// ************************************Navigation Samples************************
// Source: https://pub.dev/packages/page_transition

// Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: DetailScreen()));

// Navigator.push(context, PageTransition(type: PageTransitionType.leftToRight, child: DetailScreen()));

// Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft, child: DetailScreen()));

// Navigator.push(context, PageTransition(type: PageTransitionType.upToDown, child: DetailScreen()));

// Navigator.push(context, PageTransition(type: PageTransitionType.downToUp, child: DetailScreen()));

// Navigator.push(context, PageTransition(type: PageTransitionType.scale, alignment: Alignment.bottomCenter, child: DetailScreen()));

// Navigator.push(context, PageTransition(type: PageTransitionType.size, alignment: Alignment.bottomCenter, child: DetailScreen()));

// Navigator.push(context, PageTransition(type: PageTransitionType.rotate, duration: Duration(second: 1), child: DetailScreen()));

// Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeftWithFade, child: DetailScreen()));

// Navigator.push(context, PageTransition(type: PageTransitionType.leftToRightWithFade, child: DetailScreen()));

// */

SetHomePage(int index, String screenName) async {
  // ignore: unused_local_variable
  Widget screen;

  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          tabBarTheme: const TabBarTheme(
              labelColor: appThemeColor1, unselectedLabelColor: Colors.grey),
          fontFamily: globalFont,
          buttonTheme: ButtonThemeData(
              buttonColor: appThemeColor1,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              textTheme: ButtonTextTheme.accent,
              height: 50),
          primaryTextTheme: TextTheme(
            bodyText1: const TextStyle(fontSize: 18.0),
            bodyText2: const TextStyle(fontSize: 18.0),
            headline1: const TextStyle(fontSize: 18.0),
            headline2: const TextStyle(fontSize: 18.0),
            headline3: const TextStyle(fontSize: 18.0),
            headline4: const TextStyle(fontSize: 18.0),
            headline5: const TextStyle(fontSize: 18.0),
            headline6: TextStyle(
              fontSize: globalFontSize,
              fontWeight: globalFontWeight,
              color: labelColor,
              fontFamily: globalFont,
            ),
            subtitle1: const TextStyle(fontSize: 25.0),
            subtitle2: const TextStyle(fontSize: 25.0),
            caption: const TextStyle(fontSize: 18.0),
            button: const TextStyle(fontSize: 18.0),
            overline: const TextStyle(fontSize: 18.0),
          ),
          appBarTheme: AppBarTheme(
            centerTitle: false,
            titleSpacing: 0,
            color: Colors.transparent,
            iconTheme: const IconThemeData(
              color: Colors.black, //change your color here
            ),
            titleTextStyle: TextStyle(
              fontSize: globalFontSize,
              fontWeight: globalFontWeight,
              color: labelColor,
              fontFamily: globalFont,
            ),
          )),
      home: LoginScreen()));
}

Color hexToColor(String code) {
  return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
}

/*
====================================================================================

Spin kit Source : https://flutterappdev.com/2019/01/29/a-collection-of-loading-indicators-animated-with-flutter/

====================================================================================
*/

void ShowLoader(BuildContext context) {
  SchedulerBinding.instance.addPostFrameCallback((_) => showDialog(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 50,
          child: const AbsorbPointer(
            absorbing: true,
            // child: Image.asset("images/loader.gif"),
            child: SpinKitRing(
              color: Color(0xFFE0F6FF),
              lineWidth: 5,
            ),
          ),
        );
      }));
}

void HideLoader(BuildContext context) {
  Navigator.pop(context);
}

// void ShowErrorMessage(String message, BuildContext context) {
//   showSnackBar(message, context, colorLocalRed, false);
// }

// void ShowInfoMessage(String message, BuildContext context) {
//   showSnackBar(message, context, colorLocalCobaltBlue, true);
// }

// void ShowSuccessMessage(String message, BuildContext context) {
//   showSnackBar(message, context, colorLocalGreen, false);
// }

// void ShowWarningMessage(String message, BuildContext context) {
//   showSnackBar(message, context, colorLocalOrange, true);
// }

// void showToastMessage(String type, String message, BuildContext context) {
//   switch (type) {
//     case "error":
//       ShowErrorMessage(message, context);
//       break;
//     case "success":
//       ShowSuccessMessage(message, context);
//       break;
//     case "warning":
//       ShowSuccessMessage(message, context);
//       break;
//     case "info":
//     default:
//       ShowInfoMessage(message, context);
//       break;
//   }
// }

// showToast(String message) {
//   Fluttertoast.showToast(
//       msg: message,
//       toastLength: Toast.LENGTH_SHORT,
//       gravity: ToastGravity.CENTER,
//       timeInSecForIosWeb: 1,
//       backgroundColor: Colors.grey,
//       textColor: Colors.white,
//       fontSize: 16.0);
// }

// void showSnackBar(
//     String message, BuildContext context, Color bgColor, bool isToast) {
//   final document = parser.parse(message);
//   final String parseMessage =
//       parser.parse(document.body?.text).documentElement!.text;

//   SchedulerBinding.instance.addPostFrameCallback(
//       (_) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//             behavior: SnackBarBehavior.floating,
//             margin: isToast
//                 ? EdgeInsets.fromLTRB(16, 5, 16, 80)
//                 : EdgeInsets.fromLTRB(16, 5, 16, 50),
//             duration: Duration(seconds: 2),
//             content: Text(
//               parseMessage,
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 16,
//                 fontWeight: FontWeight.w400,
//               ),
//             ),
//             backgroundColor: bgColor,
//           )));
// }

Future<bool> sharedPreferenceContainsKey(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  bool result = prefs.containsKey(key);
  return result;
}

void SetSharedPreference(String key, dynamic value) async {
  var str = convert.json.encode(value);
  SharedPreferences prefs = await SharedPreferences.getInstance();

  prefs.setString(key, str);
}

dynamic GetSharedPreference(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.getString(key) != null) {
    String? keyData = prefs.getString(key);
    dynamic obj = convert.jsonDecode(keyData!);
    return obj;
  }
}

void RemoveSharedPreference(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove(key);
}

BoxDecoration SetBackgroundImage(String image) {
  return BoxDecoration(
    image: DecorationImage(
      image: AssetImage(image),
      fit: BoxFit.cover,
    ),
  );
}

BoxDecoration setBoxDecoration(Color color) {
  return BoxDecoration(
    borderRadius: BorderRadius.circular(10.0),
    border: Border.all(color: appThemeColor1.withAlpha(50), width: 1),
    color: color,
  );
}

BoxDecoration setBoxDecorationForUpperCorners(Color color, Color shadowColor) {
  return BoxDecoration(
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30), topRight: Radius.circular(30)),
      color: color,
      boxShadow: []);
}

// setNavigationTransition(Widget targetWidget) {
//   return PageTransition(
//       duration: const Duration(milliseconds: 300),
//       type: PageTransitionType.rightToLeft,
//       child: targetWidget,
//       alignment: Alignment.centerLeft);
// }

InputDecoration setInputDecoration(
    String labelText,
    String hintText,
    Color fillColor,
    Color labelTextColor,
    Color borderColor,
    FocusNode myFocusNode) {
  return InputDecoration(
    labelStyle: TextStyle(
      color: myFocusNode.hasFocus ? colorLocalOrange : placeholderColor,
    ),
    hintStyle: const TextStyle(
      color: placeholderColor,
    ),
    errorStyle: const TextStyle(color: Colors.red),
    labelText: labelText,
    hintText: hintText,
    focusColor: myFocusNode.hasFocus ? colorLocalOrange : Colors.black,
    focusedErrorBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: colorLocalOrange, width: 1),
        borderRadius: BorderRadius.all(
          Radius.circular(5.0),
        )),
    enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: colorLocalVeryLightGrey, width: 1),
        borderRadius: BorderRadius.all(
          Radius.circular(5.0),
        )),
    disabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: colorLocalVeryLightGrey, width: 1),
        borderRadius: BorderRadius.all(
          Radius.circular(5.0),
        )),
    focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: colorLocalOrange, width: 1),
        borderRadius: BorderRadius.all(
          Radius.circular(5.0),
        )),
    errorBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: colorLocalVeryLightGrey, width: 1),
        borderRadius: BorderRadius.all(
          Radius.circular(5.0),
        )),
  );
}

BoxDecoration containerBgStyle() {
  return const BoxDecoration(
      color: cardBackgroundColor,
      borderRadius: BorderRadius.all(Radius.circular(10)));
}

TextStyle textStyleRegular() {
  return const TextStyle(fontSize: 15, color: textColor);
}

TextStyle textStyleSmall() {
  return const TextStyle(fontSize: 13, color: Colors.grey);
}

TextStyle textStyleBold({color = textColor, size = 18.0}) {
  return TextStyle(fontSize: size, color: color, fontWeight: FontWeight.w500);
}

TextStyle textStyleExtraBig() {
  return const TextStyle(
      fontSize: 20, color: textColor, fontWeight: FontWeight.w500);
}

// void navigateBasedOnRoleId(context, String roleId) {
//   switch (roleId) {
//     case "1":
//       Navigator.pushAndRemoveUntil(
//           context,
//           MaterialPageRoute(builder: (context) => const TLDashboard()),
//           (route) => false);
//       break;
//     case "2":
//       Navigator.pushAndRemoveUntil(
//           context,
//           MaterialPageRoute(builder: (context) => const CIVILDashboard()),
//           (route) => false);
//       break;
//     case "3":
//       Navigator.pushAndRemoveUntil(
//           context,
//           MaterialPageRoute(builder: (context) => const CRMDashboard()),
//           (route) => false);
//       break;
//     case "4":
//       Navigator.pushAndRemoveUntil(
//           context,
//           MaterialPageRoute(builder: (context) => const FMDashboard()),
//           (route) => false);
//       break;
//     case "6":
//       Navigator.pushAndRemoveUntil(
//           context,
//           MaterialPageRoute(builder: (context) => const TLDashboard()),
//           (route) => false);
//       break;
//     case "7":
//       Navigator.pushAndRemoveUntil(
//           context,
//           MaterialPageRoute(builder: (context) => const OPDashboard()),
//           (route) => false);
//       break;
//   }
// }

showDialogPopUp(BuildContext context, String heading, String title) {
  return showDialog<bool>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Color.fromARGB(153, 255, 255, 255),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            // shape: ,
            content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Container(
                  height: 150,
                  child: Column(
                    //crossAxisAlignment: CrossAxisAlignment.stretch,
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Center(
                          child: Text(
                        "$heading",
                        style: const TextStyle(
                            color: textColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 20),
                      )),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "$title",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 30),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          // Expanded(
                          //   child: RaisedButton(
                          //     onPressed: () {
                          //       Navigator.of(context).pop(false);
                          //     },
                          //     textColor: Colors.white,
                          //     color: Colors.green,
                          //     shape: RoundedRectangleBorder(
                          //         borderRadius:
                          //             BorderRadius.all(Radius.circular(6.0))),
                          //     padding: const EdgeInsets.all(0.0),
                          //     child: Container(
                          //       decoration: const BoxDecoration(),
                          //       padding: const EdgeInsets.all(10.0),
                          //       child: const Text('No',
                          //           style: TextStyle(fontSize: 18)),
                          //     ),
                          //   ),
                          // ),
                          // const SizedBox(
                          //   width: 20,
                          // ),
                          // Expanded(
                          //   child: RaisedButton(
                          //     onPressed: () {
                          //       RemoveSharedPreference(kDataLoginUser);
                          //       Navigator.pushAndRemoveUntil(
                          //           context,
                          //           MaterialPageRoute(
                          //               builder: (context) =>
                          //                   const LoginScreen()),
                          //           (route) => false);
                          //     },
                          //     textColor: Colors.white,
                          //     color: Colors.red,
                          //     shape: RoundedRectangleBorder(
                          //         borderRadius:
                          //             BorderRadius.all(Radius.circular(6.0))),
                          //     padding: const EdgeInsets.all(0.0),
                          //     child: Container(
                          //       decoration: const BoxDecoration(),
                          //       padding: const EdgeInsets.all(10.0),
                          //       child: const Text('Yes',
                          //           style: TextStyle(fontSize: 18)),
                          //     ),
                          //   ),
                          //   /*child: diamondButton(context,"Yes",route:removePreference ),*/
                          // ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      );
}

Future<void> showInfoPopup(context, title, subtitle, action) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Color.fromARGB(153, 255, 255, 255),
        title: const Text(
          'DeSnag Date',
          textAlign: TextAlign.center,
        ),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(subtitle,
                  style: textStyleBold(size: 18.0),
                  textAlign: TextAlign.center),
            ],
          ),
        ),
        actions: <Widget>[
          Center(
            child: TextButton(
              child: const Text('Ok'),
              onPressed: action,
            ),
          ),
        ],
      );
    },
  );
}

Future<void> showConfirmationPopup(context, screen) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text(
          'Alert',
          textAlign: TextAlign.center,
        ),
        backgroundColor: Color.fromARGB(153, 255, 255, 255),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text("Submitted Successfully!",
                  style: textStyleBold(size: 18.0),
                  textAlign: TextAlign.center),
            ],
          ),
        ),
        actions: <Widget>[
          Center(
            child: TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => screen),
                    (route) => false);
              },
            ),
          ),
        ],
      );
    },
  );
}

int daysInMonth(DateTime date) {
  var firstDayThisMonth = DateTime(date.year, date.month, date.day);
  var firstDayNextMonth = new DateTime(firstDayThisMonth.year,
      firstDayThisMonth.month + 1, firstDayThisMonth.day);
  return firstDayNextMonth.difference(firstDayThisMonth).inDays;
}

class Stages {
  static const String firstAppointment = "3";
  static const String secondAppointment = "9";
  static const String pendingDues = "5";
  static const String pendingTasks = "6";
  static const String finalDeSnagging = "7";
  static const String deSnaggingDateChanged = "8";
  static const String updateCOP = "11";
  static const String handoverAppointment = "12";
  static const String keyHandoverDone = "12";
}
