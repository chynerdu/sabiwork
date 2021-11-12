import 'package:flutter/material.dart';
import 'package:image_stack/image_stack.dart';

class StackedImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<String> images = [
      "https://faceofnigeria.org/wp-content/uploads/2020/02/avatar05.jpg",
      "https://miro.medium.com/max/500/1*tv9pIQPhwumDnYBfCoapYg.jpeg",
      "https://www.beautyafricana.com/upload/photos/2021/04/fYaUds2JFbmEmRijPyKc_10_f2b28681f4a63d3ff9e73a22a8bbcf40_avatar_full.jpeg",
      "https://www.section.io/engineering-education/authors/ezenagu-emmanuel/avatar_huf0aab70db05fa5458a6da2ad2c2b101d_267673_400x0_resize_box_2.png"
    ];
    return ImageStack(
      imageList: images,
      totalCount: images
          .length, // If larger than images.length, will show extra empty circle
      imageRadius: 25, // Radius of each images
      imageCount: 3, // Maximum number of images to be shown in stack
      imageBorderWidth: 2, // Border width around the images
    );
  }
}
