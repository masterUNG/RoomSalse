import 'package:get/get.dart';
import 'package:roomsalse/models/user_model.dart';

class AppController extends GetxController {
  RxString appName = 'RoomSalse'.obs;
  RxList<String?> typeUsers = <String?>[null].obs;
  RxList<UserModel> loginUserModels = <UserModel>[].obs;
}
