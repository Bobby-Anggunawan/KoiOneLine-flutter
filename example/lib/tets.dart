import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {

    String display = "";

    return Scaffold(
      appBar: AppBar(title: Text("ikan"),),
      body: Column(
        children: [
          ElevatedButton(onPressed: ()async{

            var headers = {
              'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoxODI5LCJleHAiOjE3NTQxMTg0MjIsImlzcyI6InNhcmRhbmFncm91cC5jby5pZCIsImlhdCI6MTcyMjU4MjQyMn0.cQxJ_BePw9DpXuZjL2BeoI51s1YB-dCRltRQu7ATyD0',
              "Content-Type": "multipart/form-data; boundary=<calculated when request is sent>"
            };
            var request = http.MultipartRequest('POST', Uri.parse('http://localhost/my_web/mobileApp/public/api/clockin/kantor/ijin?lo=sa'));
            request.fields.addAll({
              'jenis': '4',
              'tanggal-dari': '10/07/2024',
              'tanggal-sampai': '02/08/2024',
              'alasan': 'sah diashdiaushdiu ahidhsa das dsa ',
              'posisi': 'jl. test ijin sakit no. 1'
            });

            FilePickerResult? result = await FilePicker.platform.pickFiles();

            print("panjang file adalah ${result!.files.single.bytes!.length}");
            request.files.add(http.MultipartFile.fromBytes('image_data', result.files.single.bytes!, filename: "image_data"));
            request.headers.addAll(headers);

            http.StreamedResponse response = await request.send();

            if (response.statusCode == 200) {
              print(await response.stream.bytesToString());
              display = await response.stream.bytesToString();
            }
            else {
              print(response.reasonPhrase);
              display = response.reasonPhrase ?? "error ------>";
            }

            setState(() {});
          }, child: Text("Test")),
          Text(display)
        ],
      ),
    );
  }
}
