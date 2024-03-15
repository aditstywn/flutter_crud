import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/auth/logout/logout_bloc.dart';
import '../../bloc/product/get_product/get_product_bloc.dart';
import '../../data/auth/auth_local_remote_data_source.dart';
import '../widgets/product_card.dart';
import 'add_page.dart';
import 'auth/login_page.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  void initState() {
    context.read<GetProductBloc>().add(const GetProductEvent.getListProduct());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.search),
                          labelText: 'Searching Product',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          )),
                    ),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  BlocConsumer<LogoutBloc, LogoutState>(
                    listener: (context, state) {
                      state.maybeWhen(
                        orElse: () {},
                        logoutSucess: (message) {
                          AuthLocalDatasource().removeAuthData();

                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginPage(),
                              ));

                          // ScaffoldMessenger.of(context).showSnackBar(
                          //   const SnackBar(
                          //     backgroundColor: Colors.green,
                          //     content: Text(
                          //       'Logout Success',
                          //       style: TextStyle(
                          //         color: Colors.black,
                          //       ),
                          //     ),
                          //   ),
                          // );
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
                      return CircleAvatar(
                        backgroundColor: Colors.grey,
                        child: IconButton(
                          onPressed: () {
                            context
                                .read<LogoutBloc>()
                                .add(const LogoutEvent.logout());
                          },
                          icon: const Icon(Icons.logout),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(10.0),
                children: [
                  BlocBuilder<GetProductBloc, GetProductState>(
                    builder: (context, state) {
                      return state.maybeWhen(
                        orElse: () => const SizedBox(),
                        loading: () => const Center(
                          child: CircularProgressIndicator(),
                        ),
                        getListProductSuccess: (products) {
                          return GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: products.data.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              childAspectRatio: 0.60,
                              crossAxisCount: 2,
                              crossAxisSpacing: 30.0,
                              mainAxisSpacing: 30.0,
                            ),
                            itemBuilder: (context, index) {
                              return ProductCard(
                                product: products.data[index],
                              );
                            },
                          );
                        },
                      );
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddProductPage(),
              ));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
