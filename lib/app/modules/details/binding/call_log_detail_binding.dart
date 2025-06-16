import 'package:get/get.dart';
import 'package:talk_trace/app/modules/details/controllers/call_log_detail_controller.dart';


class CallLogDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CallLogDetailController>(() => CallLogDetailController());
  }
}