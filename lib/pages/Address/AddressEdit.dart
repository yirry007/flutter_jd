import 'package:city_pickers/city_pickers.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jd/config/Api.dart';
import 'package:flutter_jd/services/EventBus.dart';
import 'package:flutter_jd/services/ScreenAdapter.dart';
import 'package:flutter_jd/services/SignServices.dart';
import 'package:flutter_jd/services/UserServices.dart';
import 'package:flutter_jd/widget/JDText.dart';
import 'package:flutter_jd/widget/MainButton.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddressEditPage extends StatefulWidget {
  Map? arguments;
  AddressEditPage({Key? key, this.arguments}) : super(key: key);

  @override
  State<AddressEditPage> createState() => _AddressEditPageState();
}

class _AddressEditPageState extends State<AddressEditPage> {
  String area = '';
  String name = '';
  String phone = '';
  String address = '';
  
  TextEditingController? nameController;
  TextEditingController? phoneController;
  TextEditingController? addressController;
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    nameController = TextEditingController.fromValue(TextEditingValue(
      text: widget.arguments!['name'],
      selection: TextSelection.fromPosition(TextPosition(
        affinity: TextAffinity.downstream,
        offset: widget.arguments!['name'].length,
      )),
    ));
    phoneController = TextEditingController.fromValue(TextEditingValue(
      text: widget.arguments!['phone'],
      selection: TextSelection.fromPosition(TextPosition(
        affinity: TextAffinity.downstream,
        offset: widget.arguments!['phone'].length,
      )),
    ));
    addressController = TextEditingController.fromValue(TextEditingValue(
      text: widget.arguments!['address'],
      selection: TextSelection.fromPosition(TextPosition(
        affinity: TextAffinity.downstream,
        offset: widget.arguments!['address'].length,
      )),
    ));

    name = widget.arguments!['name'];
    phone = widget.arguments!['phone'];
    address = widget.arguments!['address'];
  }

  //??????????????????????????????
  dispose(){
    super.dispose();
    eventBus.fire(AddressEvent(str: '??????????????????'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('??????????????????'),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            SizedBox(height: 20),
            JDText(
              text: '???????????????',
              controller: nameController,
              onChange: (value){
                name = value;
              },
            ),
            SizedBox(height: 30),

            JDText(
              text: '?????????????????????',
              controller: phoneController,
              onChange: (value){
                phone = value;
              },
            ),
            SizedBox(height: 20),

            Container(
              height: ScreenAdapter.height(100),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    width: 1,
                    color: Colors.black12,
                  ),
                ),
              ),
              child: InkWell(
                onTap: () async{
                  Result? result = await CityPickers.showCityPicker(
                    context: context,
                    //locationCode: '110000',//??????????????????????????????
                    cancelWidget: Text('??????', style: TextStyle(
                      color: Colors.amber,
                    )),
                    confirmWidget: Text('??????', style: TextStyle(
                      color: Colors.amber,
                    )),
                  );
                  
                  setState(() {
                    area = '${result!.provinceName} ${result.cityName} ${result.areaName}';
                  });
                },
                child: Row(
                  children: <Widget>[
                    Icon(Icons.add_location),
                    area.length > 0
                    ?Text('${area}', style: TextStyle(
                      color: Colors.black54
                    ))
                    :Text('???/???/???', style: TextStyle(
                      color: Colors.black54
                    )),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),

            JDText(
              text: '????????????',
              maxLine: 4,
              height: 180,
              controller: addressController,
              onChange: (value){
                address = value;
              },
            ),
            SizedBox(height: 50),

            MainButton(
              text: '??????',
              color: Colors.amber,
              onTap: () async{
                List userinfo = await UserServices.getUserInfo();

                Map tempJson = {
                  "uid": userinfo[0]['_id'],
                  "id": widget.arguments!['id'],
                  "name": name,
                  "phone": phone,
                  "address": address,
                  "salt": userinfo[0]['salt'],
                };

                String sign = SignService.getSign(tempJson);

                String api = Api.editAddress;
                var response = await Dio().post(api, data: {
                  "uid": userinfo[0]['_id'],
                  "id": widget.arguments!['id'],
                  "name": name,
                  "phone": phone,
                  "address": address,
                  "sign": sign,
                });

                if (!response.data['success']) {
                  Fluttertoast.showToast(
                    msg: "${response.data['message']}",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                  );
                  return;
                }

                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}