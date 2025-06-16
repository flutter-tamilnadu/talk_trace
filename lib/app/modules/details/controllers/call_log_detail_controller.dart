import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:call_log/call_log.dart';
import 'package:permission_handler/permission_handler.dart';

class CallLogDetailController extends GetxController {
  final callLogs = <CallLogEntry>[].obs;
  final filteredLogs = <CallLogEntry>[].obs;
  final isLoading = false.obs;
  final selectedFilter = 'All'.obs;

  final filterOptions = [
    'Today',
    'Last Week',
    'Last Month',
    'Last 3 Months',
    'Last 6 Months',
    'All'
  ];

  @override
  void onInit() {
    super.onInit();
    requestPermissionAndGetLogs();
  }

  Future<void> requestPermissionAndGetLogs() async {
    isLoading.value = true;

    // Request permission
    final status = await Permission.phone.request();
    if (status.isGranted) {
      await getCallLogs();
    } else {
      Get.snackbar('Permission required', 'Phone permission is needed to access call logs');
    }

    isLoading.value = false;
  }

  Future<void> getCallLogs() async {
    try {
      isLoading.value = true;
      final Iterable<CallLogEntry> entries = await CallLog.query(
        number: Get.arguments['number'],
      );
      callLogs.assignAll(entries.toList());
      applyFilter(selectedFilter.value);
    } catch (e) {
      Get.snackbar('Error', 'Failed to get call logs: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void applyFilter(String filter) {
    selectedFilter.value = filter;
    final now = DateTime.now();
    DateTime startDate;

    switch (filter) {
      case 'Today':
        startDate = DateTime(now.year, now.month, now.day);
        break;
      case 'Last Week':
        startDate = now.subtract(Duration(days: 7));
        break;
      case 'Last Month':
        startDate = DateTime(now.year, now.month - 1, now.day);
        break;
      case 'Last 3 Months':
        startDate = DateTime(now.year, now.month - 3, now.day);
        break;
      case 'Last 6 Months':
        startDate = DateTime(now.year, now.month - 6, now.day);
        break;
      case 'All':
      default:
        filteredLogs.assignAll(callLogs);
        return;
    }
    filteredLogs.assignAll(
        callLogs.where((log) =>
        log.timestamp != null &&
            DateTime.fromMillisecondsSinceEpoch(log.timestamp!).isAfter(startDate.subtract(const Duration(seconds: 1)))
        ).toList()
    );
  }

  String formatDuration(int? duration) {
    if (duration == null) return '0s';
    final minutes = duration ~/ 60;
    final seconds = duration % 60;
    return '${minutes}m ${seconds}s';
  }

  String getCallType(CallType? type) {
    switch (type) {
      case CallType.incoming:
        return 'Incoming';
      case CallType.outgoing:
        return 'Outgoing';
      case CallType.missed:
        return 'Missed';
      case CallType.voiceMail:
        return 'Voicemail';
      case CallType.rejected:
        return 'Rejected';
      case CallType.blocked:
        return 'Blocked';
      default:
        return 'Unknown';
    }
  }

  IconData getCallTypeIcon(CallType? type) {
    switch (type) {
      case CallType.incoming:
        return Icons.call_received;
      case CallType.outgoing:
        return Icons.call_made;
      case CallType.missed:
        return Icons.call_missed;
      default:
        return Icons.call;
    }
  }

  Color getCallTypeColor(CallType? type) {
    switch (type) {
      case CallType.incoming:
        return Colors.green;
      case CallType.outgoing:
        return Colors.blue;
      case CallType.missed:
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

}