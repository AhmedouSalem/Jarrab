import 'package:flutter/material.dart';
import 'package:jarrab/l10n/app_localizations.dart';
import 'category_grid.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({super.key, required this.category});

  final CategoryUI category;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return Material(
      elevation: 10,
      shadowColor: theme.colorScheme.shadow.withValues(alpha: 0.30),
      color: theme.colorScheme.surface,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: () {},
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 14, left: 14, right: 14),
              child: Icon(
                category.icon,
                size: 40,
                color: theme.colorScheme.primary,
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(left: 14, right: 14),
              child: Text(
                category.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(height: 6),
            Material(
              elevation: 3,
              shadowColor: theme.colorScheme.shadow.withValues(alpha: 0.30),
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(18),
                bottomRight: Radius.circular(18),
              ),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                width: double.infinity,
                decoration: BoxDecoration(
                  border: BoxBorder.fromLTRB(
                    top: BorderSide(
                      color: theme.colorScheme.shadow.withValues(alpha: 0.030),
                    ),
                  ),
                ),
                child: Text(
                  l10n.homeQuestionsCount(category.questionsCount),
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
