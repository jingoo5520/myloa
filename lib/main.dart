import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_template/providers/common/content_provider.dart';
import 'package:flutter_template/resources/firebase/firebase_options.dart';
import 'package:flutter_template/providers/common/common_provider.dart';
import 'package:flutter_template/resources/routes.dart';
import 'package:flutter_template/views/pages/onboarding/onboarding_page.dart';
import 'package:flutter_template/views/pages/splash/splash_page.dart';
import 'package:flutter_template/views/widgets/common/loading_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // await Firebase.initializeApp(
  //   apiKey: "AIzaSyC2i3uSRjyoYurZ7-nNfPrVZGiu0YQarBE",
  //   authDomain: "test-6f72e.firebaseapp.com",
  //   projectId: "test-6f72e",
  //   storageBucket: "test-6f72e.appspot.com",
  //   messagingSenderId: "538997176638",
  //   appId: "1:538997176638:web:4819d64fdb561f9d9cd46f",
  // );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: onGenerateRoute,
        builder: (context, child) => MultiProvider(
          providers: [
            ChangeNotifierProvider<CommonProvider>(
              lazy: false,
              create: (context) => CommonProvider(),
              builder: (context, child) => Stack(
                children: [
                  GestureDetector(
                    onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
                    child: child,
                  ),
                  Selector<CommonProvider, bool>(
                      selector: (p0, p1) => p1.isLoading,
                      builder: (context, value, child) {
                        if (value) return const LoadingScreen();
                        return const SizedBox();
                      })
                ],
              ),
            ),
            ChangeNotifierProvider<ContentProvider>(
              lazy: false,
              create: (context) => ContentProvider(),
            )
          ],
          child: child,
        ),
        theme: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        home: const SplashPage(),
      ),
    );
  }
}
