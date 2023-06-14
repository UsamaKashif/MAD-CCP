import 'package:flutter/material.dart';
import 'package:mad_ccp/utils/progress_methods.dart';

class ProgressProvider extends ChangeNotifier {
  Map<String, dynamic>? _progress;
  final ProgressMethods _progressMethods = ProgressMethods();

  Map<String, dynamic>? get getProgress => _progress;

  Future<void> refreshProgress(String userId) async {
    _progress = await _progressMethods.getProgress(userId);
    notifyListeners();
  }
}
