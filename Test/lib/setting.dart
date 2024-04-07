import 'dart:io';
import 'dart:typed_data';
import 'package:test/model/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:test/component/nav.dart';
import 'package:test/model/profile.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';


class Setting extends StatefulWidget {
  final Map<String, dynamic> info;
  final Profile profile;

  const Setting({
    Key? key,
    required this.profile,
    required this.info,
  }) : super(key: key);

  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  CollectionReference users = FirebaseFirestore.instance.collection('Users');
  TextEditingController _nameController = TextEditingController();
  TextEditingController _imageController = TextEditingController();
  String _selectedItem = 'Auto Rating';
  bool firstvalue = false;
  bool secondvalue = false;
  final ImagePicker _picker = ImagePicker();
  Uint8List? _image;

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.info['name'];
    _imageController.text = widget.info['image'];
  }

  void _updatename() {
    FirebaseFirestore.instance
        .collection('Users')
        .doc(widget.profile.email)
        .update({
      widget.info['infoid']: {
        'infoid': widget.info['infoid'],
        'image': widget.info['image'],
        'name': _nameController.text,
      }
    }).then((_) {
      Fluttertoast.showToast(
        msg: 'Update successfully',
        gravity: ToastGravity.TOP,
        textColor: Colors.white,
        backgroundColor: Color(0xFFA04826),
        timeInSecForIosWeb: 3,
      );
      print('name update successfully');
    }).catchError((error) {
      Fluttertoast.showToast(
        msg: 'Failed to update user data: $error',
        gravity: ToastGravity.TOP,
        textColor: Colors.white,
        backgroundColor: Color(0xFFA04826),
        timeInSecForIosWeb: 3,
      );
    });
  }

  // void _updateimage() {
  //   FirebaseFirestore.instance
  //       .collection('Users')
  //       .doc(widget.profile.email)
  //       .update({
  //     widget.info['infoid']: {
  //       'infoid': widget.info['infoid'],
  //       'image': _imageController,
  //       'name': widget.info['name'],
  //     }
  //   }).then((_) {
  //     print(_imageController.text);
  //     print('image update successfully');
  //   }).catchError((error) {
  //     print('update image error' + error);
  //   });
  // }

  void _deletedata() {
    _nameController.text = 'Anonymus';
    _imageController.text =
        'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png';
    FirebaseFirestore.instance
        .collection('Users')
        .doc(widget.profile.email)
        .update({
      widget.info['infoid']: {
        'infoid': widget.info['infoid'],
        'image': _imageController.text,
        'name': _nameController.text,
      }
    }).then((_) {
      Fluttertoast.showToast(
        msg: 'Tap save to confirm your update1',
        gravity: ToastGravity.TOP,
        textColor: Colors.white,
        backgroundColor: Color(0xFFA04826),
        timeInSecForIosWeb: 3,
      );
    }).catchError((error) {
      print('update image error' + error);
    });
  }

  

  void selectedImage() async {
    Uint8List? img = await pickImage(ImageSource.gallery);
    if (img != null) {
      setState(() {
        _image = img!;
      });
    } else {
      print('_image = null');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: NavDrawer(profile: widget.profile, info: widget.info),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: Bar(profile: widget.profile, info: widget.info),
      ),
      backgroundColor:
          Colors.black, // Set background color of Scaffold to transparent
      body: FutureBuilder<DocumentSnapshot>(
        future: users.doc(widget.profile.email).get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Something went wrong'));
          }
          if (!snapshot.hasData || !snapshot.data!.exists) {
            return Center(child: Text("Document does not exist"));
          }

          // Accessing subcollection data
          var data = snapshot.data!.data() as Map<String, dynamic>;
          var info = data[widget.info['infoid']] as Map<String, dynamic>;

          return Stack(
            children: <Widget>[
              // Background image container
              Stack(
                children: [
                  // Image container with overlay
                  Container(
                    decoration: BoxDecoration(
                      image: _image != null
                          ? DecorationImage(
                              image: MemoryImage(_image!),
                              fit: BoxFit.cover,
                              colorFilter: ColorFilter.mode(
                                Colors.black.withOpacity(0.5),
                                BlendMode.darken,
                              ),
                            )
                          : DecorationImage(
                              image: NetworkImage(
                                info['image'],
                              ),
                              fit: BoxFit.cover,
                              colorFilter: ColorFilter.mode(
                                Colors.black.withOpacity(0.5),
                                BlendMode.darken,
                              ),
                            ),
                    ),
                    height: 180 + kToolbarHeight,
                  ),
                ],
              ),
              // Content container
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  padding: EdgeInsets.only(top: 60),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Avatar
                      SizedBox(
                        child: IconButton(
                          icon: Icon(Icons.skip_previous, size: 70),
                          color: Colors.white,
                          onPressed: () {},
                        ),
                      ),
                      SizedBox(width: 20),
                      Stack(
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: _image != null
                                ? CircleAvatar(
                                    radius: 60,
                                    backgroundImage: MemoryImage(_image!),
                                  )
                                : CircleAvatar(
                                    radius: 60,
                                    backgroundImage:
                                        NetworkImage(info['image']),
                                  ),
                          ),
                          Positioned(
                            child: IconButton(
                              icon: Icon(Icons.add_a_photo),
                              color: Colors.white,
                              onPressed: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: ((builder) => bottomSheet()),
                                );
                              },
                            ),
                            bottom: -10,
                            right: 5,
                          ),
                        ],
                      ),
                      SizedBox(width: 20),
                      SizedBox(
                        child: IconButton(
                          icon: Icon(Icons.skip_next, size: 70),
                          color: Colors.white,
                          onPressed: () {},
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 180 + kToolbarHeight + 20, // Adjust position as needed
                left: 20,
                right: 20,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _nameController,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontFamily: 'EncodeSansCondensed',
                      ),
                      decoration: InputDecoration(
                        hintText: info['name'],
                        hintStyle: TextStyle(
                          color: Colors.white.withOpacity(0.5),
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'EncodeSansCondensed',
                        ),
                        fillColor: Colors.transparent,
                        filled: true,
                        border: const UnderlineInputBorder(
                          borderSide: BorderSide(
                            width: 1.0,
                            color: Colors.white,
                          ),
                        ),
                        suffixIcon: IconButton(
                          icon: Image.asset(
                            'assets/editicon.png',
                            color: Colors.white,
                            width: 25,
                            height: 25,
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Maturity Setting",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'EncodeSansCondensed',
                        ),
                      ),
                    ),
                    SizedBox(height: 15), // Add some spacing
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(
                          width: 2.0,
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: DropdownButton<String>(
                        value: _selectedItem,
                        dropdownColor: Colors.black,
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedItem = newValue!;
                          });
                        },
                        items: <String>['Auto Rating', 'All Maturity Rating']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontFamily: 'EncodeSansCondensed',
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    SizedBox(height: 20),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Autoplay Controls",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'EncodeSansCondensed',
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Checkbox(
                              value: firstvalue,
                              checkColor: Colors.black,
                              activeColor: Colors.white,
                              onChanged: (bool? value1) {
                                setState(() {
                                  firstvalue = value1!;
                                });
                              },
                            ),
                            Text(
                              'Autoplay next episode in a series\non all devices',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 18,
                                fontFamily: 'EncodeSansCondensed',
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: <Widget>[
                            Checkbox(
                              value: secondvalue,
                              checkColor: Colors.black,
                              activeColor: Colors.white,
                              onChanged: (bool? value2) {
                                setState(() {
                                  secondvalue = value2!;
                                });
                              },
                            ),
                            Text(
                              'Autoplay previews while browsing\non all devices',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.white,
                                fontFamily: 'EncodeSansCondensed',
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                // savedImage(_image!, info, widget.profile.email);
                                if (_nameController.text.isNotEmpty) {
                                  _updatename();
                                }
                                _nameController.clear();
                              },
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.white,
                                padding: EdgeInsets.symmetric(
                                    vertical: 16, horizontal: 40),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  side: BorderSide(
                                    color: Colors.white,
                                    width: 2,
                                  ),
                                ),
                              ),
                              child: Text(
                                'Save',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontFamily: 'EncodeSansCondensed',
                                ),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                _nameController.clear();
                              },
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.black,
                                padding: EdgeInsets.symmetric(
                                    vertical: 16, horizontal: 40),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  side: BorderSide(
                                    color: Colors.white,
                                    width: 2,
                                  ),
                                ),
                              ),
                              child: Text(
                                'Cancel',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontFamily: 'EncodeSansCondensed',
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12),
                        ElevatedButton(
                          onPressed: () {
                            _deletedata();
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Color(0xFFA04826),
                            backgroundColor: Color(0xFFA04826),
                            padding: EdgeInsets.symmetric(
                                vertical: 16, horizontal: 120),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                              side: BorderSide(
                                color: Color(0xFFA04826),
                                width: 2,
                              ),
                            ),
                          ),
                          child: Text(
                            'Delete This Profile',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.black,
                              fontFamily: 'EncodeSansCondensed',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget bottomSheet() {
    return Container(
      height: 120,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Color(0xFFA04826),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(height: 10),
            Text(
              "Choose Profile photo",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.white,
                fontFamily: 'EncodeSansCondensed',
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextButton.icon(
                  icon: Icon(Icons.camera, color: Colors.white),
                  onPressed: () {
                    print('take image from camera');
                    // takePhoto(ImageSource.camera);
                    selectedImage();
                  },
                  label: Text(
                    "Camera",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontFamily: 'EncodeSansCondensed',
                    ),
                  ),
                ),
                SizedBox(width: 20),
                TextButton.icon(
                  icon: Icon(Icons.image, color: Colors.white),
                  onPressed: () {
                    print('pick image from gallery');
                    // takePhoto(ImageSource.gallery);
                    selectedImage();
                  },
                  label: Text(
                    "Gallery",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontFamily: 'EncodeSansCondensed',
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

}

// class StoreData {
//   final FirebaseStorage _storage = FirebaseStorage.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   Future<String> uploadImageToStorage(String childName, Uint8List file) async {
//     print('uploadImageToStorage is working');
//     Reference ref = _storage.ref().child(childName);
//     print('1');
//     UploadTask uploadTask = ref.putData(file);
//     print('2');
//     TaskSnapshot snapshot = await uploadTask;
//     print('3');
//     String downloadUrl = await snapshot.ref.getDownloadURL();
//     print(downloadUrl);
//     return downloadUrl;
//   }

//   Future<String> saveData(
//       {required Uint8List file,
//       required Map<String, dynamic> info,
//       required String email}) async {
//     print("uploading image...");
//     String resp = "Some error occurred";
//     try {
//       print("Calling uploadImageToStorage...");
//       String imageUrl = await uploadImageToStorage('profileImage', file);
//       print("Image upload successful. Image URL: $imageUrl");

//       print("Updating Firestore...");
//       await _firestore.collection('Users').doc(email).update({
//         info['infoid']: {
//           'image': imageUrl,
//           'infoid': info['infoid'],
//           'name': info['name'],
//         },
//       });
//       print('Update Firestore success');
//       resp = 'success';
//     } catch (err) {
//       resp = err.toString();
//       print('Error during image upload or Firestore update: $resp');
//     }
//     return resp;
//   }
// }
