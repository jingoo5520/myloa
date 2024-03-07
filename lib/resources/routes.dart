import 'package:flutter/material.dart';
import 'package:flutter_template/providers/character/character_provider.dart';
import 'package:flutter_template/providers/common_contents/common_contents_provider.dart';
import 'package:flutter_template/providers/edit_content/edit_content_provider.dart';
import 'package:flutter_template/providers/home/home_provider.dart';
import 'package:flutter_template/providers/login/login_provider.dart';
import 'package:flutter_template/providers/onboarding/onboarding_provider.dart';
import 'package:flutter_template/providers/sign_up/sign_up_provider.dart';
import 'package:flutter_template/views/pages/character/character_page.dart';
import 'package:flutter_template/views/pages/common_contents/common_contents_page.dart';
import 'package:flutter_template/views/pages/edit_content/edit_content_page.dart';
import 'package:flutter_template/views/pages/home/home_page.dart';
import 'package:flutter_template/views/pages/login/login_page.dart';
import 'package:flutter_template/views/pages/onboarding/onboarding_page.dart';
import 'package:flutter_template/views/pages/sign_up/sign_up_page.dart';
import 'package:provider/provider.dart';

abstract class AppRoutes {
  static const String onboarding = '/onboarding';
  static const String signUp = '/signUp';
  static const String home = '/home';
  static const String login = '/login';
  static const String character = '/character';
  static const String editContent = '/editContent';
  static const String commonContents = '/commonContents';
}

final Map<String, Widget Function(BuildContext context)> appRoutes = {
  AppRoutes.onboarding: (context) => ChangeNotifierProvider(
        lazy: false,
        create: (_) => OnboardingProvider(),
        child: const OnboardingPage(),
      ),
  AppRoutes.home: (context) => ChangeNotifierProvider(
        lazy: false,
        create: (_) => HomeProvider(context),
        child: const HomePage(),
      ),
  AppRoutes.login: (context) => ChangeNotifierProvider(
        lazy: false,
        create: (_) => LoginProvider(),
        child: const LoginPage(),
      ),
  AppRoutes.signUp: (context) => ChangeNotifierProvider(
        lazy: false,
        create: (_) => SignUpProvider(),
        child: const SignUpPage(),
      ),
  AppRoutes.character: (context) {
    final arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    return ChangeNotifierProvider(
        lazy: false,
        create: (_) => CharacterProvider(context,
            characterCardModel: arguments['characterModel']),
        child: CharacterPage(
          characterCardModel: arguments['characterModel'],
        ));
  },
  AppRoutes.editContent: (context) {
    final arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    return ChangeNotifierProvider(
        lazy: false,
        create: (_) => EditContentProvider(
              context,
              type: arguments['type'],
              mode: arguments['mode'],
            ),
        child: EditContentPage(
          type: arguments['type'],
          mode: arguments['mode'],
          contentModel: arguments['contentModel'],
        ));
  },
  AppRoutes.commonContents: (context) => ChangeNotifierProvider(
        lazy: false,
        create: (_) => CommonContentsProvider(),
        child: const CommonContentsPage(),
      ),
};

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  return MaterialPageRoute(
      builder: appRoutes[settings.name]!, settings: settings);
}
