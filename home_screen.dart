import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'car_details_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('CarWatt - Home')),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('listings').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(child: CircularProgressIndicator());
          final listings = snapshot.data!.docs;
          return ListView.builder(
            itemCount: listings.length,
            itemBuilder: (context, index) {
              var data = listings[index].data() as Map<String, dynamic>;
              return ListTile(
                title: Text('${data['make']} ${data['model']}'),
                subtitle: Text('Price: \$${data['price']}'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CarDetailsScreen(
                          listingId: listings[index].id),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
