import 'package:get/get_utils/src/get_utils/get_utils.dart';

bool isValidEmail(String email) {
  return GetUtils.isEmail(email);
}

bool paymentChecker(String epochTimeInSeconds) {
  if (epochTimeInSeconds == "") {
    return false;
  }

  int epochTimeInSeconds1 = int.parse(epochTimeInSeconds);

  DateTime dateTimeFromEpoch =
      DateTime.fromMillisecondsSinceEpoch(epochTimeInSeconds1 * 1000);

  // Get current DateTime
  DateTime currentDateTime = DateTime.now();

  // Compare
  return dateTimeFromEpoch.isAfter(currentDateTime);
}
