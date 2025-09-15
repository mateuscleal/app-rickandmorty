import 'package:app/ui/_core/theme/app_colors.dart';
import 'package:app/ui/main_scaffold/view_models/main_scaffold_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/services/hive_service.dart';
import '../../_core/widgets/show_dialogs/show_dialog_logout.dart';
import '../../authentication/view_model/auth_view_model.dart';

class AppBarCustom extends StatefulWidget implements PreferredSizeWidget {
  final MainScaffoldViewModel viewModel;
  final Future<bool> Function(String value) searchEpisodes;

  const AppBarCustom({super.key, required this.viewModel, required this.searchEpisodes});

  @override
  Size get preferredSize => const Size.fromHeight(80);

  @override
  State<AppBarCustom> createState() => _AppBarCustomState();
}

class _AppBarCustomState extends State<AppBarCustom> {
  final _focusNode = FocusNode();
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final viewModel = widget.viewModel;

    return AppBar(
      toolbarHeight: 80,
      backgroundColor: AppColors.background,
      foregroundColor: AppColors.primary,
      title: Image.asset(viewModel.titles[viewModel.currentIndex], width: 200),
      centerTitle: true,
      leading: Visibility(
        visible: !viewModel.isExpanded,
        child: IconButton(
          icon: Icon(Icons.logout_outlined, color: AppColors.secondary),
          onPressed: () async {
            final hive = context.read<HiveService?>();
            final auth = context.read<AuthViewModel?>();
            showAlertDialogLogout(context: context, authViewModel: auth!, hive: hive!);
          },
        ),
      ),
      actions: [
        Visibility(
          visible: viewModel.currentIndex == 1,
          child: Row(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: viewModel.isExpanded ? MediaQuery.of(context).size.width * 0.8 : 0,
                curve: Curves.easeInOut,
                child: TextField(
                  focusNode: _focusNode,
                  controller: _controller,
                  style: TextStyle(color: AppColors.textPrimary),
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                    hintText: 'Search episodes by name',
                    hintStyle: TextStyle(color: Colors.grey),
                    filled: true,
                    fillColor: AppColors.background,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: AppColors.accent),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                  ),
                  onSubmitted: (value) async {
                    _focusNode.unfocus();
                    final scaffoldMessenger = ScaffoldMessenger.of(context);
                    final flag = await widget.searchEpisodes(value);
                    if (!flag) {
                      viewModel.toggleSearch();
                      scaffoldMessenger.clearSnackBars();
                      scaffoldMessenger.showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.red,
                          content: Padding(
                            padding: EdgeInsets.symmetric(vertical: 8.0),
                            child: Text('Episode not found'),
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
              IconButton(
                icon: Icon(
                  viewModel.isExpanded ? Icons.close_outlined : Icons.search_outlined,
                  color: AppColors.secondary,
                ),
                onPressed: () async {
                  viewModel.toggleSearch();
                  if (viewModel.isExpanded) {
                    _controller.clear();
                  }
                  _focusNode.unfocus();
                  await widget.searchEpisodes('');
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
