import 'package:flutter/material.dart';

import 'package:meals_app/models/meal.dart';
import 'package:meals_app/widgets/meal_item.dart'; // Make sure this import exists

class MealsScreen extends StatelessWidget {
  final String? title;
  final List<Meal> meals;
  final void Function(Meal meal) onToggleFaviourite;
  final bool Function(Meal meal) isMealFavourite;

  const MealsScreen({
    super.key,
    this.title,
    List<Meal>? meals,
    required this.onToggleFaviourite,
    required this.isMealFavourite,
  }) : meals = meals ?? const [];

  @override
  Widget build(BuildContext context) {
    Widget content = ListView.builder(
      itemCount: meals.length,
      itemBuilder: (context, index) {
        return ListTile(title: Text(meals[index].title));
      },
    );

    if (meals.isEmpty) {
      content = Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Uh oh.... nothing here'),
            const SizedBox(height: 15),
            Text(
              'Try Selecting a different category.....',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ],
        ),
      );
    }

    if (meals.isNotEmpty) {
      content = ListView.builder(
        itemCount: meals.length,
        itemBuilder: (ctx, index) => MealItem(
          meal: meals[index],
          onToggleFaviourite: onToggleFaviourite,
          isFavourite: isMealFavourite(meals[index]),
        ),
      );
    }

    if (title == null) {
      return content;
    }
    return Scaffold(
      appBar: AppBar(title: Text(title!)),
      body: content,
    );
  }
}
