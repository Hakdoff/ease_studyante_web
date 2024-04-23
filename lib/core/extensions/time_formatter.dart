import 'package:intl/intl.dart';

extension StrToTimeFormat on String {
  String parseStrToTime() {
    DateTime time = DateFormat("HH:mm:ss").parse(this);
    String formattedTime = DateFormat('ha').format(time);

    return formattedTime;
  }

  String parseStrToDate() {
    try {
      DateFormat dateFormat = DateFormat("MM/dd/yyyy");
      String formattedTime = dateFormat.format(DateTime.parse(this));

      return formattedTime;
    } catch (e) {
      return '';
    }
  }
}
