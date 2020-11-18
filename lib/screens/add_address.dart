import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopmatic_front/utils/common.dart';

import 'user_address.dart';

class addaddress extends StatefulWidget {
  @override
  addaddressState createState() => addaddressState();
// TODO: implement createState

}

class addaddressState extends State<addaddress> {
  String fName = '';
  String lName = '';
  String selected = "first";

  String zip = '';
  String streetAddress = '';
  String company = '';
  String email = '';
  String city = '';
  String state = '';
  String country = 'Panama';
  String phoneNumber = '';
  String comment = '';
  String priority = '';
  String dateString = '';
  final _formKey = GlobalKey<FormState>();
  bool isError = false;
  bool value4 = false;
  bool isLoading = false;
  bool ishuihi = false;

  String id = "";
  TextEditingController fnameController = new TextEditingController();
  TextEditingController lnameController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();
  TextEditingController cityController = new TextEditingController();
  TextEditingController stateController = new TextEditingController();
  TextEditingController pinController = new TextEditingController();
  TextEditingController streetController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: white,
          iconTheme: IconThemeData(color: darkText),
          title: Text("Add Address",style: TextStyle(color: darkText),),
        ),
        body: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                //margin: EdgeInsets.only(top: mapHeight),
                child: Form(
                  //key: _formKey,
                  child: ListView(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.fromLTRB(15, 10, 15, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    child: TextFormField(
                                      controller: fnameController,
                                      onChanged: (text) {
                                        //password = text;
                                        fName = text;
                                      },
                                      cursorColor: primaryColor,
                                      decoration: new InputDecoration(
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.grey, width: 1.0),
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        labelText: "First name",
                                        labelStyle:
                                            TextStyle(color: Colors.grey),
                                        fillColor: Colors.white,
                                        border: new OutlineInputBorder(
                                          borderRadius:
                                              new BorderRadius.circular(8.0),
                                          borderSide: new BorderSide(),
                                        ),
                                      ),
                                      validator: (val) {
                                        if (val.length == 0) {
                                          return "First name can not be empty";
                                        } else {
                                          return null;
                                        }
                                      },
                                      keyboardType: TextInputType.emailAddress,
                                      style: new TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    child: TextFormField(
                                      controller: lnameController,
                                      onChanged: (text) {
                                        //password = text;
                                        lName = text;
                                      },
                                      cursorColor: primaryColor,
                                      decoration: new InputDecoration(
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.grey, width: 1.0),
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        labelText: "Last name",
                                        labelStyle:
                                            TextStyle(color: Colors.grey),
                                        fillColor: Colors.white,
                                        border: new OutlineInputBorder(
                                          borderRadius:
                                              new BorderRadius.circular(8.0),
                                          borderSide: new BorderSide(),
                                        ),
                                      ),
                                      validator: (val) {
                                        if (val.length == 0) {
                                          return "Last name cannot be empty";
                                        } else {
                                          return null;
                                        }
                                      },
                                      keyboardType: TextInputType.emailAddress,
                                      style: new TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Container(
                              child: TextFormField(
                                onChanged: (text) {
                                  //password = text;
                                  streetAddress = text;
                                },
                                cursorColor: primaryColor,
                                decoration: new InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.grey, width: 1.0),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  labelText: "Street Address",
                                  labelStyle: TextStyle(color: Colors.grey),
                                  fillColor: Colors.white,
                                  border: new OutlineInputBorder(
                                    borderRadius:
                                        new BorderRadius.circular(8.0),
                                    borderSide: new BorderSide(),
                                  ),
                                ),
                                validator: (val) {
                                  if (val.length == 0) {
                                    return "Street Address cannot be empty";
                                  } else {
                                    return null;
                                  }
                                },
                                keyboardType: TextInputType.emailAddress,
                                style: new TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              child: TextFormField(
                                onChanged: (text) {
                                  //password = text;
                                  city = text;
                                },
                                cursorColor: primaryColor,
                                decoration: new InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.grey, width: 1.0),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  labelText: "City",
                                  labelStyle: TextStyle(color: Colors.grey),
                                  fillColor: Colors.white,
                                  border: new OutlineInputBorder(
                                    borderRadius:
                                        new BorderRadius.circular(8.0),
                                    borderSide: new BorderSide(),
                                  ),
                                ),
                                validator: (val) {
                                  if (val.length == 0) {
                                    return "City cannot be empty";
                                  } else {
                                    return null;
                                  }
                                },
                                keyboardType: TextInputType.emailAddress,
                                style: new TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            SizedBox(height: 14),
                            Text('State/Province',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 11,
                                )),
                            SizedBox(height: 10),
                            Container(
                              child: TextFormField(
                                onChanged: (text) {
                                  //password = text;
                                  state = text;
                                },
                                cursorColor: primaryColor,
                                decoration: new InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.grey, width: 1.0),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  labelText: "State",
                                  labelStyle: TextStyle(color: Colors.grey),
                                  fillColor: Colors.white,
                                  border: new OutlineInputBorder(
                                    borderRadius:
                                        new BorderRadius.circular(8.0),
                                    borderSide: new BorderSide(),
                                  ),
                                ),
                                validator: (val) {
                                  if (val.length == 0) {
                                    return "City cannot be empty";
                                  } else {
                                    return null;
                                  }
                                },
                                keyboardType: TextInputType.emailAddress,
                                style: new TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            /* Container(
                            child: TextFormField(
                              initialValue: savedPostalCode,
                              onChanged: (text) {
                                //password = text;
                                zip = text;
                              },
                              cursorColor: primaryColor,
                              decoration: new InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.grey, width: 1.0),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                
                                labelText: "Zip / Postal Code",
                                labelStyle: TextStyle(color: Colors.grey),
                                fillColor: Colors.white,
                                border: new OutlineInputBorder(
                                  borderRadius:
                                  new BorderRadius.circular(8.0),
                                  borderSide: new BorderSide(),
                                ),
                              ),
                              validator: (val) {
                                if (val.length == 0) {
                                  return "Zip/Postal Code cannot be empty";
                                } else {
                                  return null;
                                }
                              },
                              keyboardType: TextInputType.emailAddress,
                              style: new TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ),*/
                            SizedBox(height: 10),
                            Container(
                              child: TextFormField(
                                onChanged: (text) {
                                  //password = text;
                                  streetAddress = text;
                                },
                                cursorColor: primaryColor,
                                decoration: new InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.grey, width: 1.0),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  labelText: "Pin Code",
                                  labelStyle: TextStyle(color: Colors.grey),
                                  fillColor: Colors.white,
                                  border: new OutlineInputBorder(
                                    borderRadius:
                                        new BorderRadius.circular(8.0),
                                    borderSide: new BorderSide(),
                                  ),
                                ),
                                validator: (val) {
                                  if (val.length == 0) {
                                    return "Street Address cannot be empty";
                                  } else {
                                    return null;
                                  }
                                },
                                keyboardType: TextInputType.emailAddress,
                                style: new TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              child: TextFormField(
                                //controller: countryController,
                                onChanged: (text) {
                                  //password = text;
                                  country = text;
                                },
                                enabled: false,
                                initialValue: 'India',
                                cursorColor: primaryColor,
                                decoration: new InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.grey, width: 1.0),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  labelText: "Country",
                                  labelStyle: TextStyle(color: Colors.grey),
                                  fillColor: Colors.white,
                                  border: new OutlineInputBorder(
                                    borderRadius:
                                        new BorderRadius.circular(8.0),
                                    borderSide: new BorderSide(),
                                  ),
                                ),
                                validator: (val) {
                                  if (val.length == 0) {
                                    return "Country cannot be empty";
                                  } else {
                                    return null;
                                  }
                                },
                                keyboardType: TextInputType.emailAddress,
                                style: new TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              child: TextFormField(
                                controller: phoneController,
                                //controller: countryController,
                                keyboardType: TextInputType.number,
                                onChanged: (text) {
                                  //password = text;
                                  phoneNumber = text;
                                },
                                cursorColor: primaryColor,
                                decoration: new InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.grey, width: 1.0),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  labelText: "Phone number",
                                  labelStyle: TextStyle(color: Colors.grey),
                                  fillColor: Colors.white,
                                  border: new OutlineInputBorder(
                                    borderRadius:
                                        new BorderRadius.circular(8.0),
                                    borderSide: new BorderSide(),
                                  ),
                                ),
                                validator: (val) {
                                  if (val.length == 0) {
                                    return "Phone number cannot be empty";
                                  } else {
                                    return null;
                                  }
                                },
                                style: new TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text('  Address type',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 11,
                                )),
                            SizedBox(height: 5),
                            Row(
                              children: <Widget>[
                                GestureDetector(
                                  child: Container(
                                    margin: EdgeInsets.only(right: 10),
                                    padding: EdgeInsets.all(10.0),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(6.0),
                                        color: lightGrey,
                                        border: Border.all(
                                            color: selected == '1'
                                                ? Colors.blue
                                                : Colors.grey[300],
                                            width: 1)),
                                    child: Center(
                                        child: Text(
                                      "  Home  ",
                                      style: TextStyle(
                                          fontFamily: "proxima",
                                          color: darkText,
                                          fontSize: 16),
                                    )),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      selected = "1";
                                    });
                                  },
                                ),
                                GestureDetector(
                                  child: Container(
                                    margin: EdgeInsets.only(right: 10),
                                    padding: EdgeInsets.all(10.0),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(6.0),
                                        color: lightGrey,
                                        border: Border.all(
                                            color: selected == '2'
                                                ? Colors.blue
                                                : Colors.grey[300],
                                            width: 1)),
                                    child: Center(
                                        child: Text(
                                      "  Office  ",
                                      style: TextStyle(
                                          fontFamily: "proxima",
                                          color: darkText,
                                          fontSize: 16),
                                    )),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      selected = "2";
                                    });
                                  },
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: <Widget>[
                                Container(
                                  width: 50.0,
                                  child: Checkbox(
                                      checkColor: white,
                                      focusColor: Colors.blue,
                                      activeColor: Colors.pink,
                                      value: value4,
                                      onChanged: (val) {
                                        setState(() {
                                          value4 = val;
                                        });
                                      }),
                                ),
                                Text(
                                  "Use this Address as a permanent",
                                  style: TextStyle(
                                      color: darkText,
                                      fontFamily: "proxima",
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            GestureDetector(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0),
                                  color: Colors.black,
                                ),
                                width: MediaQuery.of(context).size.width,
                                child: RaisedButton(
                                    color: Colors.black,
                                    child: Center(
                                      child: Text(
                                        "Add Adress",
                                        style: TextStyle(
                                            color: white, fontSize: 16),
                                      ),
                                    )),
                              ),
                              onTap: () {
                                if(streetAddress.length==0){
return "street adress";
                                }
                                else{
                                print(selected);
                                if (value4 = true) {
                                  priority = "1";
                                } else {
                                  priority = "0";
                                }
                                addadress(
                                    streetAddress,
                                    city,
                                    phoneController.text,
                                    fnameController.text,
                                    state,
                                    selected,
                                    priority);}
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ));
  }

  dynamic productFromServer = new List();

  Future<void> addadress(String street, String city, String phone, String name,
      String state, String select, String priority) async {
    isLoading = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    id = prefs.getString('intValue');
    try {
      final response = await http.post(addAddressapi, body: {
        "user_id": id,
        "name": name,
        "phone": phone,
        "pin_code": "144001",
        "address": street,
        "city": city,
        "state": state,
        "address_type": select,
        "priority": priority
      });
      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);
        print(responseJson.toString() + "hello");

        productFromServer = responseJson;
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => alladdress()));

        setState(() {
          isError = false;
          isLoading = false;
          print('setstate');
        });
      } else {
        setState(() {
          isError = true;
          isLoading = false;
        });
      }
    } catch (e) {
      print("uhdfuhdfuh");
      setState(() {
        isError = true;
        isLoading = false;
      });
      // productFromServer = new List();

      // showToast('Something went wrong');
    }
  }
}
