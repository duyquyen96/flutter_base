String soDem(int number) {
  String strNumber = number.toString(), str;
  int len = strNumber.length;
  if (len <= 3) {
    str = strNumber;
  } else if (len <= 6) {
    str = '${(number / 1000).toStringAsFixed(1)}k';
  } else if (len <= 9) {
    str = '${(number / 1000000).toStringAsFixed(1)}m';
  } else {
    str = '${(number / 1000000000).toStringAsFixed(1)}b';
  }

  return str.replaceAll('.', ',');
}
