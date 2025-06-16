import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:talk_trace/app/modules/details/controllers/call_log_detail_controller.dart';
import '../../dashboard/views/call_log_item_widget.dart';

class CallDetailsView extends GetView<CallLogDetailController> {
  const CallDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments as Map;
    final name = args['name'];
    final number = args['number'];

    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 56,left: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.arrow_back),
                SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16, // optional
                      ),
                    ),
                    Text(number,style: TextStyle(fontSize: 12),),
                  ],
                ),
              ]
            ),
          ),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              }
              if (controller.filteredLogs.isEmpty) {
                return Center(child: Text('No call logs found'));
              }

              return ListView.builder(
                shrinkWrap: true,
                itemCount: controller.filteredLogs.length,
                itemBuilder: (context, index) {
                  final log = controller.filteredLogs[index];
                  return CallLogItemWidget(log: log);
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}