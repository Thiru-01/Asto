import 'package:asto/model/model.dart';
import 'package:firebase_database/firebase_database.dart';

class RealtimeServices {
  final DatabaseReference ref = FirebaseDatabase.instance.ref().child("Rooms");

  void setData(DataModel data) {
    ref.set(data.toJson());
  }

  Future<DataModel> getData() async {
    DataModel data = await ref.once().then((value) {
      Map<String, dynamic> v =
          Map<String, dynamic>.from(value.snapshot.value! as Map);
      DataModel data = dataModelFromJson(v);
      return data;
    });

    return data;
  }
}
