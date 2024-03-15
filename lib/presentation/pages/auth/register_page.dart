import 'package:flutter/material.dart';
import 'package:flutter_application_crud/data/auth/auth_local_remote_data_source.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/auth/register/register_bloc.dart';
import '../../../models/request/auth/register_request_models.dart';
import '../home_page.dart';
import 'login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final nameC = TextEditingController();
  final emailC = TextEditingController();
  final passC = TextEditingController();

  bool isHide = true;

  @override
  void dispose() {
    nameC.dispose();
    emailC.dispose();
    passC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            const Icon(
              Icons.flutter_dash,
              size: 150,
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: nameC,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.people),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                labelText: 'Username',
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: emailC,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.email),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                labelText: 'Email',
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              obscureText: isHide,
              controller: passC,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.key),
                suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        isHide = !isHide;
                      });
                    },
                    icon: const Icon(Icons.remove_red_eye)),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                labelText: 'Password',
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            BlocConsumer<RegisterBloc, RegisterState>(
              listener: (context, state) {
                state.maybeWhen(
                  orElse: () {},
                  registerSuccess: (registerResponseModel) {
                    AuthLocalDatasource()
                        .saveAuthDataRegister(registerResponseModel);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Homepage(),
                      ),
                    );

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        backgroundColor: Colors.green,
                        content: Text(
                          'Register Success',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    );
                  },
                  error: (message) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.red,
                        content: Text(
                          message,
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
              builder: (context, state) {
                return state.maybeWhen(
                  loading: () => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  orElse: () {
                    return ElevatedButton(
                      onPressed: () {
                        final registerRequest = RegisterRequestModel(
                          name: nameC.text,
                          email: emailC.text,
                          password: passC.text,
                        );

                        context
                            .read<RegisterBloc>()
                            .add(RegisterEvent.register(registerRequest));

                        nameC.clear();
                        emailC.clear();
                        passC.clear();
                      },
                      child: const Text('Daftar'),
                    );
                  },
                );
              },
            ),
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginPage(),
                    ));
              },
              child: const Text.rich(
                TextSpan(
                  text: 'Sudah memiliki akun? ',
                  children: [
                    TextSpan(
                      text: 'Masuk',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
