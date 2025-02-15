import 'package:flutter/material.dart';
import 'product_item.dart';

/// A post widget display full width on the screen
///
class ProductContainedItem extends ProductItem {
  /// Widget image
  final Widget image;

  /// Widget name. It must required
  final Widget name;

  /// Widget price
  final Widget price;

  /// Widget rating
  final Widget? rating;

  /// Widget wishlist
  final Widget? wishlist;

  /// Widget button Add card
  final Widget? addCard;

  /// Widget extra tags in information
  final Widget? tagExtra;

  /// Widget quantity
  final Widget? quantity;

  /// Widget above name
  final Widget? aboveName;

  /// Widget above price
  final Widget? abovePrice;

  /// Widget above rating
  final Widget? aboveRating;

  /// Width item
  final double width;

  /// shadow card
  final List<BoxShadow>? boxShadow;

  /// Border of item post
  final Border? border;

  /// Color Card of item post
  final Color? color;

  /// Border of item post
  final BorderRadius? borderRadius;

  /// Function click item
  final Function onClick;

  /// Padding content
  final EdgeInsetsGeometry? padding;

  /// Create Product Contained Item
  const ProductContainedItem({
    Key? key,
    required this.image,
    required this.name,
    required this.onClick,
    required this.price,
    this.rating,
    this.wishlist,
    this.addCard,
    this.tagExtra,
    this.quantity,
    this.aboveName,
    this.abovePrice,
    this.aboveRating,
    this.width = 300,
    this.boxShadow,
    this.border,
    this.color = Colors.transparent,
    this.borderRadius,
    this.padding,
  }) : super(
          key: key,
          colorProduct: color,
          boxShadowProduct: boxShadow,
          borderProduct: border,
          borderRadiusProduct: borderRadius,
        );

  @override
  Widget buildLayout(BuildContext context) {
    return SizedBox(
      width: width,
      child: InkWell(
        onTap: () => onClick(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                image,
                Positioned(
                  top: 8,
                  left: 8,
                  right: 8,
                  bottom: 8,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(child: tagExtra ?? Container()),
                          wishlist ?? Container(),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          addCard ?? Container(),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(height: 8),
            Padding(
              padding: padding ?? EdgeInsets.zero,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (aboveName != null) aboveName!,
                  name,
                  if (abovePrice != null) abovePrice!,
                  price,
                  if (rating != null || aboveRating != null) const SizedBox(height: 8),
                  if (aboveRating != null) aboveRating!,
                  rating ?? Container(),
                  if (quantity != null) const SizedBox(height: 12),
                  quantity ?? Container(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
