import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:image_picker_form_field/image_picker_form_field.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:tugas_akhir/screens/shopping_cart.dart';

final cloudinary =
    CloudinaryPublic("dvfyxrw6z", "custom_mask_preset", cache: false);

class BelajarForm extends StatefulWidget {
  const BelajarForm({Key? key}) : super(key: key);
  @override
  _BelajarFormState createState() => _BelajarFormState();
}

class _BelajarFormState extends State<BelajarForm> {
  final _formKey = GlobalKey<FormState>();

  double nilaiSlider = 1;
  bool nilaiCheckBox = false;
  bool nilaiSwitch = true;
  String? dropdownValue;
  String? dropdownValueSize;
  String? dropdownValueModel;
  String? dropdownValueColor;
  var valueType;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    hintText: "Sex",
                    labelText: "Sex",
                    icon: Icon(Icons.wc_outlined),
                  ),
                  value: dropdownValue,
                  icon: const Icon(Icons.arrow_downward),
                  iconSize: 24,
                  elevation: 16,
                  style: const TextStyle(color: Colors.black),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValue = newValue!;
                    });
                  },
                  validator: (value) =>
                      value == null ? 'Sex tidak boleh kosong!' : null,
                  items: <String>['Male', 'Female', 'Unisex']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    hintText: "Size",
                    labelText: "Size",
                    icon: Icon(Icons.format_size_outlined),
                  ),
                  value: dropdownValueSize,
                  icon: const Icon(Icons.arrow_downward),
                  iconSize: 24,
                  elevation: 16,
                  style: const TextStyle(color: Colors.black),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValueSize = newValue!;
                    });
                  },
                  validator: (value) =>
                      value == null ? 'Size tidak boleh kosong!' : null,
                  items: <String>['XL', 'L', 'M', 'S']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    hintText: "Model",
                    labelText: "Model",
                    icon: Icon(Icons.masks_outlined),
                  ),
                  value: dropdownValueModel,
                  icon: const Icon(Icons.arrow_downward),
                  iconSize: 24,
                  elevation: 16,
                  style: const TextStyle(color: Colors.black),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValueModel = newValue!;
                    });
                  },
                  validator: (value) =>
                      value == null ? 'Model tidak boleh kosong!' : null,
                  items: <String>['SURGICAL', 'SPONGE', 'PITTA', 'CLOTH']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    hintText: "Color",
                    labelText: "Color",
                    icon: Icon(Icons.palette_outlined),
                  ),
                  value: dropdownValueColor,
                  icon: const Icon(Icons.arrow_downward),
                  iconSize: 24,
                  elevation: 16,
                  style: const TextStyle(color: Colors.black),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValueColor = newValue!;
                    });
                  },
                  validator: (value) =>
                      value == null ? 'Warna tidak boleh kosong!' : null,
                  items: <String>['RED', 'GREEN', 'BLUE', 'BLACK']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
              ImagePickerFormField(
                child: Container(
                  height: 40,
                  child: Center(child: Text("Select Photo")),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      border: Border.all(
                          color: Theme.of(context).disabledColor, width: 1)),
                ),
                previewEnabled: false,
                autovalidate: true,
                context: context,
                onSaved: (File value) {
                  valueType = value;
                  print("on saved called");
                },
                validator: (File value) {
                  if (value == null)
                    return "Please select a photo!";
                  else
                    return null;
                },
                initialValue: null, //File("some source")
              ),
              SizedBox(
                height: 20,
              ),
              ButtonTheme(
                minWidth: 200.0,
                height: 50.0,
                child: RaisedButton(
                  child: Text(
                    "Add to Chart",
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.black,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16.0))),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      showDialog(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                                title: const Text("Konfirmasi Pesananmu!"),
                                content: Text("Sex: " +
                                    dropdownValue! +
                                    "\n" +
                                    "\n" +
                                    "Size: " +
                                    dropdownValueSize! +
                                    "\n" +
                                    "\n" +
                                    "Model: " +
                                    dropdownValueModel! +
                                    "\n" +
                                    "\n" +
                                    "Color: " +
                                    dropdownValueColor! +
                                    "\n" +
                                    "\n" +
                                    "Type: " +
                                    valueType.toString()),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, 'Cancel'),
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                      child: const Text('Ok'),
                                      onPressed: () async {
                                        try {
                                          final cldRsp =
                                              await cloudinary.uploadFile(
                                                  CloudinaryFile.fromFile(
                                                      valueType!.path
                                                          .toString(),
                                                      resourceType:
                                                          CloudinaryResourceType
                                                              .Image));

                                          final response = await http.post(
                                              Uri.parse(
                                                  'https://pbp-c07.herokuapp.com/add_custom/'),
                                              headers: <String, String>{
                                                'Content-Type':
                                                    'application/json; charset=UTF-8'
                                              },
                                              body:
                                                  jsonEncode(<String, String?>{
                                                'sex': dropdownValue,
                                                'size': dropdownValueSize,
                                                'color': dropdownValueColor,
                                                'model': dropdownValueModel,
                                                'style': cldRsp.publicId
                                              }));
                                        } on CloudinaryException catch (e) {
                                          print(e.message);
                                          print(e.request);
                                        }
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const ShoppingCartForm()),
                                        );
                                      }),
                                ],
                              ));
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
