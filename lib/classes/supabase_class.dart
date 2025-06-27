
import 'package:supabase_flutter/supabase_flutter.dart';

class SB {
  Supabase supabase = Supabase.instance;

  SB._(); // create singleton

  static final instance = SB._(); // instantiate singleton class

}
