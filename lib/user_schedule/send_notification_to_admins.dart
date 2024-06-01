import 'package:http/http.dart' as http;
import 'dart:convert';

void sendNotificationToAdmins({required String day , required String weekIndex , required String title}){
  http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
      headers: <String, String>{
        "Content-Type": "application/json",
        "Authorization":
        "key=AAAAj0l0lGI:APA91bGDvGwru1QrWL4aIBR__wRyhm4tntXTrnH9uw2jiomRk7lVbVR5_gyUH8Bzitp_A4ZvNsWYKdKJIHcgqvQ1YnyCwbhRaw24298BS9qt0brrjtwYx-fNvdcHCNpPzud2sRMiDXHu"
      },
      body: jsonEncode({
        "to": "/topics/admins",
        "notification": {
          "title": "Suggestion",
          "body": "someone made a suggestion on\n"
                  "$title\n"
                  "$day of week $weekIndex",
          "mutable_content": true
        }
      })); // http request
}