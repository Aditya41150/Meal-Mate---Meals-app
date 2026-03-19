import 'package:flutter/material.dart';

import 'package:meals_app/models/meal.dart';
import 'package:meals_app/widgets/meal_item.dart'; // Make sure this import exists

class MealsScreen extends StatelessWidget {
  final String? title;
  final List<Meal> meals;
  final bool Function(Meal meal) isMealFavorite;

  const MealsScreen({
    super.key,
    this.title,
    List<Meal>? meals,
    required this.isMealFavorite,
  }) : meals = meals ?? const [];

  @override
  Widget build(BuildContext context) {
    Widget content;

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
    } else {
      content = ListView.builder(
        itemCount: meals.length,
        itemBuilder: (ctx, index) => MealItem(
          meal: meals[index],
          isFavorite: isMealFavorite(meals[index]),
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
