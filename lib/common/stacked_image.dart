import 'dart:math';

import 'package:flutter/material.dart';
import 'package:image_stack/image_stack.dart';

class StackedImage extends StatelessWidget {
  final int? count;
  StackedImage({this.count});
  @override
  Widget build(BuildContext context) {
    List<String> stackedImages = [];
    List<String> images = [
      "https://cdn2.vectorstock.com/i/1000x1000/07/06/cute-boy-face-cartoon-vector-20130706.jpg",
      "https://www.pngitem.com/pimgs/m/576-5768840_cartoon-man-png-avatar-transparent-png.png",
      "https://static.vecteezy.com/system/resources/previews/002/275/816/original/cartoon-avatar-of-smiling-beard-man-profile-icon-vector.jpg",
      "https://static.vecteezy.com/system/resources/previews/002/275/847/non_2x/male-avatar-profile-icon-of-smiling-caucasian-man-vector.jpg",
      "https://static.vecteezy.com/system/resources/previews/002/275/818/original/female-avatar-woman-profile-icon-for-network-vector.jpg",
      "https://safebake.xyz/img/9.jpg",
      "https://avatoon.me/wp-content/uploads/2021/09/Cartoon-Pic-Ideas-for-DP-Profile11.png",
      "https://avatoon.me/wp-content/uploads/2020/07/Cartoon-Pic-Ideas-for-DP-Profile-04.png",
      "https://gocartoonme.com/wp-content/uploads/cartoon-avatar.png",
      "https://i.pinimg.com/550x/f5/69/67/f56967d3bb848e5c48d96b90d0d4cd88.jpg"
      // "https://faceofnigeria.org/wp-content/uploads/2020/02/avatar05.jpg",
      // "https://miro.medium.com/max/500/1*tv9pIQPhwumDnYBfCoapYg.jpeg",
      // "https://www.beautyafricana.com/upload/photos/2021/04/fYaUds2JFbmEmRijPyKc_10_f2b28681f4a63d3ff9e73a22a8bbcf40_avatar_full.jpeg",
      // "https://www.section.io/engineering-education/authors/ezenagu-emmanuel/avatar_huf0aab70db05fa5458a6da2ad2c2b101d_267673_400x0_resize_box_2.png"
    ];
    // get random images based on image count;
    for (int i = 0; i < count!; i++)
      stackedImages.add(images[new Random().nextInt(images.length)]);

    return ImageStack(
      imageList: stackedImages,
      totalCount: stackedImages
          .length, // If larger than images.length, will show extra empty circle
      imageRadius: 20, // Radius of each images
      imageCount: count, // Maximum number of images to be shown in stack
      imageBorderWidth: 1, // Border width around the images
    );
  }
}
