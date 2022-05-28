import 'package:ecommerce_int2/utils/app_properties.dart';
import 'package:ecommerce_int2/data/repository/address.repository.dart';
import 'package:ecommerce_int2/screens/address/address_form.dart';
import 'package:ecommerce_int2/screens/select_card_page.dart';
import 'package:ecommerce_int2/services/address.controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddAddressPage extends StatelessWidget {
  final TextEditingController address = TextEditingController();
  final TextEditingController city = TextEditingController();

  Widget buildFinishButton(AddressController controller) => InkWell(
        onTap: () {
          controller.updateCurrentAddress(address.text, city.text);
          controller.submitAddress();
          Get.to(() => SelectCardPage());
        },
        child: Container(
          height: 80,
          width: Get.width / 1.5,
          decoration: BoxDecoration(
              gradient: mainButton,
              boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.16),
                  offset: Offset(0, 5),
                  blurRadius: 10.0,
                )
              ],
              borderRadius: BorderRadius.circular(9.0)),
          child: Center(
            child: Text("Finish",
                style: const TextStyle(
                    color: const Color(0xfffefefe),
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.normal,
                    fontSize: 20.0)),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddressController>(
      init: AddressController(Get.find<AddressRepository>()),
      builder: (controller) => Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          iconTheme: IconThemeData(color: darkGrey),
          title: Text(
            'Add Address',
            style: const TextStyle(
                color: darkGrey,
                fontWeight: FontWeight.w500,
                fontFamily: "Montserrat",
                fontSize: 18.0),
          ),
        ),
        body: LayoutBuilder(
          builder: (_, viewportConstraints) => SingleChildScrollView(
            child: ConstrainedBox(
              constraints:
                  BoxConstraints(minHeight: viewportConstraints.maxHeight),
              child: Container(
                padding: EdgeInsets.only(
                    left: 16.0,
                    right: 16.0,
                    bottom: MediaQuery.of(context).padding.bottom == 0
                        ? 20
                        : MediaQuery.of(context).padding.bottom),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      height: 100,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: false,
                          itemCount: controller.addresses.length,
                          itemBuilder: (BuildContext context, int index) {
                            final e = controller.addresses[index];
                            return GestureDetector(
                              onTap: () => controller.updateIndex(index),
                              child: Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Card(
                                    margin: EdgeInsets.symmetric(vertical: 8.0),
                                    color: index == controller.selectIndex
                                        ? yellow
                                        : Colors.white,
                                    elevation: 3,
                                    child: SizedBox(
                                        height: 100,
                                        width: 80,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: Image.asset(
                                                    'assets/icons/address_home.png'),
                                              ),
                                              Text(
                                                e.address ?? 'Add New Address',
                                                style: TextStyle(
                                                  fontSize: 8,
                                                  color: darkGrey,
                                                ),
                                                textAlign: TextAlign.center,
                                              )
                                            ],
                                          ),
                                        ))),
                              ),
                            );
                          }),
                    ),
                    AddAddressForm(
                        address: controller.selectedAddress,
                        addr: address,
                        city: city),
                    Center(child: buildFinishButton(controller))
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
