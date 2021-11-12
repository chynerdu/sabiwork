import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RatingBarComponent extends StatelessWidget {
  final double? initialRating;
  RatingBarComponent({this.initialRating});

  Widget build(BuildContext context) {
    return RatingBar.builder(
      initialRating: initialRating as double,
      minRating: 1,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: 5,
      itemSize: 12.0,
      itemPadding: EdgeInsets.symmetric(horizontal: 0.0),
      itemBuilder: (context, _) => Icon(
        Icons.star,
        color: Colors.amber,
      ),
      onRatingUpdate: (rating) {
        print(rating);
      },
    );
  }
}
