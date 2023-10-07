import 'package:flutter/material.dart';

class FadeInImagePlaceholder extends StatelessWidget {
  const FadeInImagePlaceholder(
      {super.key,
      required this.image,
      required this.placeholder,
      this.child,
      this.duration = const Duration(microseconds: 500),
      this.excludeFromSemantics = false,
      this.width,
      this.height,
      this.fit});

  final ImageProvider image;
  final Widget placeholder;
  final Widget? child;
  final Duration duration;
  final bool excludeFromSemantics;
  final double? height;
  final double? width;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    return Image(
      image: image,
      excludeFromSemantics: excludeFromSemantics,
      width: width,
      height: height,
      fit: fit,
      frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
        if (wasSynchronouslyLoaded) {
          return this.child ?? child;
        } else {
          return AnimatedSwitcher(
            duration: duration,
            child: frame != null ? this.child ?? child : placeholder,
          );
        }
      },
    );
  }
}
