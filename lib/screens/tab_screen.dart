import 'package:deli_meals_app/models/meal.dart';
import 'package:deli_meals_app/screens/categories_screen.dart';
import 'package:deli_meals_app/screens/favorites_screen.dart';
import 'package:deli_meals_app/widgets/main_drawer.dart';
import 'package:flutter/material.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({Key? key, required this.favoriteMeals})
      : super(key: key);
  final List<Meal> favoriteMeals;
  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  late final List<Map<String, Object>> _pages;

  @override
  void initState() {
    _pages = [
      {'page': const CategoriesScreen(), 'title': 'Categories'},
      {
        'page': FavoritesScreen(favoriteMeals: widget.favoriteMeals),
        'title': 'Youre Favorites'
      },
    ];
    super.initState();
  }

  int _selectedPage = 0;
  void _selectPage(int index) {
    setState(() {
      _selectedPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_pages[_selectedPage]['title'] as String)),
      drawer: const MainDrawer(),
      body: _pages[_selectedPage]['page'] as Widget,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        selectedItemColor: Theme.of(context).colorScheme.secondary,
        // unselectedItemColor: Colors.white,
        currentIndex: _selectedPage,
        // type: BottomNavigationBarType.shifting, // effect
        items: const [
          BottomNavigationBarItem(
            // backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.category),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            // backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.star),
            label: 'Favorites',
          ),
        ],
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
    // DefaultTabController( // Top tab controller
    //   length: 2,
    //   // initialIndex: 0,
    //   child: Scaffold(
    //     appBar: AppBar(
    //       title: const Text('Meals'),
    //       bottom: const TabBar(
    //         tabs: [
    //             Tab(
    //                 icon: Icon(Icons.category),
    //                 text: 'Categories',
    //               ),
    //             Tab(
    //               icon: Icon(Icons.star),
    //               text: 'Favorites',
    //             ),
    //           ]
    //       ),
    //     ),
    //     body: const TabBarView(children: [
    //       CategoriesScreen(),
    //       FavoritesScreen(),
    //     ],)
    //   ),
    // );
  }
}
