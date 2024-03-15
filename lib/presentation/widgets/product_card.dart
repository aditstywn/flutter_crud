// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/product/delete_product/delete_product_bloc.dart';
import '../../constant/base_url.dart';
import '../../models/response/product/product_response_models.dart';
import '../pages/edit_page.dart';
import '../pages/home_page.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  const ProductCard({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            width: 1,
          ),
          borderRadius: BorderRadius.circular(19),
        ),
      ),
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey[300],
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(50.0)),
              child: CachedNetworkImage(
                width: 100,
                height: 100,
                fit: BoxFit.cover,
                imageUrl: "${Variables.imageBaseUrl}${product.image}",
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
              // child: Image.asset(
              //   "assets/image/no image.jpg",
              //   width: 100,
              //   height: 100,
              //   fit: BoxFit.cover,
              // ),
            ),
          ),
          const SizedBox(
            height: 2,
          ),
          Text(
            product.category,
            style: const TextStyle(
              fontSize: 12,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            product.name,
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
          Text(
            'Rp. ${product.price}',
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
          const SizedBox(
            height: 2,
          ),
          Container(
            padding: const EdgeInsets.all(5),
            decoration: const BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.all(Radius.circular(15))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.blue[300],
                  child: IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                EditProductPage(product: product),
                          ));
                    },
                    icon: const Icon(Icons.edit),
                  ),
                ),
                BlocConsumer<DeleteProductBloc, DeleteProductState>(
                  listener: (context, state) {
                    state.maybeWhen(
                      orElse: () {},
                      deleteSuccess: (product) {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Homepage(),
                            ));
                        // ScaffoldMessenger.of(context).showSnackBar(
                        //   const SnackBar(
                        //     backgroundColor: Colors.green,
                        //     content: Text(
                        //       'Delete Product Success',
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
                    return state.maybeWhen(
                      orElse: () {
                        return CircleAvatar(
                          backgroundColor: Colors.red,
                          child: IconButton(
                            onPressed: () {
                              context.read<DeleteProductBloc>().add(
                                  DeleteProductEvent.deleteProduct(product.id));
                            },
                            icon: const Icon(Icons.delete),
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
