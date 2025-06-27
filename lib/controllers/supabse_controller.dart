import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:toda_app/model/product_group_model.dart';
import 'package:toda_app/model/product_model.dart';
import 'package:toda_app/model/product_supplier_model.dart';
import '../model/base_unit_model.dart';
import '../model/cart_model.dart';
import '../model/order_model.dart';
import '../view/screens/home_screen.dart';
import '../view/screens/login_screen.dart';

class SupabaseController {
  Supabase supabase = Supabase.instance;

  SupabaseController._(); // create singleton

  static final instance = SupabaseController._(); // instantiate singleton class

}
