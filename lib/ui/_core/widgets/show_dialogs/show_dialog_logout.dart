import 'package:app/ui/_core/theme/app_colors.dart';
import 'package:flutter/material.dart';

import '../../../../data/services/hive_service.dart';
import '../../../../routing/app_routes.dart';
import '../../../authentication/view_model/auth_view_model.dart';

void showAlertDialogLogout({
  required BuildContext context,
  required AuthViewModel authViewModel,
  required HiveService hive,
}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    barrierColor: AppColors.background.withValues(alpha: 0.75),
    builder: (context) {
      final user = authViewModel.currentUser;
      return PopScope(
        canPop: false,
        child: AlertDialog(
          backgroundColor: AppColors.background,
          contentPadding: EdgeInsets.zero,
          content: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.grey.shade200),
                  child: const Icon(Icons.person, size: 50, color: Colors.black54),
                ),
                const SizedBox(height: 12),

                Text(
                  user?.displayName ?? "User",
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
                ),

                const SizedBox(height: 10),
                const Text(
                  "Do you really want to log out?",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: AppColors.textPrimary),
                ),
              ],
            ),
          ),
          actionsPadding: const EdgeInsets.only(top: 1),
          actions: [
            Container(
              height: 60,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: 100,
                    child: TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text("Cancel", style: TextStyle(fontSize: 16)),
                    ),
                  ),
                  const SizedBox(height: 30, child: VerticalDivider(color: Colors.grey, thickness: 1)),
                  SizedBox(
                    width: 100,
                    child: TextButton(
                      onPressed: () async {
                        final navigator = Navigator.of(context);
                        await authViewModel.signOut();
                        await hive.close();
                        await navigator.pushNamedAndRemoveUntil(AppRoutes.splash, (route) => false);
                      },
                      child: const Text("Log out", style: TextStyle(fontSize: 16)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    },
  );
}
