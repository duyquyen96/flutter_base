// ignore_for_file: non_constant_identifier_names

String YMDToDMY(String ymd, String separatorFrom, String separatorTo) {
  final temp = ymd.split(separatorFrom);
  if (temp.length < 3) return '';
  return '${temp[2]}$separatorTo${temp[1]}$separatorTo${temp[0]}';
}

String HMSToHM(String hms) {
  final temp = hms.split(':');
  if (temp.length < 2) return '';
  return '${temp[0]}:${temp[1]}';
}

DateTime dateTimeStringToDateTime(
    {required String str, String dateSeparator = '-'}) {
  //2023-04-14T19:13:48.000000Z
  //2023-04-24 00:00:00
  String split = str.contains('T') ? 'T' : ' ';
  List<String> dateTimes = str.split(split);
  List<String> date = dateTimes[0].split(dateSeparator);
  List<String> time = dateTimes[1].split(':');
  int y = int.parse(date[0]);
  int m = int.parse(date[1]);
  int d = int.parse(date[2]);

  int h = int.parse(time[0]);
  int mi = int.parse(time[1]);
  int s = int.parse(time[2].substring(0, 2));

  return DateTime(y, m, d, h, mi, s);
}
