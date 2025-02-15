import 'package:flutter/material.dart';
import 'post_item.dart';

/// A post widget display full width on the screen
///
class PostVerticalCenterItem extends PostItem {
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
  const PostVerticalCenterItem({
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
    this.border,
    this.borderRadius,
    this.boxShadow,
    this.width = double.infinity,
    this.paddingContent = const EdgeInsets.all(16),
  }) : super(
          key: key,
          colorPost: color,
          boxShadowPost: boxShadow,
          borderPost: border,
          borderRadiusPost: borderRadius,
        );

  @override
  Widget buildLayout(BuildContext context) {
    return SizedBox(
      width: width,
      child: InkWell(
        onTap: () => onClick?.call(),
        child: Column(
          children: [
            if (image is Widget) image!,
            Padding(
              padding: paddingContent,
              child: Column(
                children: [
                  if (category is Widget) ...[category ?? Container(), const SizedBox(height: 16)],
                  name,
                  SizedBox(
                      height: excerpt is Widget || date is Widget || author is Widget || comment is Widget ? 8 : 0),
                  if (excerpt is Widget) ...[
                    const SizedBox(height: 8),
                    excerpt ?? Container(),
                  ],
                  if (date is Widget) ...[
                    const SizedBox(height: 8),
                    date ?? Container(),
                  ],
                  if (author is Widget || comment is Widget) ...[
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 16,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      alignment: WrapAlignment.center,
                      children: [
                        if (author is Widget) author ?? Container(),
                        comment ?? Container(),
                      ],
                    ),
                  ]
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
