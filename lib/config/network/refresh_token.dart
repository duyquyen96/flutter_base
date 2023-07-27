// import 'package:base_app/config/network/http.dart';
// import 'package:get/get.dart';

// import '../../data/models/auth/auth_model.dart';
// import '../constants/api_url.dart';
// import '../local/data_storage.dart';
// import '../router/Routes.dart';

// Future<AuthModel?> refreshToken({String? refreshToken}) async {
//   DataStorage _storage = DataStorage();
//   dynamic _storeAuth = _storage.getStorageByKey(TypeDataStorage.Auth);
//   AuthModel? _auth = _storeAuth != null ? AuthModel.fromJson(_storeAuth) : null;

//   try {
//     String? _refreshToken = _auth != null ? _auth.refreshToken : refreshToken;
//     if (_refreshToken == null) return null;
//     final body = {"refreshToken": _refreshToken};
//     final data = await http.post(
//       ApiUrl.REFRESH_TOKEN,
//       data: body,
//       isLoading: false,
//     );
//     data["refreshToken"] = _refreshToken;
//     _auth = AuthModel.fromJson(data);
//     _storage.saveAuth(_auth);
//     return _auth;
//   } catch (err) {
//     _storage.clearDataStorage();
//     Get.offAllNamed(Routes.SIGN_IN);
//     return null;
//   }
// }
