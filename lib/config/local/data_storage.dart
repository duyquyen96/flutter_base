import 'package:get_storage/get_storage.dart';

import '../../common/models/authentication/auth_model.dart';
import '../../common/models/reading_process.dart';
import '../../common/models/users/user_model.dart';

class DataStorage {
  final _storage = GetStorage();

  Future clearDataStorage() async {
    await _storage.remove(TypeDataStorage.Auth);
    await _storage.remove(TypeDataStorage.UserData);
    await _storage.remove(TypeDataStorage.ProcessReading);
    await _storage.remove(TypeDataStorage.ProcessReadingPdf);
  }

  dynamic getStorageByKey(String typeDataStorage) {
    return _storage.read(typeDataStorage);
  }

  dynamic setStorageByKey(String typeDataStorage, dynamic data) {
    _storage.write(typeDataStorage, data);
  }

  Future saveAuth(AuthModel authModel) async {
    await _storage.write(TypeDataStorage.Auth, authModel);
  }

  void saveLanguageCode(String code) {
    _storage.write(TypeDataStorage.LanguageCode, code);
  }

  void saveLanguage(Map<String, dynamic> data) {
    _storage.write(TypeDataStorage.Language, data);
  }

  void saveOnOffNotification(bool currentValue) {
    _storage.write(TypeDataStorage.OnOffNotification, currentValue);
  }

  void saveUserData(UserModel userModel) {
    _storage.write(TypeDataStorage.UserData, userModel);
  }

  AuthModel getAuth() {
    var data = _storage.read(TypeDataStorage.Auth);
    if (data is Map<String, dynamic>) {
      return AuthModel.fromJsonStorage(data);
    } else {
      return data;
    }
  }

  List<ReadingProcess> getReadingProcess() {
    var data = _storage.read(TypeDataStorage.ProcessReading);
    if (data is List<dynamic>) {
      if (data[0] is String)
        return data.map((e) => ReadingProcess.fromJson(e)).toList();
      return data as List<ReadingProcess>;
    } else {
      return [];
    }
  }

  int getReadingProcessPdf() {
    var data = _storage.read(TypeDataStorage.ProcessReadingPdf);
    return data ?? 0;
  }
}

mixin TypeDataStorage {
  static const Auth = "Auth";
  static const UserData = "UserData";
  static const OnOffNotification = "StatusNotification";
  static const LanguageCode = "LanguageCode";
  static const Language = "language";
  static const ProcessReading = "ProcessReading";
  static const ProcessReadingPdf = "ProcessReadingPdf";
}
