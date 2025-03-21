
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class SharedPreferenceHelper {
  static const String _taskKey = 'tasks';

  static Future<void> saveData(List<Map<String, dynamic>> tasks) async {
    final prefs = await SharedPreferences.getInstance();
    String encodedData = jsonEncode(tasks);
    await prefs.setString(_taskKey, encodedData);
  }

  static Future<List<Map<String, dynamic>>> loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    String? storedData = prefs.getString(_taskKey);

    if (storedData == null) return [];

    List<dynamic> decodedData = jsonDecode(storedData);

    return decodedData.map((task) => Map<String, dynamic>.from(task)).toList();
  }
}