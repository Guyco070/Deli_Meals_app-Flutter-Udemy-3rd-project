import 'package:deli_meals_app/models/meal.dart';
import 'package:deli_meals_app/widgets/meal_item.dart';
import 'package:flutter/cupertino.dart';

class FavoritesScreen extends StatelessWidget {
  FavoritesScreen({Key? key, required this.favoriteMeals})
      : super(key: key);
  List<Meal> favoriteMeals;
  
  @override
  Widget build(BuildContext context) {
    return Center(
      child: favoriteMeals.isEmpty ? const Padding(
        padding: EdgeInsets.all(8.0),
        child: FittedBox(
          child: Text(
              'You have no favorites yet - start adding some!',
            ) ,
        ),
      ) : 
        ListView(
          children: favoriteMeals.map((meal) => MealItem(
            id: meal.id, 
            title: meal.title, 
            imageUrl: meal.imageUrl, 
            duration: meal.duration, 
            complexity: meal.complexity, 
            affordability: meal.affordability, 
            removeItem: (value) {})
          ).toList(),
        ),
    );
  }
}
