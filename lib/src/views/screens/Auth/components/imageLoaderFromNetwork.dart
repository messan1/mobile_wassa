import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class ImageLoaderFromNetwork extends StatelessWidget {
  const ImageLoaderFromNetwork({
    Key key,
    @required this.image,
  }) : super(key: key);
  final String image;

  @override
  Widget build(BuildContext context) {
    return FadeInImage(
      placeholder: AssetImage("assets/images/loading.gif"),
      image: ExtendedNetworkImageProvider(image),
      fadeInDuration: Duration(seconds: 2),
      fit: BoxFit.contain,
    );
  }
}
