import 'package:deli_meals_app/dummy_data.dart';
import 'package:deli_meals_app/models/meal.dart';
import 'package:deli_meals_app/screens/filters_screen.dart';

import './screens/categories_screen.dart';
import './screens/category_meals_screen.dart';
import './screens/meal_detail_screen.dart';
import './screens/tab_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };

  List<Meal> _avalibleMeals = DUMMY_MEALS;
  List<Meal> _favoritedMeals = [];

  void setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;
      _avalibleMeals = DUMMY_MEALS.where((element) {
        if (_filters['gluten']! && !element.isGlutenFree) return false;
        if (_filters['lactose']! && !element.isLactoseFree) return false;
        if (_filters['vegan']! && !element.isVegan) return false;
        if (_filters['vegetarian']! && !element.isVegetarian) return false;

        return true;
      }).toList();
    });
  }

  void _toggleFavorite(String mealId) {
    int index = _favoritedMeals.indexWhere((element) => element.id == mealId);
    if (index == -1) {
      setState(() {
        _favoritedMeals
            .add(DUMMY_MEALS.firstWhere((element) => element.id == mealId));
      });
    } else {
      setState(() {
        _favoritedMeals.removeAt(index);
      });
    }
  }

  bool _isMeallFavorite(String id) {
    return _favoritedMeals.any((element) => element.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Deli Meals',
      theme: ThemeData(
          canvasColor: const Color.fromRGBO(250, 254, 229, 1),
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.pink)
              .copyWith(secondary: Colors.amber),
          primaryColor: Colors.pink,
          textTheme: ThemeData.light().textTheme.copyWith(
              bodyLarge: const TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              bodyMedium: const TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
                fontSize: 20,
                fontFamily: 'RobotoCondensed',
                fontWeight: FontWeight.w100,
              ),
              titleLarge: const TextStyle(
                fontSize: 20,
                fontFamily: 'RobotoCondensed',
                fontWeight: FontWeight.w100,
              ),
              titleMedium: const TextStyle(
                fontSize: 20,
                fontFamily: 'RobotoCondensed',
                fontWeight: FontWeight.bold,
              ),
              bodySmall: const TextStyle(
                fontSize: 20,
                fontFamily: 'RobotoCondensed',
                fontWeight: FontWeight.bold,
              ))),
      // home: const CategoriesScreen(),
      // initialRoute: '/',
      routes: {
        '/': (ctx) => TabScreen(
            favoriteMeals: _favoritedMeals),
        CategoryMealsScreen.routeName: (ctx) => CategoryMealsScreen(
              avalibleMeals: _avalibleMeals,
            ),
        MealDetailsScreen.routeName: (ctx) =>
            MealDetailsScreen(toggleFavorite: _toggleFavorite, isFavorite: _isMeallFavorite),
        FiltersScreen.routeName: (context) => FiltersScreen(
              currentFilters: _filters,
              saveFilters: setFilters,
            ),
      },
      // onGenerateRoute: (settings) {},
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (ctx) => const CategoriesScreen());
      },
    );
  }
}
