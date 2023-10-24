// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

// ignore: must_be_immutable
class Home extends StatelessWidget {
  Home({super.key});

  List<String> imageList = [
    'https://mir-s3-cdn-cf.behance.net/project_modules/fs/635743100801015.5f1085a028fe8.png',
    'https://d1csarkz8obe9u.cloudfront.net/posterpreviews/bright-yellow-and-blue-sale-poster-design-template-30a74f34fa96db995b0ef5ee71ade4d0_screen.jpg?ts=1561428102',

    'https://d1csarkz8obe9u.cloudfront.net/posterpreviews/cosmetic-beauty-care-sale-design-template-22a955900dbc3a05acd32c16f3a6f8e6_screen.jpg?ts=1647849967' // Add more image paths here
  ];

  List<String> sndimageList = [
    'data:image/jpeg;base64,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',
    'https://fiverr-res.cloudinary.com/images/q_auto,f_auto/gigs2/267203710/original/26479da8b4d01700048b9dab171d2cad6af9282a/luxury-boutique-fashion-initial-letters-and-clothing-brand-logo.jpg',
    'https://fiverr-res.cloudinary.com/images/q_auto,f_auto/gigs/266261135/original/1025111eface7c4379ee374cafc8daef8e373a5a/design-luxury-fashion-clothing-brand-and-custom-minimalist-logo-design.jpg',
  ];

  List<IconData> iconList = [
    Icons.man,
    Icons.woman,
    Icons.child_care,
    Icons.watch,
    Icons.smartphone_sharp,
    Icons.tv
  ];

  List<String> topsellerlists = [
    'Man',
    'Woman',
    'Kids',
    'Watches',
    'Mobile',
    'Electronics'
  ];
  @override
  Widget build(BuildContext context) {
    final screenwidth = MediaQuery.of(context).size.width;
    final screenheight = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          Colors.yellow,
          Color.fromARGB(255, 240, 227, 112),
          Colors.white,
        ], stops: [
          0.1,
          0.5,
          1.0
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        width: double.infinity,
        height: 1000,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: screenwidth * 0.95,
                  height: screenheight * 0.07,
                  child: TextField(
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Color.fromARGB(108, 158, 158, 158),
                      ),
                      hintText: 'Search...',
                      hintStyle: const TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                        fontStyle: FontStyle.normal,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    // onChanged: (){},
                  ),
                ),
              ),
            ),
            VxSwiper.builder(
              aspectRatio: 16 / 9,
              itemCount: imageList.length,
              itemBuilder: (context, index) {
                return Container(
                  width: screenwidth * 0.95,
                  height: screenheight * 0.25,
                  child: Image.network(
                    imageList[index],
                    fit: BoxFit.cover,
                  ),
                );
              },
              height: 150.0,
              enlargeCenterPage: true,
              autoPlay: true,
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Top Categories',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontStyle: FontStyle.italic,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: SizedBox(
                    height: 100,
                    width: screenwidth * 0.49,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: iconList.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 243, 237, 237),
                                    borderRadius: BorderRadius.circular(80),
                                  ),
                                  child: Center(
                                    child: Icon(
                                      iconList[index],
                                      size: 30,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(
                                  topsellerlists[index].toString(),
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )
                            ],
                          );
                        }),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            const Text(
              'Best Sellers',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontStyle: FontStyle.italic,
              ),
            ),
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('Products')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return CircularProgressIndicator();
                  }
                  var documents = snapshot.data?.docs;

                  return GridView.builder(
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
      ),
    );
  }
}
