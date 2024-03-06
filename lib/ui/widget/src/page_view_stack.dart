import 'package:flutter/material.dart';
import 'package:with_it/module/module.dart';

final class PageViewStack extends StatelessWidget {
  const PageViewStack({
    required this.children,
    this.loop = false,
    this.pageController,
    super.key,
  });

  final bool loop;
  final PageController? pageController;
  final Iterable<Widget> children;

  @override
  Widget build(BuildContext context) => children.isNotEmpty
      ? Stack(
          children: [
            ...children.map(
              (x) => Opacity(
                opacity: 0,
                child: FractionallySizedBox(
                  widthFactor: pageController?.viewportFraction ?? 1,
                  child: x,
                ),
              ),
            ),
            Positioned.fill(
              child: PageView.builder(
                controller: pageController,
                itemBuilder: (context, i) => children[loop ? i.remInt(children.length) : i],
                itemCount: loop ? null : children.length,
              ),
            ),
          ],
        )
      : UI.empty;
}
