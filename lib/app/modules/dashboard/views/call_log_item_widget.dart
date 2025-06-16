import 'package:call_log/call_log.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import '../../../routes/app_pages.dart';
import '../../details/views/call_details_view.dart';
import '../controllers/call_log_controller.dart';


class CallLogItemWidget extends GetView<CallLogController> {
  final CallLogEntry log;
  const CallLogItemWidget({super.key,required this.log});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4)
      ),
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ListTile(
        onTap: (){
          Get.toNamed('/detail', arguments: {
            'number': log.number,
            'name' : log.name
          });
        },
        leading: CircleAvatar(
          backgroundColor: controller.getCallTypeColor(log.callType),
          child: Icon(
            controller.getCallTypeIcon(log.callType),
            color: Colors.white,
          ),
        ),
        title: Text(
          log.name ?? log.number ?? 'Unknown',
          style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(controller.getCallType(log.callType)),
            Text(
              log.timestamp != null
                  ? DateTime.fromMillisecondsSinceEpoch(log.timestamp!)
                  .toString()
                  .substring(0, 19)
                  : 'Unknown time',
            ),
          ],
        ),
        trailing: Text(controller.formatDuration(log.duration)),
      ),
    );
  }
}
