import 'package:digitalMenu/Bloc/storeBloc.dart';
import 'package:digitalMenu/Model/shopData.dart';
import 'package:digitalMenu/Model/userData.dart';
import 'package:digitalMenu/UI/Widget/qrCodeGenerator.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class AccountScreen extends StatefulWidget {
  final StoreBloc storeBloc;
  AccountScreen({@required this.storeBloc});
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Account"),
        centerTitle: true,
      ),
      body: StreamBuilder<ShopData>(
        stream: widget.storeBloc.storeStream,
        initialData: widget.storeBloc.getShop,
        builder: (context, shop) {
          return StreamBuilder<UserData>(
            stream: widget.storeBloc.userStream,
            initialData: widget.storeBloc.getUser,
            builder: (context, snapshot) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: <Widget>[
                            TextFormField(
                              initialValue: snapshot.data.email,
                              readOnly: true,
                              decoration: InputDecoration(
                                labelText: "Email ID:",
                              ),
                              keyboardType: TextInputType.text,
                            ),
                            TextFormField(
                              readOnly: true,
                              initialValue: snapshot.data.name,
                              decoration: InputDecoration(
                                labelText: "Name:",
                              ),
                              keyboardType: TextInputType.text,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    readOnly: true,
                                    initialValue: shop.data.shopName,
                                    decoration: InputDecoration(
                                      labelText: "Shop Name:",
                                    ),
                                    keyboardType: TextInputType.text,
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(Icons.done),
                                  onPressed: () {},
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => QRGenerator(
                                  storeCode: shop.data.storeId,
                                  storeName: shop.data.shopName,
                                ),
                              ),
                            );
                          },
                          title: Text("Get Your Store QR code"),
                          subtitle: Text(
                              "Customer can scan this to see your menu card"),
                          trailing: Icon(LineIcons.arrow_circle_o_right),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
