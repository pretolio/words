import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app/presentation/controllers/providers.dart';
import 'app/routes.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MultiProvider(
    providers: Providers.listProviders(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Words',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true, scaffoldBackgroundColor: Colors.grey.shade50,
        appBarTheme: AppBarTheme(centerTitle: true),
        colorScheme: ThemeData(useMaterial3: true)
            .colorScheme
            .copyWith(surfaceTint: Colors.white),
      ),
      builder: (context, child) {
        final MediaQueryData data = MediaQuery.of(context);
        return MediaQuery(
          data: data.copyWith(textScaleFactor: 1.0),
          child: child!,
        );
      },
      initialRoute: "/",
      onGenerateRoute: Routes.generateRoute,
    );
  }
}

