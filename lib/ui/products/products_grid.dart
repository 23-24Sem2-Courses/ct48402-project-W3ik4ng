import 'package:ct484_project/models/product.dart';
import 'package:ct484_project/ui/products/product_grid_tile.dart';
import 'package:ct484_project/ui/products/products_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductsGrid extends StatefulWidget {
  const ProductsGrid({Key? key}) : super(key: key);

  @override
  State<ProductsGrid> createState() => _ProductsGridState();
}

class _ProductsGridState extends State<ProductsGrid> {
  late _MySearchDelegate _delegate;
  late Future<void> _fetchProducts;

  @override
  void initState() {
    super.initState();
    _delegate = _MySearchDelegate(<String>[]);
    _fetchProducts = context.read<ProductsManager>().fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    final products = context.select<ProductsManager, List<Product>>(
      (productsManager) => productsManager.items,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Search'), // Set the title of the AppBar
        actions: [
          IconButton(
            onPressed: () async {
              final selectedProduct = await showSearch<String>(
                context: context,
                delegate: _delegate,
              );
              // Handle the selected product here
            },
            icon: const Icon(Icons.search), // Add search icon
          ),
        ],
      ),
      body: Container(
        color: Colors.grey,
        child: Container(
          color: Colors.white70,
          child: FutureBuilder(
            future: _fetchProducts,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return GridView.builder(
                  padding: const EdgeInsets.all(10.0),
                  itemCount: products.length,
                  itemBuilder: (context, index) =>
                      ProductGridTile(products[index]),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 3 / 4,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _MySearchDelegate extends SearchDelegate<String> {
  final List<String> _words;
  final List<String> _history;

  _MySearchDelegate(List<String> words)
      : _words = words,
        _history = <String>['apple', 'hello', 'world', 'flutter'],
        super();

  // Leading icon in search bar.
  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      tooltip: 'Back',
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        // SearchDelegate.close() can return values, similar to Navigator.pop().
        close(context, '');
      },
    );
  }

  // Widget of result page.
  // Widget of result page.
  @override
  Widget buildResults(BuildContext context) {
    final List<Product> filteredProducts = _words
        .where((title) => title.contains(query))
        .map((title) => Product(
              title: title,
              description: "", // Fill with appropriate description if available
              price: 0.0, // Fill with appropriate price if available
              imageUrl: "", // Fill with appropriate imageUrl if available
            ))
        .toList();

    return Container(
      color: Colors.grey,
      child: GridView.builder(
        padding: const EdgeInsets.all(10.0),
        itemCount: filteredProducts.length,
        itemBuilder: (context, index) =>
            ProductGridTile(filteredProducts[index]),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 4,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
      ),
    );
  }

  // Suggestions list while typing (this.query).
  @override
  Widget buildSuggestions(BuildContext context) {
    final Iterable<String> suggestions = this.query.isEmpty
        ? _history
        : _words.where((word) => word.startsWith(query));

    return _SuggestionList(
      query: this.query,
      suggestions: suggestions.toList(),
      onSelected: (String suggestion) {
        this.query = suggestion;
        this._history.insert(0, suggestion);
        showResults(context);
      },
    );
  }

  // Action buttons at the right of search bar.
  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      if (query.isEmpty)
        IconButton(
          tooltip: 'Voice Search',
          icon: const Icon(Icons.mic),
          onPressed: () {
            this.query = 'TODO: implement voice input';
          },
        )
      else
        IconButton(
          tooltip: 'Clear',
          icon: const Icon(Icons.clear),
          onPressed: () {
            query = '';
            showSuggestions(context);
          },
        )
    ];
  }
}

// Suggestions list widget displayed in the search page.
class _SuggestionList extends StatelessWidget {
  const _SuggestionList(
      {required this.suggestions,
      required this.query,
      required this.onSelected});

  final List<String> suggestions;
  final String query;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme.titleMedium!;
    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (BuildContext context, int i) {
        final String suggestion = suggestions[i];
        return ListTile(
          leading: query.isEmpty ? const Icon(Icons.history) : const Icon(null),
          // Highlight the substring that matched the query.
          title: RichText(
            text: TextSpan(
              text: suggestion.substring(0, query.length),
              style: textTheme.copyWith(fontWeight: FontWeight.bold),
              children: <TextSpan>[
                TextSpan(
                  text: suggestion.substring(query.length),
                  style: textTheme,
                ),
              ],
            ),
          ),
          onTap: () {
            onSelected(suggestion);
          },
        );
      },
    );
  }
}
