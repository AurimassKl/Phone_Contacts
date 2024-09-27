import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phone_contacts/pages/error_screen.dart';
import 'package:phone_contacts/pages/home_page.dart';
import 'package:phone_contacts/pages/loading_screen.dart';
import 'package:phone_contacts/pages/signin_page.dart';
import 'package:phone_contacts/provider/auth_provider.dart';

class AuthChecker extends ConsumerWidget {
  const AuthChecker({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _authState = ref.watch(authStateProvider);
    return _authState.when(
      data: (data) {
        if (data != null) return const HomePage();
        return const LoginPage();
      },
      error: ErrorScreen.new,
      loading: () => const LoadingScreen(),
    );
  }
}
