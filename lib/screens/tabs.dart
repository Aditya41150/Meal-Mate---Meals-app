import 'package:flutter/material.dart';
import 'package:meals_app/screens/categories.dart';
import 'package:meals_app/screens/filters.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/widgets/main_drawer.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});
  @override
  State<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends State<TabsScreen> {
  int _selecetedPageIndex = 0;

  List<Meal>? _favouriteMeals = [];

  List<Meal> get _safeFavouriteMeals {
    _favouriteMeals ??= <Meal>[];
    return _favouriteMeals!;
  }

  void _showInfoMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  void _toggeMealFaviouriteStatus(Meal meal) {
    final isExisting = _safeFavouriteMeals.contains(meal);

    if (isExisting == true) {
      setState(() {
        _safeFavouriteMeals.remove(meal);
      });
      _showInfoMessage('Meal is no longer faviourite');
    } else {
      setState(() {
        _safeFavouriteMeals.add(meal);
        _showInfoMessage('Marked as faviourite');
      });
    }
  }

  void _selectPage(int index) {
    setState(() {
      _selecetedPageIndex = index;
    });
  }

  bool _isMealFavourite(Meal meal) {
    return _safeFavouriteMeals.contains(meal);
  }

  void _setScreen(String identifier) {
    if (identifier == 'Filters') {
      Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=> const FiltersScreen()));
    } else {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage = CategoriesScreen(
      onToggleFaviourite: _toggeMealFaviouriteStatus,
      isMealFavourite: _isMealFavourite,
    );

    var activePageTitle = 'Categories';

    if (_selecetedPageIndex == 1) {
      activePage = MealsScreen(
        meals: _safeFavouriteMeals,
        onToggleFaviourite: _toggeMealFaviouriteStatus,
        isMealFavourite: _isMealFavourite,
      );
      activePageTitle = 'Your Faviourites';
    }

    return Scaffold(
      appBar: AppBar(title: Text(activePageTitle)),

      drawer: MainDrawer(onSelectScreen: _setScreen),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selecetedPageIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: 'Categories',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Faviourites'),
        ],
      ),
    );
  }
}
