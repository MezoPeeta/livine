import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

import '../../shared/components/widgets/auth/auth_widget.dart';
import '../../shared/constants/constants.dart';
import '../../translations/locale_keys.g.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  Client client = http.Client();
  bool isLoading = false;

  void resetPassword() async {
    final url = '$restAPIURL/password_reset/';
    final response =
        await http.post(Uri.parse(url), body: {'email': _email.text});

    if (response.statusCode == 200) {
      print(response);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(context.locale.languageCode == "en"
            ? "Please check your email"
            : "من فضلك تفقد بريدك الالكتروني"),
      ));
      setState(() {
        isLoading = false;
      });
      context.go("/token_validate");
    } else {
      print("Error");
    }
  }

  void validateRPForm() {
    final form = _formKey.currentState!;
    if (form.validate()) {
      setState(() {
        isLoading = true;
      });
      resetPassword();
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.Reset_pass.tr()),
      ),
      body: Column(
        children: [
          Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      validator: (e) {
                        if (e!.isEmpty) {
                          return context.locale.languageCode == "en"
                              ? "Please enter your email"
                              : "من فضلك ادخل البريد الاكتروني";
                        }

                        return null;
                      },
                      controller: _email,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(),
                        ),
                        labelText: context.locale.languageCode == "en"
                            ? 'Email'
                            : "البريد الاكتروني",
                        labelStyle: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    AuthButton(
                        validateForm: validateRPForm,
                        isLoading: isLoading,
                        text: LocaleKeys.Reset_pass.tr(),
                        context: context)
                  ],
                ),
              )),
        ],
      ),
    );
  }
}