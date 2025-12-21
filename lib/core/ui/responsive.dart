import 'package:flutter/widgets.dart';

enum Breakpoint { compact, medium, expanded }

class Responsive {
  static Breakpoint of(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    if (w < 600) return Breakpoint.compact;
    if (w < 1024) return Breakpoint.medium;
    return Breakpoint.expanded;
  }

  static T pick<T>(
    BuildContext context, {
    required T compact,
    T? medium,
    T? expanded,
  }) {
    switch (of(context)) {
      case Breakpoint.expanded:
        return expanded ?? medium ?? compact;
      case Breakpoint.medium:
        return medium ?? compact;
      case Breakpoint.compact:
        return compact;
    }
  }
}
