import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nasi_igut_han/providers/admin_provider.dart';

class MySignOutDialog extends ConsumerWidget {
  const MySignOutDialog({super.key, this.closeDrawer = false});

  final bool closeDrawer;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      title: const Text('Keluar'),
      content: const SelectableText('Apakah kamu yakin ingin keluar?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Batal'),
        ),
        TextButton(
          onPressed: () {
            ref.read(adminProvider.notifier).signOut();

            Navigator.pop(context);
            if (closeDrawer) Navigator.pop(context);

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                duration: Duration(seconds: 3),
                content: Text('Keluar Berhasil!'),
              ),
            );
          },
          child: const Text(
            'Keluar',
            style: TextStyle(color: Colors.red),
          ),
        ),
      ],
    );
  }
}
