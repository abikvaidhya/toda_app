import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:toda_app/model/product_group_model.dart';
import 'package:toda_app/model/product_model.dart';
import '../model/base_unit_model.dart';
import '../model/cart_model.dart';
import '../view/screens/home_screen.dart';
import '../view/screens/login_screen.dart';

class SupabaseController extends GetxController {
  Supabase supabase = Supabase.instance;
  RxBool fetchingItems = true.obs,
      fetchingCategories = true.obs,
      fetchingOffers = true.obs,
      fetchingVendors = true.obs;

  // check user session status
  checkUserStatus() {
    supabase.client.auth.onAuthStateChange.listen((AuthState authState) {
      if (authState.session == null) {
        debugPrint('>> User session expired!');
        Get.offAll(() => LoginScreen());
      } else if (authState.session!.isExpired) {
        supabase.client.auth.reauthenticate();
      } else {
        Get.offAll(() => HomeScreen());
      }
    });
  }

  // fetch authenticated user
  User? get getUser => supabase.client.auth.currentUser;

  // login user
  Future<AuthResponse> login({required String id, required String password}) =>
      supabase.client.auth
          .signInWithPassword(email: id, password: password)
          .catchError((e) {
        throw e.message;
      });

  // change user phone number
  Future<UserResponse> updateUserPhone({required String phoneNumber}) async =>
      await supabase.client.auth
          .updateUser(
            UserAttributes(
              phone: phoneNumber,
            ),
          )
          .catchError((e) => throw e.message);

  // change user email
  Future<UserResponse> updateUserEmail({required String email}) async =>
      await supabase.client.auth
          .updateUser(
            UserAttributes(
              email: email,
            ),
          )
          .catchError((e) => throw e.message);

  // logout user
  logoutUser() => supabase.client.auth.signOut();

  // fetch dashboard items
  Future get getDashboardProducts =>
      supabase.client.from('products').select().limit(8);

  // stream dashboard items
  Stream get getDashboardProductStream => supabase.client
      .from('products')
      .stream(primaryKey: ['id'])
      .limit(8)
      .map((data) => data.map((e) => Product.fromJson(e)).toList());

  // fetch item list
  Future get getAllProducts => supabase.client.from('products').select();

  // stream item list
  Stream get getAllProductStream =>
      supabase.client.from('products').stream(primaryKey: ['id']).map(
          (data) => data.map((e) => Product.fromJson(e)).toList());

  // fetch offer item list
  Future get getOfferProducts =>
      supabase.client.from('products').select().eq('offer', true);

  // stream offer item list
  Stream get getOfferProductStream => supabase.client
      .from('products')
      .stream(primaryKey: ['id'])
      .eq('offer', true)
      .map((data) => data.map((e) => Product.fromJson(e)).toList());

  // fetch category list
  Future get getProductGroups => supabase.client.from('group').select();

  // stream category list
  Stream get getProductGroupStream =>
      supabase.client.from('group').stream(primaryKey: ['id']).map(
          (data) => data.map((e) => ProductGroup.fromJson(e)).toList());

  // fetch base units
  Future get getBaseUnits => supabase.client.from('base_units').select();

  // stream base unit
  Stream get getBaseUnitStream =>
      supabase.client.from('base_units').stream(primaryKey: ['id']).map(
          (data) => data.map((e) => BaseUnit.fromJson(e)).toList());

  // fetch suppliers list
  Future get getSuppliers => supabase.client.from('suppliers').select();

  // stream suppliers list
  Stream get getSupplierStream =>
      supabase.client.from('suppliers').stream(primaryKey: ['id']).map(
          (data) => data.map((e) => Product.fromJson(e)).toList());

  // fetch cart items
  Future get getCartData => supabase.client
      .from('cart')
      .select()
      .eq('customer_id', getUser!.id)
      .limit(1)
      .single();

  // stream cart items
  Stream get getCartStream => supabase.client
      .from('cart')
      .stream(primaryKey: ['id'])
      .eq('customer_id', getUser!.id)
      .limit(1)
      .map((data) => data.map((e) => Cart.fromJson(e)).toList());

  // create new cart
  createNewCart({required Cart cart}) async => await supabase.client
      .from('cart')
      .insert(cart.toJson().toString())
      .catchError((e) => throw e);

  // update cart
  updateCart({
    required Cart cart,
  }) async =>
      await supabase.client
          .from('cart')
          .update({
            'items': cart.items.toString(),
            'total_amount': cart.totalAmount.toStringAsFixed(2),
          })
          .eq('customer_id', cart.customerId)
          .catchError((e) => throw e);

  // delete cart
  deleteCart({required int id}) async => await supabase.client
      .from('cart')
      .delete()
      .eq('customer_id', id)
      .catchError((e) => throw e);
}
