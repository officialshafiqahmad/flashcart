import 'package:flutter/material.dart';

import 'package:flutter_html/flutter_html.dart';

class TextHtml extends StatelessWidget {
  final String html;
  final Map<String, Style>? style;
  final bool shrinkWrap;

  const TextHtml({
    Key? key,
    required this.html,
    this.style,
    this.shrinkWrap = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Html(
      data: html,
      style: {
        'html': Style(
            margin: Margins.zero,
            padding: HtmlPaddings.zero,
        ),
        'body': Style(
            margin: Margins.zero,
            padding: HtmlPaddings.zero,
            lineHeight: const LineHeight(1.4),
            fontSize: FontSize(16),
            color: Colors.white,
            textAlign: TextAlign.center,
        ),
        'p': Style(
          margin: Margins.zero,
          padding: HtmlPaddings.zero,
        ),
        'img': Style(
          padding: HtmlPaddings.symmetric(vertical: 8),
        ),
        ...?style,
      },
      shrinkWrap: shrinkWrap,
    );
  }
}