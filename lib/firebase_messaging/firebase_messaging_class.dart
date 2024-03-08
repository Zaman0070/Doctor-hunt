import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_app/models/firebase_message/firebase_messages_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_messaging/firebase_messaging.dart';

import 'constants/constants.dart';

class MessagingFirebase {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore store = FirebaseFirestore.instance;
  Future<bool> uploadFcmToken() async {
    try {
      String? token = await FirebaseMessaging.instance.getToken();
      await store
          .collection('register_id')
          .doc(token)
          .set(MessageModel(register_id: token).toJson());
      // await store.collection('register_id').doc(auth.currentUser?.uid).set(
      //     MessageModel(
      //         register_id: token
      //     ).toJson());

      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }
  Future<String> getFcmToken() async{
    try {
      String? token = await FirebaseMessaging.instance.getToken();
      if(token!=null) {
        return token;
      }else{
        return '';
      }
    } catch (e) {
      print(e.toString());
      return '';
    }
  }
// Notifications

  Future<bool> pushNotificationsSpecificDevice({
    required String token,
    required String title,
    required String body,
  }) async {
    String dataNotifications = '{ "to" : "$token",'
        ' "notification" : {'
        ' "title":"$title",'
        '"body":"$body"'
        ' }'
        ' }';

    try {
      await http.post(
        Uri.parse(Constants.BASE_URL),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'key= ${Constants.KEY_SERVER}',
        },
        body: dataNotifications,
      );
      print('Tapped');
    } catch (e) {
      print(e.toString());
    }
    return true;
  }

  Future<bool> pushNotificationsAllDevice({
    required String title,
    required String body,
    required List<String> registerIds,
  }) async {
    List<String> tempLst = [];
    for (var element in registerIds) {
      print(' "$element" ');
      tempLst.add(' "$element" ');
    }

    try {
      String dataNotifications = '{'
          '"operation": "create",'
          '"notification_key_name": "appUser-testUser",'
          '"registration_ids": $tempLst,'
          '"notification" : {'
          '"title":"$title",'
          '"body":"$body"'
          ' },'
          '}';

      var response = await http.post(
        Uri.parse(Constants.BASE_URL),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'key= ${Constants.KEY_SERVER}',
          'project_id': Constants.SENDER_ID
        },
        body: dataNotifications,
      );
      if (response.body.toString() ==
          '"registration_ids" field cannot be empty') {
        return false;
      } else {
        return true;
      }
    } catch (e) {
      return false;
    }
  }
  // For goup of people
  // Future<bool> pushNotificationsGroupDevice({
  //   required String title,
  //   required String body,
  //   required String destination,
  //   required String id,
  //   required List<String> registerIds,
  // }) async {
  //   List<String> tempLst = [];
  //   for (var element in registerIds) {
  //     // print(' "$element" ');
  //     tempLst.add(' "$element" ');
  //   }
  //
  //   try{
  //     String dataNotifications = '{'
  //         '"operation": "create",'
  //         '"notification_key_name": "appUser-testUser",'
  //         '"registration_ids": $tempLst,'
  //         '"notification" : {'
  //         '"title":"$title",'
  //         '"body":"$body"'
  //         ' },'
  //         '"data": {'
  //         '"screen": "$destination",'
  //         '"id": "$id",'
  //         '}'
  //         '}';
  //
  //
  //     var response = await http.post(
  //       Uri.parse(Constants.BASE_URL),
  //       headers: <String, String>{
  //         'Content-Type': 'application/json',
  //         'Authorization': 'key= ${Constants.KEY_SERVER}',
  //         'project_id': "${Constants.SENDER_ID}"
  //       },
  //       body: dataNotifications,
  //     );
  //     if(response.body.toString() == '"registration_ids" field cannot be empty'){
  //       return false;
  //     }else{
  //       print(response.body.toString());
  //       return true;
  //     }
  //
  //   }catch(e){
  //     print(e.toString());
  //     return false;
  //   }
  //
  //
  //   return true;
  // }

  Future<String> token() async {
    return await FirebaseMessaging.instance.getToken() ?? "";
  }

  List<String> ids = [];

  getRegisterIds() async {
    try {
      QuerySnapshot<Map<String, dynamic>> listOfData =
          await store.collection('register_id').get();
      for (int i = 0; i < listOfData.docs.length; i++) {
        listOfData.docs[i].data()['register_id'];
        ids.add(listOfData.docs[i].data()['register_id'].toString());
        // print(ids);
        // print('Hola');
      }
    } catch (e) {
      print(e);
    }
  }
}
