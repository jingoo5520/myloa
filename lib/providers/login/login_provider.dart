import 'package:flutter/material.dart';
import 'package:flutter_template/model/user/user_model.dart';
import 'package:flutter_template/providers/common/common_provider.dart';
import 'package:flutter_template/resources/routes.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class LoginProvider extends ChangeNotifier {
  String tempEmail = '2@email.com';
  String tempPassword = '222222';

  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  signIn(BuildContext context) async {
    context.read<CommonProvider>().onLoad();
    try {
      await context
          .read<CommonProvider>()
          .auth
          .signInWithEmailAndPassword(
              // email: emailTextEditingController.text,
              // password: passwordTextEditingController.text,
              email: tempEmail,
              password: tempPassword)
          .then((value) async {
        context
            .read<CommonProvider>()
            .db
            .collection('users')
            .where('email', isEqualTo: tempEmail)
            .get()
            .then((value) {
          final user = User.fromJson(value.docs[0].data());
          print(user.toJson());
        });
        await context.read<CommonProvider>().getUserReference();

        Navigator.of(context)
            .pushNamedAndRemoveUntil(AppRoutes.home, (route) => false);
      });
    } catch (e) {
      debugPrint('error: $e');
    }
  }
}
