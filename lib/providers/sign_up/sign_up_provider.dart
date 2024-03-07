import 'package:flutter/widgets.dart';
import 'package:flutter_template/providers/common/common_provider.dart';
import 'package:flutter_template/resources/routes.dart';
import 'package:provider/provider.dart';

class SignUpProvider extends ChangeNotifier {
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  SignUpProvider() {
    debugPrint('signUp');
  }

  signUp(BuildContext context) async {
    try {
      await context
          .read<CommonProvider>()
          .auth
          .createUserWithEmailAndPassword(
            email: emailTextEditingController.text,
            password: passwordTextEditingController.text,
          )
          .then((value) async {
        final user = {
          'email': value.user!.email,
          'uid': value.user!.uid,
        };
        await context
            .read<CommonProvider>()
            .db
            .collection('users')
            .add(user)
            .then((value) {
          print(value);
        });
        await context.read<CommonProvider>().getUserReference();
        Navigator.of(context)
            .pushNamedAndRemoveUntil(AppRoutes.home, (route) => false);
      });
    } catch (e) {
      print('error: $e');
    }
  }
}
