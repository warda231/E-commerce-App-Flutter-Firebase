// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    final screenwidth = MediaQuery.of(context).size.width;
    final screenheight = MediaQuery.of(context).size.height;
    String currentCategory = "Sports"; // Default category
    final db = FirebaseFirestore.instance;

    return Scaffold(
      backgroundColor: Colors.yellow,
      body: Column(
        children: [
          StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection('Category').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                }
                var documents = snapshot.data?.docs;
                print('Category StreamBuilder rebuilt'); // Add this line

                return SizedBox(
                  height: 40,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: documents?.length,
                      itemBuilder: (context, index) {
                        var documentData = documents?[index].data();

                        var name = documentData?['Name'];

                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                currentCategory = name;
                                print('clicked');
                                print(
                                    'inside streamer$currentCategory'); // Update the current category
                              });
                            },
                            child: Container(
                              width: 70,
                              height: 30,
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 255, 248, 248),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(child: Text(name)),
                            ),
                          ),
                        );
                      }),
                );
              }),
          StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('Products')
                  .where('Category', isEqualTo: currentCategory)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                }
                var documents = snapshot.data?.docs;
                print('Category 2nd StreamBuilder rebuilt'); // Add this line

                return GridView.builder(
                        key: UniqueKey(), // Add a unique key to force rebuild

                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisSpacing: 8.0,
                      crossAxisSpacing: 8.0,

                      crossAxisCount: 2, // Two containers per row
                    ),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: documents?.length,
                    itemBuilder: (context, index) {
                      var documentData = documents?[index].data();
                      var name = documentData?['Name'];
                      var img = documentData?['Image'];
                      var price = documentData?['Price'];

                      return Column(
                        children: [
                          Container(
                            height: screenheight * 0.20,
                            width: screenwidth * 0.4,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                              child: Image.network(
                                img,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 8.0),
                            child: Column(
                              children: [
                                Text(
                                  name,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  'Price: \$${price}',
                                  style: TextStyle(
                                    fontSize: 20,
                                    // fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    });
              })
        ],
      ),
    );
  }
}
