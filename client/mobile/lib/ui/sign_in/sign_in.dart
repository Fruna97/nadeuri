import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mobile/ui/sign_in/sign_in_view_model.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  late final SignInViewModel _signInViewModel;

  @override
  void initState() {
    _signInViewModel = context.read<SignInViewModel>();

    _signInViewModel.signIn.addListener(_navigateOnSignInComplete);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListenableBuilder(
        listenable: _signInViewModel.signIn,
        builder: (context, child) {
          return Stack(
            fit: StackFit.expand,
            children: [
              SafeArea(child: child!),
              if (_signInViewModel.signIn.running) ...[
                ModalBarrier(dismissible: false, color: Colors.black45),
                const Center(child: CircularProgressIndicator()),
              ],
            ],
          );
        },
        child: SignInForm(signInViewModel: _signInViewModel),
      ),
    );
  }

  @override
  void dispose() {
    _signInViewModel.signIn.removeListener(_navigateOnSignInComplete);

    super.dispose();
  }

  void _navigateOnSignInComplete() {
    if (_signInViewModel.signIn.completed) {
      _signInViewModel.signIn.clearResult();
      Navigator.pushNamedAndRemoveUntil(context, "/home", (route) => false);
    }
  }
}

class SignInForm extends StatefulWidget {
  final SignInViewModel _signInViewModel;

  const SignInForm({super.key, required SignInViewModel signInViewModel}) : _signInViewModel = signInViewModel;

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _passwordObscureText = true;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: ListView(
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          children: <Widget>[
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: "이메일", border: OutlineInputBorder(), counterText: ""),
              textInputAction: TextInputAction.next,
              maxLength: 320,
            ),
            const SizedBox(height: 8.0),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: "비밀번호",
                suffixIcon: ExcludeFocus(
                  child: IconButton(
                    icon: Icon(_passwordObscureText ? Icons.visibility_off : Icons.visibility),
                    onPressed: () {
                      setState(() {
                        _passwordObscureText = !_passwordObscureText;
                      });
                    },
                  ),
                ),
                border: OutlineInputBorder(),
                counterText: "",
              ),
              obscureText: _passwordObscureText,
              maxLength: 20,
            ),
            const SizedBox(height: 12.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () async {
                    log("Button pressed: 비밀번호 재설정");
                  },
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    padding: const EdgeInsets.all(0),
                    minimumSize: Size.zero,
                  ),
                  child: const Text("비밀번호 재설정"),
                ),
              ],
            ),
            if (context.select((SignInViewModel signInViewModel) => signInViewModel.commonErrorText).isNotEmpty) ...[
              const SizedBox(height: 12.0),
              Center(
                child: Text(
                  context.select((SignInViewModel signInViewModel) => signInViewModel.commonErrorText),
                  style: TextStyle(color: Colors.red, fontSize: 12),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
            const SizedBox(height: 12.0),
            ElevatedButton(
              onPressed: () async {
                FocusScope.of(context).unfocus();

                final String email = _emailController.text;
                final String password = _passwordController.text;

                widget._signInViewModel.validate(email: _emailController.text, password: _passwordController.text);

                if (!widget._signInViewModel.validated) {
                  return;
                }

                widget._signInViewModel.signIn.execute((email, password));
              },
              style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0))),
              child: const Text("로그인"),
            ),
            const SizedBox(height: 18.0),
            const Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(child: Divider(endIndent: 12.0)),
                Text("또는"),
                Expanded(child: Divider(indent: 12.0)),
              ],
            ),
            const SizedBox(height: 18.0),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  log("Button pressed: 카카오로 로그인");
                },
                style: ElevatedButton.styleFrom(shape: const CircleBorder()),
                child: const Text("K"),
              ),
            ),
            const SizedBox(height: 18.0),
            const Divider(),
            const SizedBox(height: 18.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text("아직 회원이 아니신가요?"),
                const SizedBox(width: 12.0),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/sign-up");
                  },
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    padding: const EdgeInsets.all(0.0),
                    minimumSize: Size.zero,
                  ),
                  child: const Text("회원가입 하기"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
