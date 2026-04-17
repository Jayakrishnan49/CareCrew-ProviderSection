

import 'package:flutter/material.dart';
import 'package:project_2_provider/constants/app_color.dart';
import 'package:project_2_provider/controllers/policy_provider/policy_provider.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PolicyScreen extends StatelessWidget {
  final String title;
  final String url;

  const PolicyScreen({super.key, required this.title, required this.url});

  @override
  Widget build(BuildContext context) {
    Future.microtask(() =>
        context.read<PolicyProvider>().initController(url));

    return PopScope(
      // ✅ reset provider when user presses back
      onPopInvoked: (_) => context.read<PolicyProvider>().reset(),
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: AppColors.secondary),
          backgroundColor: AppColors.primary,
          title: 
          Text(
            title,
            style: TextStyle(
                color: AppColors.secondary,
                fontSize: 20,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.3,
            ),
          )
        ),
        body: Consumer<PolicyProvider>(
          builder: (context, provider, _) {
            if (provider.controller == null) {
              return const Center(child: CircularProgressIndicator());
            }

            return Stack(
              children: [
                WebViewWidget(controller: provider.controller!),
                if (provider.isLoading)
                  const Center(child: CircularProgressIndicator()),
              ],
            );
          },
        ),
      ),
    );
  }
}