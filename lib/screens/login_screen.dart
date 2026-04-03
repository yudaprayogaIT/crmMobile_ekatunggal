import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salesappnew/bloc/auth/auth_bloc.dart';
import 'package:salesappnew/repositories/auth_repository.dart';
import 'package:salesappnew/utils/local_data.dart';
// import 'package:salesappnew/utils/local_data.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    super.key,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    LocalData().setData("url", "https://apicrm.ekatunggal.com/");
  }

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    final AuthBloc bloc = AuthBloc(AuthRepository());
    Map<String, String> options = {
      'Bogor': 'https://apicrm.ekatunggal.com/',
      'Klaten': 'https://apicrm-klt.ekatunggal.com/',
      'Kupang': 'https://apicrm-kpg.ekatunggal.com/',
      'Makassar': 'https://apicrm-mks.ekatunggal.com/',
      'Manado': 'https://apicrm-mnd.ekatunggal.com/',
      'Medan': 'https://apicrm-mdn.ekatunggal.com/',
      'Palembang': 'https://apicrm-plb.ekatunggal.com/',
      'Palu': 'https://apicrm-palu.ekatunggal.com/',
      'Pekanbaru': 'https://apicrm-pkn.ekatunggal.com/',
      'Pontianak': 'https://apicrm-pnt.ekatunggal.com/',
      'Semarang': 'https://apicrm-smg.ekatunggal.com/',
      'Samarinda': 'https://apicrm-smd.ekatunggal.com/',
      'Surabaya': 'https://apicrm-sby.ekatunggal.com/',
      'Development': 'https://api-crmdev.ekatunggal.com/',
    };
    // String? _selectedValue = 'https://apicrm.ekatunggal.com/';

    return Scaffold(
      body: BlocBuilder<AuthBloc, AuthState>(
        bloc: bloc,
        builder: (context, state) {
          if (state is AuthLoading) {
            return SizedBox(
              width: 40,
              height: 40,
              child: CircularProgressIndicator(color: Colors.grey[400]),
            );
          }

          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 30),
                        height: 150,
                        child: Image.asset(
                          "assets/images/logo.png",
                        ),
                      ),
                      const SizedBox(height: 30),
                      Column(
                        children: [
                          TextField(
                            controller: _usernameController,
                            enableSuggestions: false,
                            autocorrect: false,
                            decoration: const InputDecoration(
                              labelText: "Username",
                              hintText: "Cth : ramdhaniit",
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextField(
                            controller: _passwordController,
                            obscureText: !bloc.isPasswordVisible,
                            enableSuggestions: false,
                            autocorrect: false,
                            decoration: InputDecoration(
                              labelText: "Password",
                              hintText: "",
                              border: const OutlineInputBorder(),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  bloc.add(
                                    TogglePasswordVisibility(),
                                  );
                                },
                                icon: Icon(
                                  bloc.isPasswordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              const Text("Server :  "),
                              BlocBuilder<AuthBloc, AuthState>(
                                  bloc: authBloc,
                                  builder: (context, stateUrl) {
                                    return DropdownButton<String>(
                                      value: authBloc.url,
                                      onChanged: (String? newValue) {
                                        authBloc.add(
                                            ChangeServer(server: newValue!));
                                      },
                                      items: options.keys.map((String key) {
                                        return DropdownMenuItem<String>(
                                          value: options[key],
                                          child: Text(key),
                                        );
                                      }).toList(),
                                      menuMaxHeight: 250, // ⬅️ tambahkan ini
                                    );
                                  }),
                            ],
                          ),
                          const SizedBox(height: 30),
                        ],
                      ),
                      state is AuthLoading
                          ? const Center(
                              child: CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.grey),
                              ),
                            )
                          : ElevatedButton(
                              onPressed: () {
                                final username = _usernameController.text;
                                final password = _passwordController.text;

                                authBloc.add(
                                  OnLogin(
                                      username: username, password: password),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15),
                                backgroundColor: Colors.grey[300],
                              ),
                              child: const Text(
                                "Login",
                                style: TextStyle(
                                  color: Color(0xFF747D8C),
                                ),
                              ),
                            )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Version 2.0.0",
                  style: TextStyle(
                    color: Colors.grey[400],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
