import 'package:deli_meals_app/widgets/main_drawer.dart';
import 'package:flutter/material.dart';

class FiltersScreen extends StatefulWidget {
  static const String routeName = '/filters';
  final Function saveFilters;
  final Map<String, bool> currentFilters;

  const FiltersScreen({Key? key, required this.currentFilters, required this.saveFilters})
      : super(key: key);

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _glutenFree = false;
  bool _lactoseFree = false;
  bool _vegan = false;
  bool _vegetarian = false;

  @override
  void initState() {
    _glutenFree = widget.currentFilters['gluten']!;
    _lactoseFree = widget.currentFilters['lactose']!;
    _vegan = widget.currentFilters['vegan']!;
    _vegetarian = widget.currentFilters['vegetarian']!;
    super.initState();
  }

  Widget _buildSwitchTile(
      String title, String subtitle, bool curValue, Function updateData) {
    return SwitchListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        value: curValue,
        onChanged: (newValue) => updateData(newValue));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filters'),
        actions: [
          IconButton(
              onPressed: () => 
              widget.saveFilters({
                  'gluten': _glutenFree,
                  'lactose': _lactoseFree,
                  'vegan': _vegan,
                  'vegetarian': _vegetarian,
                }), 
          icon: const Icon(Icons.save))
        ],
      ),
      drawer: const MainDrawer(),
      body: Container(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              child: Text(
                'Adjust your meal selection.',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  _buildSwitchTile(
                      'Gluten-Free',
                      'Only include gluten-free meals.',
                      _glutenFree,
                      (newValue) => setState(() {
                            _glutenFree = newValue;
                          })),
                  _buildSwitchTile(
                      'Lactose-Free',
                      'Only include lactose-free meals.',
                      _lactoseFree,
                      (newValue) => setState(() {
                            _lactoseFree = newValue;
                          })),
                  _buildSwitchTile(
                      'Vegan',
                      'Only include vegan meals.',
                      _vegan,
                      (newValue) => setState(() {
                            _vegan = newValue;
                          })),
                  _buildSwitchTile(
                      'Vegetarian',
                      'Only include vegetarian meals.',
                      _vegetarian,
                      (newValue) => setState(() {
                            _vegetarian = newValue;
                          })),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
