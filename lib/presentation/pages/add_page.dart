import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../bloc/product/add_product/add_product_bloc.dart';
import '../../models/request/product/add_product_request_models.dart';
import '../models/category_model.dart';
import 'home_page.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final nameController = TextEditingController();

  final priceController = TextEditingController();

  final stockController = TextEditingController();

  String? selectedCategory;

  XFile? image;

  final List<CategoryModel> categories = [
    CategoryModel(name: 'Makanan', value: 'food'),
    CategoryModel(name: 'Minuman', value: 'drink'),
    CategoryModel(name: 'Snack', value: 'snack'),
  ];

  @override
  void dispose() {
    nameController.dispose();
    priceController.dispose();
    stockController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final XFile? pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      image = pickedFile;
    } else {
      debugPrint('No image selected.');
      image =
          null; // Atur image menjadi null jika tidak ada gambar yang dipilih
    }

    setState(() {});
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
                child: image != null
                    ? Image.file(
                        File(image!.path),
                        fit: BoxFit.cover,
                      )
                    : Image.asset(
                        "assets/image/no image.jpg",
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                await _pickImage();
              },
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.amber),
              ),
              child: const Text(
                'Pilih Foto',
                style: TextStyle(
                  color: Colors.black,
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
              hint: const Text('Pilih Kategori'),
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
            BlocConsumer<AddProductBloc, AddProductState>(
              listener: (context, state) {
                state.maybeWhen(
                  orElse: () {},
                  addProductSuccess: (product) {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Homepage(),
                        ));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        backgroundColor: Colors.green,
                        content: Text(
                          'Add Product Success',
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
                      style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(Colors.amber),
                      ),
                      onPressed: () {
                        final product = AddProductRequest(
                          name: nameController.text,
                          price: int.parse(priceController.text),
                          stock: int.parse(stockController.text),
                          category: selectedCategory!,
                          image: image!,
                        );

                        context
                            .read<AddProductBloc>()
                            .add(AddProductEvent.addProduct(product));
                      },
                      child: const Text(
                        'Tambah',
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
