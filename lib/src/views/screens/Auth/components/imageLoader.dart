import 'package:flutter/material.dart';

class ImageLoader extends StatelessWidget {
  const ImageLoader({
    Key key,
    @required this.image,
  }) : super(key: key);
  final String image;

  @override
  Widget build(BuildContext context) {
    return FadeInImage(
      placeholder: AssetImage("assets/images/loading.gif"),
      image: AssetImage(image),
      fadeInDuration: Duration(seconds: 2),
      fit: BoxFit.contain,
    );
  }
}
