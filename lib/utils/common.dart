import 'dart:convert';

import 'package:flutter/material.dart';


const primaryColor =Colors.pinkAccent;
const white = Color(0xffffffff);
const transparentREd = Color(0x70df0000);

const background = Color(0xFFf8f8f8);
//const accent = Color(0xFFED3134);
const darkText = Color(0xFF222222);
const lightText = Color(0xFF444444);
const lightGrey = Color(0xa0d8d8d8);
const mostlight = Color(0xFF999999);
const double bottomTabHeight = 45;
const statusBarColor = Color(0xffd8d8d8);
const lightestText = Color(0xFF767676);
const transparent = Color(0x00ffffff);
const transparentBlack = Color(0xa0000000);
const dividerColor = Color(0xffeeeeee);
String currency="\₹";
int badge=0;bool cartOnHold = false;
int itemToDelete = 0;
int cartCount = 0;
bool gettingCartId = false;
int updatingItemId = 0;
List cartTemporary = new List();
String storeIdInCart = "0";
String openedStoreId = "";
String openedStoreName = "";
void saveCartToLocal(dynamic image,dynamic price,dynamic id,dynamic quantity) async {
  if (storeIdInCart == "0" || cartTemporary.length == 0) {
    storeIdInCart = openedStoreId;
  }

  bool isAdded = false;
  for (var pro in cartTemporary) {
    if (id ==id) {
      pro[quantity] = pro[quantity] + 1;
      isAdded = true;
    }
  }

  if (!isAdded) {
    quantity = 1;
    //productData['storeName'] = openedStoreName;
    cartTemporary.add(image);
  }

  /* var preferences = await SharedPreferences.getInstance();
    //preferences.clear();
    //return;
    List<String> cartList = preferences.getStringList(savedCartList);
    try{
      int length = cartList.length;
      if(cartList.contains(productData))
      {
        return;
      }
      //print(length);
    }
    catch(e){
      cartList = new List();
    }
    bool isAdded = false;


      productData['quantity'] = 1;
      cartList.add(json.encode(productData.toString()));

    preferences.setStringList(savedCartList, cartList);
    print(cartList.length);*/
}

var p1badge = false;
const domainURL = 'https://aashya.com/';
String storeListingApi = domainURL+ "topStore/outlets/listing/1";
String profileApi = domainURL+ "topStore/outlets/byId/";
String StoriesApi = domainURL+ "topStore/stories/byId/";
String CategoriesApi = domainURL+ "topStore/categories/byId/";
String ProductsApi = domainURL+ "topStore/products/byId/";
String addstories = domainURL+ "topStore/stories/add";
String addCategories = domainURL+ "topStore/categories/add";
String deleteCategory = domainURL+ "topStore/categories/delete/";
String deleteProduct = domainURL+ "topStore/products/delete/";
String deleteStory = domainURL+ "topStore/stories/delete/";
String addProductApi = domainURL+ "topStore/products/add";
String addOutletApi = domainURL+ "topStore/outlets/add";
String editProductApi = domainURL+ "topStore/products/edit/";
String editcategory = domainURL+ "topStore/categories/edit/";
String editoutlet = domainURL+ "topStore/outlets/edit/";
String SingleproductAPi = domainURL+ "topStore/products/getproductById/";
String LoginApi = domainURL+ "topStore/user/login/";
String followOutlet = domainURL+ "topStore/user/followOutlet/";
String unfollowOutlet = domainURL+ "topStore/user/unfollowOutlet/";
String followRequest = domainURL+ "topStore/user/followRequests/";
String acceptRequest = domainURL+ "topStore/user/acceptRequest/";
String rejectRequest = domainURL+ "topStore/user/rejectRequest/";
String followersApi = domainURL+ "topStore/outlets/followers/";
String removeFollower = domainURL+ "topStore/outlets/removeFollower";
String userbyGroup = domainURL+ "topStore/outlets/userbyGroup";
String addtoGroupApi = domainURL+ "topStore/user/addtoGroup";
String removefromGroup = domainURL+ "topStore/outlets/removefromGroup";
String getuserprofile = domainURL+ "topStore/user/userbyId";
String createuserorder = domainURL+ "topStore/orders/createOrder";
String userorderapi = domainURL+ "topStore/orders/orderbyUser";
String outletorderapi = domainURL+ "topStore/orders/outletOrders";
String editprofileapi = domainURL+ "topStore/user/editProfile";
String editprofileimageapi = domainURL+ "topStore/user/editprofileImage";
String addAddressapi = domainURL+ "topStore/user/addaddress";
String useraddressesapi = domainURL+ "topStore/user/useraddresses";
String deleteaddressapi = domainURL+ "topStore/user/deleteaddress";
String editaddressapi = domainURL+ "topStore/user/editaddress";
String deletOutletapi = domainURL+ "topStore/outlets/delete";


