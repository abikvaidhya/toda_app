import 'package:get/get.dart';
import 'package:toda_app/controllers/supabse_controller.dart';
import 'package:toda_app/model/product_group_model.dart';

class ProductGroupController extends GetxController{
  SupabaseController supabaseController = SupabaseController.instance;

  // fetch category list
  Future get getProductGroups => supabaseController.supabase.client.from('group').select();

  // stream category list
  Stream get getProductGroupStream =>
      supabaseController.supabase.client.from('group').stream(primaryKey: ['id']).map(
              (data) => data.map((e) => getProductGroupFromJson(e)).toList());
}