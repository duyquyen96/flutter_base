import '/res/common_strings.dart';

class AppStrings extends CommonStrings {
  AppStrings();

  static const String appName = 'Á Đông';
  static const content_type = 'Content-Type';
  static const multipart_form_data = 'multipart/form-data';
  static const application_json = 'application/json';

  @override
  Map<String, Map<String, String>> onConfig() {
    return {'en_US': {}, 'vi_VN': {}};
  }
}
