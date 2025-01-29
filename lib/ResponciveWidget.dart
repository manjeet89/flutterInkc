import 'package:flutter/widgets.dart';

class Responcivewidget extends StatelessWidget {
  final Widget mobile;
  final Widget tab;

  const Responcivewidget({super.key, required this.mobile, required this.tab});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth < 768) {
        return mobile;
      } else {
        return tab;
      }
    });
  }
}
