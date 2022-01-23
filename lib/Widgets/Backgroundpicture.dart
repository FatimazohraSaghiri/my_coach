



import 'package:flutter/cupertino.dart';

class BackgroundWidget extends StatelessWidget {
  const BackgroundWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:const BoxDecoration(
        image: DecorationImage(
          image:AssetImage('assets/Background.jpg'),
          fit:BoxFit.cover,
        ),
      ),

    );
  }
}