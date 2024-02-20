import 'package:flutter/material.dart';
import 'drawer.dart';
import 'nav.dart';

class ProductBox {
  final String name;
  final String image;

  ProductBox({
    required this.name,
    required this.image,
  });
}

class SecondPage extends StatefulWidget {
  final String searchQuery;

  SecondPage(this.searchQuery);

  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {

  final List<ProductBox> products = [
    ProductBox(
      name: "Movie 1",
      image: "assets/result1.jpeg",
    ),
    ProductBox(
      name: "Movie 2",
      image: "assets/result2.jpeg",
    ),
    ProductBox(
      name: "Movie 3",
      image: "assets/result3.jpeg",
    ),
    ProductBox(
      name: "Movie 4",
      image: "assets/result4.jpeg",
    ),
    ProductBox(
      name: "Movie 5",
      image: "assets/result5.jpeg",
    ),
    ProductBox(
      name: "Movie 6",
      image: "assets/result6.jpeg",
    ),
    ProductBox(
      name: "Movie 7",
      image: "assets/result7.jpeg",
    ),
    ProductBox(
      name: "Movie 8",
      image: "assets/result8.jpeg",
    ),
    ProductBox(
      name: "Movie 9",
      image: "assets/result9.jpeg",
    ),
    ProductBox(
      name: "Movie 10",
      image: "assets/result10.jpeg",
    ),
    ProductBox(
      name: "Movie 11",
      image: "assets/result11.jpeg",
    ),
    ProductBox(
      name: "Movie 12",
      image: "assets/result12.jpeg",
    ),
    ProductBox(
      name: "Movie 13",
      image: "assets/result13.jpeg",
    ),
];

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return MaterialApp(
      title: "CINEMATE",
      home: Scaffold(
        drawer: NavDrawer(),
        appBar: Bar(),
        backgroundColor: Colors.black,
//------------------------------------------------
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(35.0),
                child: Text("Result for:   ${widget.searchQuery}", 
                style: TextStyle(
                  color: Colors.white, 
                  fontSize: 30, 
                  fontFamily: 'EncodeSansCondensed'
                )),
              ),
              GridView.builder(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 0.5,
                  mainAxisSpacing: 70.0,
                ),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return ProductBoxWidget(product: products[index]);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProductBoxWidget extends StatelessWidget {
  final ProductBox product;

  ProductBoxWidget({required this.product});

  @override
  Widget build(BuildContext context) {
    // Get the screen size
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Calculate the responsive size for Image.asset
    double imageWidth = screenWidth * 0.25;
    double imageHeight = imageWidth * 1.50;

    return Container(
      // padding: EdgeInsets.all(1.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0), // Set the same border radius
            child: Image.asset(
              product.image,
              height: imageHeight,
              width: imageWidth,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            padding: EdgeInsets.all(1.0),
            color: Colors.black, // Set the color to red
            child: SizedBox(
              width: imageWidth,
              height: 40.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    product.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 15, // Set the font size here
                      fontFamily: 'EncodeSansCondensed',
                    )
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
