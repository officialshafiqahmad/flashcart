import 'package:cirilla/mixins/mixins.dart';
import 'package:cirilla/models/post/post.dart';
import 'package:cirilla/constants/constants.dart';
import 'package:cirilla/screens/post/widgets/post_action.dart';
import 'package:cirilla/screens/post/widgets/post_image.dart';
import 'package:flutter/material.dart';

import '../widgets/post_block.dart';

class LayoutGradient extends StatelessWidget with AppBarMixin {
  final Post? post;
  final Map<String, dynamic>? styles;
  final Map<String, dynamic>? configs;
  final List<dynamic>? rows;
  final bool enableBlock;

  final dataKey = GlobalKey();

  LayoutGradient({
    Key? key,
    this.post,
    this.styles,
    this.configs,
    this.rows,
    this.enableBlock = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        buildAppbar(context),
        SliverToBoxAdapter(
          child: PostBlock(
            post: post,
            rows: rows,
            styles: styles,
            enableBlock: enableBlock,
            dataKey: dataKey,
          ),
        ),
      ],
    );
  }

  Widget buildAppbar(BuildContext context) {
    ThemeData theme = Theme.of(context);
    double paddingTop = MediaQuery.of(context).padding.top;
    double width = MediaQuery.of(context).size.width;
    double height = (width * 292) / 376;

    LinearGradient gradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter, // 10% of the width, so there are ten blinds.
      colors: <Color>[
        Colors.transparent,
        Colors.transparent,
        theme.scaffoldBackgroundColor
      ], // red to yellowepeats the gradient over the canvas
    );

    return SliverAppBar(
      expandedHeight: height - paddingTop,
      stretch: true,
      leadingWidth: 58,
      leading: Padding(
        padding: const EdgeInsetsDirectional.only(start: layoutPadding),
        child: leadingPined(),
      ),
      actions: [
        PostAction(
          post: post,
          configs: configs,
          dataKey: dataKey,
          enablePinned: true,
        ),
        const SizedBox(width: layoutPadding)
      ],
      backgroundColor: Colors.transparent,
      flexibleSpace: FlexibleSpaceBar(
        stretchModes: const <StretchMode>[
          StretchMode.zoomBackground,
        ],
        centerTitle: true,
        background: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            PostImage(post: post, width: width, height: height),
            Positioned(
              bottom: -1,
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(gradient: gradient),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
