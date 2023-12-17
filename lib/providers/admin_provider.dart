import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nasi_igut_han/models/admin.dart';

class AdminNotifier extends StateNotifier<Admin?> {
  AdminNotifier() : super(null);

  void set(Admin? admin) {
    state = admin;
  }
}

final adminProvider = StateNotifierProvider((ref) => AdminNotifier());
