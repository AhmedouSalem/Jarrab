import 'package:flutter/material.dart';
import 'package:jarrab/core/ui/responsive.dart';

import 'category_card.dart';

class CategoryUI {
  const CategoryUI({
    required this.id,
    required this.icon,
    required this.title,
    required this.questionsCount,
  });

  final String id;
  final IconData icon;
  final String title;
  final int questionsCount;
}

class CategoryGrid extends StatelessWidget {
  const CategoryGrid({
    super.key,
    required this.categories,
    required this.padding,
  });

  final List<CategoryUI> categories;
  final double padding;

  @override
  Widget build(BuildContext context) {
    final columns = Responsive.pick<int>(
      context,
      compact: 2,
      medium: 3,
      expanded: 4,
    );

    return SliverPadding(
      padding: EdgeInsets.only(bottom: 8, left: padding, right: padding),
      sliver: SliverGrid(
        delegate: SliverChildBuilderDelegate(
          (context, index) => CategoryCard(category: categories[index]),
          childCount: categories.length,
        ),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: columns,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 1.25,
        ),
      ),
    );
  }
}
