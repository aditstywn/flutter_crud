import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/product/update_product/update_product_bloc.dart';
import '../../constant/base_url.dart';
import '../../models/request/product/update_product_request_models.dart';
import '../../models/response/product/product_response_models.dart';
import '../models/category_model.dart';
import 'home_page.dart';

class EditProductPage extends StatefulWidget {
  final Product product;
  const EditProductPage({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  State<EditProductPage> createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  final nameController = TextEditingController();

  final priceController = TextEditingController();

  final stockController = TextEditingController();

  String? selectedCategory;

  final List<CategoryModel> categories = [
    CategoryModel(name: 'Food', value: 'food'),
    CategoryModel(name: 'Drink', value: 'drink'),
    CategoryModel(name: 'Snack', value: 'snack'),
  ];

  @override
  void initState() {
    nameController.text = widget.product.name;
    priceController.text = '${widget.product.price}';
    stockController.text = '${widget.product.stock}';
    selectedCategory = widget.product.category;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            Container(
              height: 200,
              padding: const EdgeInsets.all(10.0),
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  side: const BorderSide(
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                // child: Image.asset(
                //   'assets/image/no image.jpg',
                //   width: 100,
                //   height: 100,
                //   fit: BoxFit.cover,
                // ),
                child: CachedNetworkImage(
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                  imageUrl: "${Variables.imageBaseUrl}${widget.product.image}",
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Nama Product',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: priceController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Harga Product',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: stockController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Setok Product',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            DropdownButtonFormField<String>(
              hint: Text(
                selectedCategory ?? 'Pilih Kategori',
                style: TextStyle(
                  color: selectedCategory == null ? Colors.grey : Colors.black,
                ),
              ),
              items: categories.map((CategoryModel category) {
                return DropdownMenuItem<String>(
                  value: category.value,
                  child: Text(category.name),
                );
              }).toList(),
              onChanged: (String? value) {
                setState(() {
                  selectedCategory = value;
                });
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.0),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.0),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            BlocConsumer<UpdateProductBloc, UpdateProductState>(
              listener: (context, state) {
                state.maybeWhen(
                  orElse: () {},
                  updateProductSuccess: (product) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Homepage(),
                      ),
                    );

                    // ScaffoldMessenger.of(context).showSnackBar(
                    //   const SnackBar(
                    //     backgroundColor: Colors.green,
                    //     content: Text(
                    //       'Update Success',
                    //       style: TextStyle(
                    //         color: Colors.black,
                    //       ),
                    //     ),
                    //   ),
                    // );
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
                      style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(Colors.amber),
                      ),
                      onPressed: () {
                        final update = UpdateProductsRequestModel(
                          name: nameController.text,
                          price: int.parse(priceController.text),
                          stock: int.parse(stockController.text),
                          category: selectedCategory!,
                        );

                        context.read<UpdateProductBloc>().add(
                              UpdateProductEvent.updateProduct(
                                  update, widget.product.id),
                            );
                      },
                      child: const Text(
                        'Ubah',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
