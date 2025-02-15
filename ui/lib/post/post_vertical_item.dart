import 'package:flutter/material.dart';
import 'post_item.dart';

/// A post widget display full width on the screen
///
class PostVerticalItem extends PostItem {
  /// Widget name. It must required
  final Widget name;

  /// Widget image
  final Widget? image;

  /// Widget category
  final Widget? category;

  /// Widget excerpt
  final Widget? excerpt;

  /// Widget date
  final Widget? date;

  /// Widget author
  final Widget? author;

  /// Widget comment
  final Widget? comment;

  /// Width item
  final double width;

  /// Function click item
  final Function? onClick;

  /// Border of item post
  final Border? border;

  /// Color Card of item post
  final Color? color;

  /// Border of item post
  final BorderRadius? borderRadius;

  /// shadow card
  final List<BoxShadow>? boxShadow;

  /// Padding content image of safe
  final EdgeInsetsGeometry paddingContent;

  /// Create Post Vertical Item
  const PostVerticalItem({
    Key? key,
    required this.name,
    this.image,
    this.onClick,
    this.category,
    this.excerpt,
    this.date,
    this.author,
    this.comment,
    this.color,
    this.borderRadius,
    this.border,
    this.boxShadow,
    this.width = 300,
    this.paddingContent = const EdgeInsets.all(16),
  }) : super(
          key: key,
          colorPost: color,
          borderPost: border,
          borderRadiusPost: borderRadius,
          boxShadowPost: boxShadow,
        );

  @override
  Widget buildLayout(BuildContext context) {
    double height = 8;
    return SizedBox(
      width: width,
      child: InkWell(
        onTap: () => onClick?.call(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (image is Widget) image!,
            Padding(
              padding: paddingContent,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (category is Widget) ...[category ?? Container(), SizedBox(height: height)],
                  name,
                  if (excerpt is Widget) ...[
                    SizedBox(height: height),
                    excerpt ?? Container(),
                  ],
                  if (date is Widget || author is Widget || comment is Widget) ...[
                    SizedBox(height: height),
                    Wrap(
                      spacing: 16,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        if (date is Widget) date ?? Container(),
                        if (author is Widget) author ?? Container(),
                        comment ?? Container(),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
