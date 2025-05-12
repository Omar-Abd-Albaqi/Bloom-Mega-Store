import 'package:flutter/material.dart';

import '../../../../models/local_storage_models/product_model/product_model.dart';
import '../../../../utils/hive_manager.dart';
class FavoriteButton extends StatefulWidget {
  const FavoriteButton({super.key, required this.product});

  final ProductModel product;

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late bool isFav;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );

    _animation = Tween<double>(begin: 1.0, end: 0.0).animate(_controller);

    isFav = HiveStorageManager.isFavorite(widget.product.id);

    // Animate to the correct initial state
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (isFav) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void toggleFavorite() {
    setState(() {
      isFav = !isFav;

      if (isFav) {
        HiveStorageManager.addProductToFavorite(widget.product);
        _controller.forward();
      } else {
        HiveStorageManager.removeProductFromFavorite(widget.product.id);
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    print("ahdbasd");
    return GestureDetector(
      onTap: toggleFavorite,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Stack(
            alignment: Alignment.center,
            children: [
              Transform.scale(
                scale: _animation.value,
                child: Image.asset(
                  "assets/icons/heart.png",
                  color: Colors.black,
                  width: 24,
                ),
              ),
              Transform.scale(
                scale: 1 - _animation.value,
                child: Image.asset(
                  "assets/icons/filled_heart.png",
                  color: Colors.red,
                  width: 24,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
