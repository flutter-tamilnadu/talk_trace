import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/call_log_controller.dart';
import 'call_log_item_widget.dart';

class CallLogsWidget extends GetView<CallLogController> {
  const CallLogsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: false,
        title: Obx(() {
          return Text(
              'Call Logs (${controller.filteredLogs.length.toString()})');
        }),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: controller.requestPermissionAndGetLogs,
          ),
        ],
      ),
      body: Column(
        children: [
          _buildFilterDropdown(),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              }

              if (controller.filteredLogs.isEmpty) {
                return Center(child: Text('No call logs found'));
              }

              return ListView.builder(
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

  Widget _buildFilterDropdown() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0,left: 8,right: 8,bottom: 4),
      child: SizedBox(
        height: 50,
        child: Obx(() =>
            DropdownButtonFormField<String>(
              value: controller.selectedFilter.value,
              items: controller.filterOptions.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  controller.applyFilter(value);
                }
              },
              decoration: InputDecoration(
                labelText: 'Filter by',
                border: OutlineInputBorder(),
              ),
            )),
      ),
    );
  }

}