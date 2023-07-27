// import 'package:get/get.dart';
// import 'package:sprint/common/routes/app_pages.dart';
// import 'package:sprint/common/utils/modal.dart';
// import 'package:sprint/features/dang_nhap_dang_ky/controllers/user_controller.dart';
// import 'package:sprint/widgets/cong/message.dart';

// loginCheck(Function loginFunc) {
//   final UserController userController = Get.find<UserController>();
//   if (userController.token.value != null) {
//     loginFunc();
//   } else {
//     showModal(Message(
//       content: 'Bạn cần đăng nhập tài khoản để thực hiện chức năng này'
//           .tr
//           .replaceRange(30, 31, '\n'),
//       rightPress: () {
//         Get.back();
//         Get.toNamed(Routes.dangNhapDangKy);
//       },
//     ));
//   }
// }
