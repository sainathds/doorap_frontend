import 'package:door_ap/common/resources/my_colors.dart';
import 'package:door_ap/common/resources/my_dimens.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomerFavouriteScreen extends StatefulWidget {
  const CustomerFavouriteScreen({Key? key}) : super(key: key);

  @override
  _CustomerFavouriteScreenState createState() => _CustomerFavouriteScreenState();
}

class _CustomerFavouriteScreenState extends State<CustomerFavouriteScreen> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        appBar: AppBar(
/*          leading: InkWell(
              onTap: (){
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back_ios)),*/
          elevation: 5,
          shadowColor: MyColor.textGrey,
          systemOverlayStyle: const SystemUiOverlayStyle(
            systemNavigationBarColor: MyColor.themeBlue, // Navigation bar
            statusBarColor: MyColor.themeBlue, // Status bar
          ),
          centerTitle: true,
          title: const Text(
            "Favourites",
            style: TextStyle(
                fontSize: MyDimens.textSize20,
                color: Colors.white,
                fontFamily: 'roboto_medium'),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 30.0),
              child: Icon(Icons.search),
            )
          ],
        ),
        body: Center(
          child: Text(
              "IN PROGRESS"
          ),
        ),
      ),
    );
  }
}
