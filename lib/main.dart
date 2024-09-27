import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phone_contacts/pages/auth_checker.dart';
import 'package:phone_contacts/pages/error_screen.dart';
import 'package:phone_contacts/pages/loading_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

final firebaseinitializerProvider = FutureProvider<FirebaseApp>((ref) async {
  return Firebase.initializeApp();
});

class MyApp extends ConsumerWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final initialize = ref.watch(firebaseinitializerProvider);
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onPanDown: (_) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'PhoneContacts',
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
        ),
        home: initialize.when(
          data: (data) {
            return const AuthChecker();
          },
          error: ErrorScreen.new,
          loading: () => const LoadingScreen(),
        ),
      ),
    );
  }
}
