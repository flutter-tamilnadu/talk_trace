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
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.white,
        centerTitle: false,
        title: Obx(() {
          return Text(
            'Call Logs (${controller.filteredLogs.length.toString()})',
          );
        }),
        actions: [
          Obx(() {
            return PopupMenuButton<String>(
              surfaceTintColor: Colors.white,
              color: Colors.white,
              offset: Offset(-5, 45),
              elevation: 10,
              icon: Row(
                spacing: 10,
                children: [
                  Text(controller.selectedFilter.value),
                  Icon(Icons.tune),
                ],
              ),
              initialValue: controller.selectedFilter.value,
              onSelected: (String value) {
                if (value.isNotEmpty) {
                  controller.applyFilter(value);
                }
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                ...controller.filterOptions.map((String value) {
                  return PopupMenuItem<String>(
                    value: value,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(value),
                        Container(
                          height: 15,
                          width: 15,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: controller.selectedFilter.value == value
                                ? Colors.green
                                : Colors.transparent,
                            border: Border.all(color: Colors.grey),
                          ),
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.done,
                            size: 12,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ],
            );
          }),
          SizedBox(width: 10),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60.0),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: controller.callFilterOptions
                        .map(
                          (item) => GestureDetector(
                            onTap: () {
                              controller.changeCallFilterOptions(item);
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Icon(item.icon, size: 18, color: item.color),
                                Text(
                                  item.title,
                                  style: Get.textTheme.bodySmall?.copyWith(fontWeight: controller
                                      .selectedCallFilterOptions
                                      .value
                                      .title ==
                                      item.title?FontWeight.bold:FontWeight.normal),
                                ),
                                SizedBox(height: 2),
                                controller
                                            .selectedCallFilterOptions
                                            .value
                                            .title ==
                                        item.title
                                    ? CircleAvatar(
                                        radius: 3,
                                        backgroundColor: Colors.black,
                                      )
                                    : SizedBox(),
                              ],
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
              Divider(height: 4, color: Colors.deepOrange),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          // _buildFilterDropdown(),
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
}
