import 'package:bloom/models/cart_models/line_item_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../../api/cart_api_manager.dart';
import '../../../../components/network_image_with_loader.dart';
import '../../../../constants.dart';
import '../../../../providers/cart_page_provider/cart_page_provider.dart';

class CartItemWidget extends StatefulWidget {
  const CartItemWidget({
    super.key,
    this.press,
    required this.cartId,
    required this.item,
    this.discountPercent,
    this.priceAfetDiscount
  });

  final VoidCallback? press;
  final String cartId;
  final LineItem item;
  final int? discountPercent;
  final String? priceAfetDiscount;

  @override
  State<CartItemWidget> createState() => _CartItemWidgetState();
}

class _CartItemWidgetState extends State<CartItemWidget> {
  bool removingItemLoading = false;
  @override
  Widget build(BuildContext context) {
  final totalPrice = (widget.item.unitPrice * widget.item.quantity).toString();
    return GestureDetector(
      onTap: widget.press,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 100,
        decoration: BoxDecoration(
          border: Border.all(width: 0.5 , color: Colors.black45),
          borderRadius: BorderRadius.circular(defaultBorderRadious)
        ),
        child: Row(
          children: [
            AspectRatio(
              aspectRatio: 1.15,
              child: Stack(
                children: [
                  NetworkImageWithLoader(
                    widget.item.thumbnail!,
                    radius: defaultBorderRadious,
                    fullScreen: true,
                  ),
                  if (widget.discountPercent != null)
                    Positioned(
                      right: defaultPadding / 2,
                      top: defaultPadding / 2,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: defaultPadding / 2),
                        height: 16,
                        decoration: const BoxDecoration(
                          color: errorColor,
                          borderRadius: BorderRadius.all(
                              Radius.circular(defaultBorderRadious)),
                        ),
                        child: Text(
                          "${widget.discountPercent}% off",
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    )
                ],
              ),
            ),
            const SizedBox(width: defaultPadding / 4),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(defaultPadding / 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.item.productHandle!.toUpperCase(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontSize: 10),
                    ),
                    const SizedBox(height: defaultPadding / 2),
                    Text(
                      widget.item.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(fontSize: 12),
                    ),
                    const SizedBox(height: defaultPadding / 2),
                    widget.priceAfetDiscount != null
                        ? Row(
                            children: [
                              Text(
                                "\$${widget.priceAfetDiscount}",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: Color(0xFF31B0D8),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(width: defaultPadding / 4),
                              Text(
                                "\$${widget.item.unitPrice}",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .color,
                                  fontSize: 10,
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                            ],
                          )
                        : Text(
                            "\$$totalPrice",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Color(0xFF31B0D8),
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                            ),
                          ),
                  ],
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (!removingItemLoading)
                  IconButton(
                      onPressed: () async {
                        setState(() {
                          removingItemLoading = true;
                        });
                        await CartApiManager.deleteLineItem(
                            cartId: widget.cartId, lineItemId: widget.item.id);
                        if (context.mounted) {
                          await context.read<CartPageProvider>().getCart(context);
                        }
                        setState(() {
                          removingItemLoading = false;
                        });
                      },
                      icon: const Icon(
                        Icons.delete_forever_outlined,
                        color: Colors.redAccent,
                        size: 24,
                      )),
                if (removingItemLoading)
                  const CircularProgressIndicator(
                    constraints: BoxConstraints(minWidth: 20, minHeight: 20),
                    padding: EdgeInsets.only(right: defaultPadding, top: defaultPadding / 2),
                    strokeWidth: 2,
                    color: primaryColor,
                  ),


                Padding(
                  padding: const EdgeInsets.only(right: defaultPadding / 2 , bottom: defaultPadding / 2),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap:  () {
                          final currentQuantity = widget.item.quantity;
                          if (currentQuantity > 1) {
                            // Calculate the new value first
                            final newQuantity = currentQuantity - 1;
                            context.read<CartPageProvider>().changeItemQuantity(widget.item.id, newQuantity);
                          }
                        },
                        onLongPress: () {
                          final currentQuantity = widget.item.quantity;
                          int newQuantity = currentQuantity - 10;

                          // Ensure the quantity doesn't drop below 1.
                          if (newQuantity < 1) {
                            newQuantity = 1;
                          }

                          // Only call the provider if the quantity will actually change.
                          if (newQuantity != currentQuantity) {
                            context.read<CartPageProvider>().changeItemQuantity(widget.item.id, newQuantity);
                          }
                        },

                        child: Container(
                          // padding: const EdgeInsets.all(defaultPadding / 2),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black45),
                              borderRadius: BorderRadius.circular(6)
                          ),
                          child: SvgPicture.asset(
                            "assets/icons/Minus.svg",
                            colorFilter: const ColorFilter.mode(Colors.transparent, BlendMode.color),
                          ),
                        ),
                      ),

                      SizedBox(
                        width: defaultPadding * 2,
                        child: Center(
                          child: Text(
                            "${widget.item.quantity}",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),

                      GestureDetector(
                        onTap: () {
                          final currentQuantity = widget.item.quantity;
                          // Calculate the new value first
                          final newQuantity = currentQuantity + 1;
                          context.read<CartPageProvider>().changeItemQuantity(widget.item.id, newQuantity);
                        },
                        onLongPress: (){
                          final currentQuantity = widget.item.quantity;
                          // It's better to move this logic into the provider,
                          // but for a quick fix, you can do this:
                          final newQuantity = currentQuantity + 10;
                          context.read<CartPageProvider>().changeItemQuantity(widget.item.id, newQuantity);
                        },
                        child: Container(
                          // padding: const EdgeInsets.all(defaultPadding / 2),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black45),
                            borderRadius: BorderRadius.circular(6)
                          ),
                          child: SvgPicture.asset(
                            "assets/icons/Plus1.svg",
                            colorFilter: const ColorFilter.mode(Colors.transparent, BlendMode.color),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
