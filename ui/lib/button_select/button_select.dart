import 'package:flutter/material.dart';

class ButtonSelect extends StatelessWidget {
  final Widget? child;
  final EdgeInsets padding;
  final BorderRadius borderRadius;
  final GestureTapCallback? onTap;
  final Color color;
  final Color colorSelect;
  final bool isSelect;

  const ButtonSelect({
    Key? key,
    this.child,
    this.padding = const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
    this.borderRadius = const BorderRadius.all(Radius.circular(4)),
    this.color = const Color(0xFFDEE2E6),
    this.colorSelect = const Color(0xFF0686F8),
    this.isSelect = false,
    this.onTap,
  }) : super(key: key);

  const factory ButtonSelect.icon({
    Key? key,
    EdgeInsets padding,
    BorderRadius borderRadius,
    Color color,
    Color colorSelect,
    bool isSelect,
    GestureTapCallback? onTap,
    IconData nameIcon,
    Color colorIcon,
    Widget? child,
  }) = _ButtonSelectIcon;

  const factory ButtonSelect.filter({
    Key? key,
    EdgeInsets padding,
    BorderRadius borderRadius,
    Color color,
    Color colorSelect,
    bool isSelect,
    GestureTapCallback? onTap,
    IconData nameIcon,
    Color colorIcon,
    Widget? child,
  }) = _ButtonSelectFilter;

  const factory ButtonSelect.radio({
    Key? key,
    EdgeInsets padding,
    BorderRadius borderRadius,
    Color color,
    Color colorSelect,
    bool isSelect,
    GestureTapCallback? onTap,
    IconData nameIcon,
    Color colorIcon,
    Widget? child,
  }) = _ButtonSelectRadio;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: buildContent(),
    );
  }

  Widget buildContent() {
    double widthBorder = isSelect ? 2 : 1;
    Color colorBorder = isSelect ? colorSelect : color;

    return Container(
      padding: padding,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(width: widthBorder, color: colorBorder),
        borderRadius: borderRadius,
      ),
      child: child,
    );
  }
}

class _ButtonSelectIcon extends ButtonSelect {
  final IconData nameIcon;
  final Color colorIcon;

  const _ButtonSelectIcon({
    Key? key,
    EdgeInsets padding = const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
    BorderRadius borderRadius = const BorderRadius.all(Radius.circular(8)),
    Color color = const Color(0xFFDEE2E6),
    Color colorSelect = const Color(0xFF0686F8),
    bool isSelect = false,
    GestureTapCallback? onTap,
    Widget? child,
    this.nameIcon = Icons.check,
    this.colorIcon = Colors.white,
  }) : super(
          key: key,
          padding: padding,
          borderRadius: borderRadius,
          color: color,
          colorSelect: colorSelect,
          isSelect: isSelect,
          onTap: onTap,
          child: child,
        );
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: isSelect ? buildIconCheck(child: buildContent()) : buildContent(),
    );
  }

  Widget buildIconCheck({Widget? child}) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.only(top: 12, end: 12),
          child: child,
        ),
        PositionedDirectional(
          top: 0,
          end: 0,
          child: Container(
            width: 26,
            height: 26,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: colorSelect,
              shape: BoxShape.circle,
            ),
            child: Icon(
              nameIcon,
              color: colorIcon,
              size: 16,
            ),
          ),
        ),
      ],
    );
  }
}

class _ButtonSelectFilter extends ButtonSelect {
  final IconData nameIcon;
  final Color colorIcon;

  const _ButtonSelectFilter({
    Key? key,
    EdgeInsets padding = const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
    BorderRadius borderRadius = const BorderRadius.all(Radius.circular(4)),
    Color color = const Color(0xFFF4F4F4),
    Color colorSelect = const Color(0xFF0686F8),
    bool isSelect = false,
    GestureTapCallback? onTap,
    Widget? child,
    this.nameIcon = Icons.close,
    this.colorIcon = Colors.white,
  }) : super(
          key: key,
          padding: padding,
          borderRadius: borderRadius,
          color: color,
          colorSelect: colorSelect,
          isSelect: isSelect,
          onTap: onTap,
          child: child,
        );
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: borderRadius,
        child: isSelect ? buildIconCheck(child: buildContent()) : buildContent(),
      ),
    );
  }

  @override
  Widget buildContent() {
    Color colorBorder = isSelect ? colorSelect : color;
    Color background = isSelect ? Colors.transparent : color;

    return Container(
      padding: padding,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: background,
        border: Border.all(width: 1, color: colorBorder),
        borderRadius: borderRadius,
      ),
      child: child,
    );
  }

  Widget buildIconCheck({required Widget child}) {
    return Stack(
      children: [
        child,
        Positioned(
          top: 1,
          right: 1,
          child: CustomPaint(
            size:const Size(24, 24),
            painter: DrawTriangleShape(color: colorSelect),
            child: Container(
              width: 24,
              height: 24,
              alignment: Alignment.topRight,
              child: Padding(
                padding:const EdgeInsets.all(1),
                child: Icon(
                  nameIcon,
                  size: 12,
                  color: colorIcon,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _ButtonSelectRadio extends ButtonSelect {
  final IconData nameIcon;
  final Color colorIcon;

  const _ButtonSelectRadio({
    Key? key,
    EdgeInsets padding = const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
    BorderRadius borderRadius = const BorderRadius.all(Radius.circular(4)),
    Color color = const Color(0xFFF4F4F4),
    Color colorSelect = const Color(0xFF0686F8),
    bool isSelect = false,
    GestureTapCallback? onTap,
    Widget? child,
    this.nameIcon = Icons.close,
    this.colorIcon = Colors.white,
  }) : super(
          key: key,
          padding: padding,
          borderRadius: borderRadius,
          color: color,
          colorSelect: colorSelect,
          isSelect: isSelect,
          onTap: onTap,
          child: child,
        );
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: borderRadius,
        child: isSelect ? buildIconCheck(child: buildContent()) : buildContent(),
      ),
    );
  }

  @override
  Widget buildContent() {
    Color colorBorder = isSelect ? colorSelect : color;
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: colorBorder),
        borderRadius: borderRadius,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: _RadioUi(
              isSelect: isSelect,
              color: color,
              selectColor: colorSelect,
              onChange: (_) {
                onTap!();
              },
            ),
          ),
          child ?? const SizedBox(),
          const SizedBox(width: 16),
        ],
      ),
    );
  }

  Widget buildIconCheck({required Widget child}) {
    return child;
  }
}

class DrawTriangleShape extends CustomPainter {
  // Paint painter;
  Color color;

  DrawTriangleShape({
    this.color = Colors.red,
  });

  @override
  void paint(Canvas canvas, Size size) {
    var path = Path();
    var painter = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.close();

    canvas.drawPath(path, painter);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class _RadioUi extends StatelessWidget {
  final bool? isSelect;
  final ValueChanged<bool>? onChange;
  final Color selectColor;
  final Color color;

  const _RadioUi({
    Key? key,
    this.isSelect = true,
    this.onChange,
    this.color = const Color(0xFFDEE2E6),
    this.selectColor = const Color(0xFF0686F8),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double widthBorder = isSelect! ? 7 : 2;
    Widget radio = Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        border: Border.all(width: widthBorder, color: isSelect! ? selectColor : color),
        shape: BoxShape.circle,
      ),
    );
    return onChange != null
        ? GestureDetector(
            onTap: () => onChange!(!isSelect!),
            child: radio,
          )
        : radio;
  }
}
