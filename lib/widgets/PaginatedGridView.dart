import 'package:flutter/material.dart';

import '../model/PhotosResponse.dart';

class PaginatedGridView extends StatefulWidget {
  const PaginatedGridView({super.key});


  @override
  _PaginatedGridViewState createState() => _PaginatedGridViewState();
}

class _PaginatedGridViewState extends State<PaginatedGridView> {
  // Define variables for pagination
  int currentPage = 1;
  int itemsPerPage = 10;
  List<PhotosResponse> items = [];

  // Function to load more items
  void loadMoreItems() {
    // Simulated data loading. Replace this with your actual data loading logic.
    //List<PhotosResponse> newItems = List.generate(itemsPerPage, (index) => Item('Item ${items.length + index + 1}'));
    List<PhotosResponse> newItems = List.generate(itemsPerPage, (index) {
      // Generate a unique image URL for each item
      String imageUrl = 'https://example.com/image_$index.jpg';

      return PhotosResponse(imageurl: imageUrl);
    });
    setState(() {
      items.addAll(newItems);
      currentPage++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Paginated Grid View'),
      ),
      body: GridView.builder(
        itemCount: items.length + 1, // +1 for loading indicator
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 4.0,
          mainAxisSpacing: 4.0,
        ),
        itemBuilder: (context, index) {
          if (index < items.length) {
            return GridTile(
              child: Image.asset(items[index].imageurl),
            );
          } else {
            loadMoreItems(); // Load more items when reaching the end
            return const Center(
              child: CircularProgressIndicator(), // Loading indicator
            );
          }
        },
      ),
    );
  }
}
