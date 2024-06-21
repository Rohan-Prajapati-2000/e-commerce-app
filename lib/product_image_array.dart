import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImageListViewArray extends StatelessWidget {
  final CollectionReference productsCollection =
  FirebaseFirestore.instance.collection('productsDetail');

  Future<List<dynamic>> getAllImages() async {
    List<dynamic> allImages = [];

    QuerySnapshot querySnapshot = await productsCollection.get();
    querySnapshot.docs.forEach((doc) {
      List<dynamic> images = doc['images'];
      allImages.addAll(images);
    });

    return allImages;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getAllImages(),
      builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          return Container(
            height: 200, // Set a fixed height for the container
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                return Container(
                  width: 200,
                  margin: EdgeInsets.all(8), // Add margin for spacing between images
                  child: Image.network(
                    snapshot.data?[index],
                    fit: BoxFit.cover,
                  ),
                );
              },
            ),
          );
        }
      },
    );
  }
}
