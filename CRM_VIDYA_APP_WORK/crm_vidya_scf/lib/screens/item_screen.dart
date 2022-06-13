import 'package:crm_vidya_scf/screens/seller_screen.dart';
import 'package:crm_vidya_scf/widgets/seller_item.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'cart.dart';
import '../services/servicehandle.dart';
import '../models/item.dart';
import '../widgets/item_item.dart';
import '../models/items_screen_args.dart';

class ItemScreen extends StatefulWidget {
  static const routeName = '/item_screen';

  const ItemScreen({Key? key}) : super(key: key);

  @override
  State<ItemScreen> createState() => _ItemScreenState();
}

class _ItemScreenState extends State<ItemScreen> {
  TextEditingController _searchQueryController = TextEditingController();
  bool _isSearching = false;
  String searchQuery = "Search query";

  List<Color> sellerItemsBackgroundColor = [];

  final List<Item> _cartList = [];

  List<Map<String, String>> new_list = [];

  final TextEditingController _search = TextEditingController();

  List<Item> filteredItem = [];

  @override
  void initState() {
    super.initState();

    sellerItemsBackgroundColor.add(const Color(0xffd3ebfc));
    sellerItemsBackgroundColor.add(const Color(0xffa3d9f1));
    sellerItemsBackgroundColor.add(const Color(0xff66BEE6));
    sellerItemsBackgroundColor.add(const Color(0xffa3d9f1));

    // ServerHandler().getItems(); //.then((value) => null);
  }

  addItemToCart(item) {
    setState(() {
      new_list.add(item);
    });
  }

  getNewCart(new_card) {
    setState(() {
      new_list = new_card;
    });
  }

  void onFilter(String value, List items) {
    List<Item> newItems = [];
    List<String> filterArray = value.toUpperCase().split("");
    if (filterArray.isNotEmpty && items.isNotEmpty && _search.text.isNotEmpty) {
      for (var item in items) {
        if (item.ItemName[0] == filterArray[0]) {
          newItems.add(item);
        }
      }
    }
    setState(() {
      filteredItem = newItems;
    });
  }

  @override
  Widget build(BuildContext context) {
    ItemScreenArguments items =
        ModalRoute.of(context)!.settings.arguments as ItemScreenArguments;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Select Item",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => ServerHandler()
            ..getSellers()
                .then((value) => Navigator.of(context)
                    .popAndPushNamed(SellerScreen.routeName, arguments: value))
                .catchError((e) => print(e)),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 16.0, top: 8.0),
            child: GestureDetector(
              child: Stack(
                alignment: Alignment.topCenter,
                children: <Widget>[
                  const Icon(
                    Icons.shopping_cart,
                    size: 36.0,
                  ),
                  if (new_list.length > 0)
                    Padding(
                      padding: const EdgeInsets.only(left: 2.0),
                      child: CircleAvatar(
                        radius: 8.0,
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        child: Text(
                          new_list.length.toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12.0,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Cart(
                              onGetCart: (cart) => getNewCart(cart),
                              cart: new_list,
                              seller: items.seller,
                            )));
              },
            ),
          )
        ],
      ),
      body: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.only(
                  left: 30.0,
                  right: 30.0,
                  top: 15.0,
                  bottom: 10.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      items.seller,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 18.0,
                        color: const Color(0xff4E8489),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _search,
                  onChanged: (value) => onFilter(value, items.values),
                  style: const TextStyle(fontSize: 15.0),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Search',
                    prefixIcon: const Icon(Icons.search),
                    contentPadding: const EdgeInsets.only(
                        left: 14.0, bottom: 12.0, top: 0.0),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.red),
                      borderRadius: BorderRadius.circular(25.7),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(25.7),
                    ),
                  ),
                ),
              ),
              // list of sellers
              Column(
                  children: filteredItem.isEmpty
                      ? items.values
                          .map((e) => ItemItem(
                                username: items.seller,
                                item: e,
                                backgroundColor: sellerItemsBackgroundColor[
                                    items.values.indexOf(e) % 4],
                                onCardAdd: (item) {
                                  addItemToCart(item);
                                },
                              ))
                          .toList()
                      : filteredItem
                          .map((e) => ItemItem(
                                username: items.seller,
                                item: e,
                                backgroundColor: sellerItemsBackgroundColor[
                                    items.values.indexOf(e) % 4],
                                onCardAdd: (item) {
                                  addItemToCart(item);
                                },
                              ))
                          .toList()),
            ],
          ),
        ),
      ),
    );
  }
}
