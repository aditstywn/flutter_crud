import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/auth/login/login_bloc.dart';
import 'bloc/auth/logout/logout_bloc.dart';
import 'bloc/auth/register/register_bloc.dart';
import 'bloc/product/add_product/add_product_bloc.dart';
import 'bloc/product/delete_product/delete_product_bloc.dart';
import 'bloc/product/get_product/get_product_bloc.dart';
import 'bloc/product/update_product/update_product_bloc.dart';
import 'data/auth/auth_local_remote_data_source.dart';
import 'data/auth/auth_remote_data_source.dart';
import 'data/product/product_remote_datasource.dart';
import 'presentation/pages/auth/login_page.dart';
import 'presentation/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => RegisterBloc(AuthRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => LoginBloc(AuthRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => LogoutBloc(AuthRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => AddProductBloc(ProductRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => UpdateProductBloc(ProductRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => DeleteProductBloc(ProductRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => GetProductBloc(ProductRemoteDatasource()),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: FutureBuilder<bool>(
          future: AuthLocalDatasource().isAuth(),
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data == true) {
              return const Homepage();
            } else {
              return const LoginPage();
            }
          },
        ),
      ),
    );
  }
}
