import 'package:barber/models/user_model.dart';
import 'package:firebase_database/firebase_database.dart';

class FirebaseService {
  FirebaseDatabase db = FirebaseDatabase.instance;

  Future<void> register(UserModel model) async {
    DatabaseReference ref = db.ref('users/${model.name}');
    ref.once().then((value) async => {
          if (value.snapshot.value == null)
            {
              await ref.set({
                'name': model.name,
                'phone': model.phone,
              }).catchError((error) {})
            }
        });
  }
  Future<bool> login(UserModel model) async {
    DatabaseReference ref = db.ref('users/${model.name}');
    DataSnapshot snapshot = await ref.get();
    Map? info = snapshot.value as Map?;
    if(info == null) {
      return false;
    }
    return info['phone'] == model.phone;

  }
}
