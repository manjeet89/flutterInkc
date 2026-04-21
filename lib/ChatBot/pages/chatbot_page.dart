import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:inkc/ChatBot/models/KennelModel.dart';
import 'package:inkc/ChatBot/models/dog_breed_model.dart';
import 'package:inkc/ChatBot/models/dog_dam_Lisr_model.dart';
import 'package:inkc/dropdownmodel/drop_down_color_and_making_list.dart';
import 'package:inkc/firebase_messagign/fire_base_message.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class ChatBotPage extends StatefulWidget {
  const ChatBotPage({super.key});

  @override
  State<ChatBotPage> createState() => _ChatBotPageState();
}

class _ChatBotPageState extends State<ChatBotPage> {
  //==================
  //Globale  variable
  //================
  String GlobalValidations = "";

  // login  new User id Stored
  String NewUserID = "";

  //==================
  //Litter Registration
  //================
  String litterDamInkcregNumb = "";
  String littersireInkcregNumb = "";
  String litter_Date_of_birth = "";
  String littercountrybredin = "";
  String numberopuppies = "";
  File? litter_stud_imagePath;
  File? litter_dog_image;
  String? litterbreedId;
  String? litterbreedName;

  // after puppy number enter
  String damfront = "";
  String damback = "";
  String damfransferform = "";
  String sirefront = "";
  String sireback = "";
  String sirefransferform = "";
  String studAgreementForm = "";

  // dam registrered with other club
  File? litter_Dam_front_side_imagePath_other_club;
  File? litter_Dam_back_side_imagePath_other_club;
  File? litter_Dam_transfer_imagePath_other_club;
  String? litter_dam_req_other_club;
  String? litterdamKennelNam_other_club;

  // sire registrered with other club
  File? litter_sire_front_side_imagePath_other_club;
  File? litter_sire_back_side_imagePath_other_club;
  File? litter_sire_transfer_imagePath_other_club;
  String? litter_sire_req_other_club;
  String? littersireKennelNam_other_club;

  // for puppies
  // int step = 0;

  int totalPuppies = 0;
  int currentPuppyIndex = 0;

  List<String> puppyNames = [];
  List<int> puppyGenders = [];
  List<String> puppyColorIds = [];
  List<String> puppyColorNames = [];

  // int totalUsers = 0;
  // int currentIndex = 0;

  // int totalPuppies = 0;
  // int currentPuppyIndex = 0;

  // List<String> puppyColorIds = [];
  // List<String> puppyColorNames = [];

  // List<String> puppyNames = [];
  // List<int> puppyGenders = [];

  //GLobale Dog name
  String NameOfTheDog = "";

  /// ================================
  /// CONTROLLERS
  /// ================================
  final TextEditingController messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  //===================
  // Kennel Nama registration
  //=====================
  String KennelNameForRegis = "";

//===============
// 6 month old form
//
  String heignt6monthold = "";
  File? upload_dog_height_imagePath;
  File? upload_one_side_imagePath;

//  LoginData for set Data
  String PhoneNumber = "";
  String Passwwrod = "";

  /// ================================
  /// MESSAGE LIST
  /// ================================
  List<Map<String, dynamic>> messages = [];

  /// ================================
  /// FORM DATA VARIABLES
  /// ================================
  int step = 0;
  String name = "";
  String mobile = "";
  String email = "";
  String address = "";
  String gender = "";
  String dob = "";

  //// afetr co-onwer form
  String coOwnerId = "";
  int dogStep = 0;
  bool showTextInput = true;

  // Single Dog Regtistration
  //is your dog registration - yes
  int FirstYesDogRegis = 0;
  String registration_number = "";
  File? Front_side_Certificate_imagePath;
  File? Back_side_Certificate_imagePath;
  File? dog_tranform_imagePath;
  String kennelName = "";
  String breed_of_the_dog = "";
  String Name_of_the_dog = "";
  String Date_of_birth = "";
  String Color_and_marking = "";
  File? dog_imagePath;
  String Dog_gender = "";
  String country_bred_in = "";

  String microChipyesorno = "";

  //==================
  //Sire Registration
  //==================
  int SireRegWithINKC = 0;
  String SIreFatherInkcRegNum = "";

  //==================
  //Sire Registration with any other club
  //==================
  int SireRegWithAnyOtherClub = 0;
  String Sire_non_inkc_reg_numb = "";
  File? sire_father_font_side_imagePath;
  File? sire_father_back_side_imagePath;
  File? sire_transfer_form_imagePath;
  String? SirebreedId;
  String? SirebreedName;

  //==================
  //dam Registration
  //==================
  int DamRegWithINKC = 0;
  String DamMotherInkcRegNum = "";

  //==================
  //Sire Registration with any other club
  //==================
  int DamRegWithAnyOtherClub = 0;
  String dam_non_inkc_reg_numb = "";
  File? dam_mother_font_side_imagePath;
  File? dam_mother_back_side_imagePath;
  File? dam_transfer_form_imagePath;
  String? DambreedId;
  String? DambreedName;

  //================
  // Coman Fields for every log
  //=========================

  String Coman_filed_country_bred_in = "";
  String Coman_filed_date_of_birth = "";
  String? comanfiledcolorAndMarkingId;
  String? comanfiledcolorAndMarkingName;
  File? Coman_filed_Dog_imagePath;
  String Coman_filed_Dog_gender = "";

  File? selectedImage;
  final ImagePicker picker = ImagePicker();

  bool checkvisible = false;
  List<Map<String, String>> keyValueList = [];
  List products = [];
  String? selectedValue; // Initial selected value

  Future insertvalue() async {
    SharedPreferences sharedprefrence = await SharedPreferences.getInstance();
    String userid = sharedprefrence.getString("Userid")!;
    String token = sharedprefrence.getString("Token")!;

    Map<String, String> requestHeaders = {
      // 'Content-type': 'application/json',
      // 'Accept': 'application/json',
      'Usertoken': token,
      'Userid': userid
    };

    try {
      final res = await http.post(Uri.parse("https://inkc.in/api/user/kennel_details"),
          headers: requestHeaders);

      final body = json.decode(res.body);

      keyValueList.clear();
      // products.clear();

      if (body['data']['kennel_second_owner'].toString() == "false") {
        //checkvisible = false;
        // removeLastWidget();
        // botReply("no kennel name");
        print("doremon");
      } else {
        List list = body['data']['kennel_second_owner'];
        for (int i = 0; i < list.length; i++) {
          var productMap = {
            body['data']['kennel_second_owner'][i]['kennel_id'].toString():
                body['data']['kennel_second_owner'][i]['kennel_name'].toString(),
          };
          keyValueList.add(productMap);
          // print(keyValueList);
        }
        if (checkvisible == false) {
          setState(() {
            checkvisible = true;
          });
        }
      }

      if (body['data']['kennel_info'].toString() == "false") {
        //checkvisible = false;
        removeLastWidget();
      } else {
        // checkvisible = false;

        keyValueList.add({
          body['data']['kennel_info']['kennel_id'].toString():
              body['data']['kennel_info']['kennel_name'].toString()
        });
        //   = [
        //   {
        //     body['data']['kennel_info']['kennel_id'].toString():
        //         body['data']['kennel_info']['kennel_name'].toString()
        //   }
        // ];
        // print(keyValueList);
        if (checkvisible == false) {
          setState(() {
            checkvisible = true;
          });
        }
      }
      print(keyValueList);

      //print(list);
    } catch (e) {}

    //throw Exception('Error fetch data');
  }

  Future<void> pickImage(String images) async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      removeLastWidget();

      selectedImage = File(image.path);
      if ("Front_side_Certificate_imagePath" == images) {
        Front_side_Certificate_imagePath = File(image.path);

        messages.add({"sender": "user", "image": image.path});
        botReply("Image uploaded successfully ✅");
        setState(() {
          botReply("Upload Your Dog's back of the certificate");
        });
        messages.add({"sender": "user_widget", "widget": "Back_image_picker"});
      } else if ("Back_side_Certificate_imagePath" == images) {
        Back_side_Certificate_imagePath = File(image.path);
        messages.add({"sender": "user", "image": image.path});
        botReply("Image uploaded successfully ✅");

        setState(() {
          botReply("Upload Your Dog's transfer form");
        });
        messages.add({"sender": "user_widget", "widget": "Dog_transfer_image_picker"});
      } else if ("dog_tranform_imagePath" == images) {
        dog_tranform_imagePath = File(image.path);
        messages.add({"sender": "user", "image": image.path});
        botReply("Image uploaded successfully ✅");

        setState(() {
          FirstYesDogRegis++;
          botReply("Enter Non-INKC Registration Number?");
          showTextInput = true;
          GlobalValidations = "NonINKCRegNum";
          // messages.add({"sender": "user_widget", "widget": "Registraion_Number"});
        });

        // messages.add({"sender": "user_widget", "widget": "Registraion_Number"});
      } else if ("dog_imagePath" == images) {
        dog_imagePath = File(image.path);

        messages.add({"sender": "user", "image": image.path});

        botReply("Image uploaded successfully ✅");

        botReply("Dog Gender");
        messages.add({"sender": "user_widget", "widget": "Single_dog_gender_registration_"});

        // setState(() {});
      }
      //====================================
      // sire father front side image select
      //====================================

      else if ("sire_father_front_side_image_picker" == images) {
        sire_father_font_side_imagePath = File(image.path);

        messages.add({"sender": "user", "image": image.path});

        botReply("Image uploaded successfully ✅");

        botReply("Upload Sire's(Father's) Back Side of the certificate");
        messages.add({"sender": "user_widget", "widget": "sire_back_image_picker"});

        // setState(() {});
      } else if ("sire_father_back_side_image_picker" == images) {
        sire_father_back_side_imagePath = File(image.path);

        messages.add({"sender": "user", "image": image.path});

        botReply("Image uploaded successfully ✅");

        botReply("Upload Sire's Transfer Form (completely) Filled and Signed");
        messages.add({"sender": "user_widget", "widget": "sire_tranfer_image_picker"});

        // setState(() {});
      } else if ("sire_transfer_form_image_picker" == images) {
        sire_transfer_form_imagePath = File(image.path);

        messages.add({"sender": "user", "image": image.path});

        botReply("Image uploaded successfully ✅");

        botReply("Breed of the Sire");
        messages.add({"sender": "user_widget", "widget": "Sire_breed_dropdown"});

        setState(() {
          fetchBreeds();
        });

        // setState(() {});
      } else if ("dam_mother_front_side_image_picker" == images) {
        dam_mother_font_side_imagePath = File(image.path);

        messages.add({"sender": "user", "image": image.path});

        botReply("Image uploaded successfully ✅");

        botReply("Upload Dam's(Mother's) back Side of the certificate");
        messages.add({"sender": "user_widget", "widget": "dam_back_image_picker"});

        // setState(() {});
      } else if ("dam_mother_back_side_image_picker" == images) {
        dam_mother_back_side_imagePath = File(image.path);

        messages.add({"sender": "user", "image": image.path});

        botReply("Image uploaded successfully ✅");

        botReply("Upload Dam's Transfer Form (completely) Filled and Signed");
        messages.add({"sender": "user_widget", "widget": "dam_tranfer_image_picker"});

        // setState(() {});
      } else if ("dam_transfer_form_image_picker" == images) {
        dam_transfer_form_imagePath = File(image.path);

        messages.add({"sender": "user", "image": image.path});

        botReply("Image uploaded successfully ✅");

        botReply("Breed of the Dam");
        messages.add({"sender": "user_widget", "widget": "Dam_breed_dropdown"});

        setState(() {
          fetchBreeds();
        });

        // setState(() {});
      }

      //Coman field for every one
      else if ("Coman_Filed_Dog_image_picker" == images) {
        Coman_filed_Dog_imagePath = File(image.path);

        messages.add({"sender": "user", "image": image.path});

        botReply("Image uploaded successfully ✅");

        botReply("Dog Gender");
        messages.add({"sender": "user_widget", "widget": "Coman_filed_dog_gender"});

        // setState(() {});
      }
      // 6 month old image collect
      // upload dog height
      else if ("upload_dog_height_image_picker" == images) {
        upload_dog_height_imagePath = File(image.path);

        messages.add({"sender": "user", "image": image.path});

        botReply("Image uploaded successfully ✅");

        botReply("Upload photograph of the dog from one side");
        messages.add({"sender": "user_widget", "widget": "upload_dog_side_image"});

        // setState(() {});
      } else if ("upload_dog_side_image" == images) {
        upload_one_side_imagePath = File(image.path);

        messages.add({"sender": "user", "image": image.path});

        botReply("Image uploaded successfully ✅");

        botReply("Breed of the dog");
        messages.add({"sender": "user_widget", "widget": "Dam_breed_dropdown"});

        // setState(() {});
      }
      // litter stud form
      else if ("Litter_stud_form_image_picker" == images) {
        litter_stud_imagePath = File(image.path);

        messages.add({"sender": "user", "image": image.path});

        botReply("Dog Date of birth");

        messages.add({"sender": "user_widget", "widget": "litter_dog_dob"});

        // setState(() {});
      }
      //litter dam other club registration
      //other club dam registration
      else if ("Litter_dam_otherclub_fornt_side_image_picker" == images) {
        litter_Dam_front_side_imagePath_other_club = File(image.path);

        messages.add({"sender": "user", "image": image.path});
        botReply("Image uploaded successfully ✅");
        setState(() {
          botReply("Upload back of the certificate");
        });
        messages.add(
            {"sender": "user_widget", "widget": "Litter_dam_otherclub_back_side_image_picker"});
      } else if ("Litter_dam_otherclub_back_side_image_picker" == images) {
        litter_Dam_back_side_imagePath_other_club = File(image.path);
        messages.add({"sender": "user", "image": image.path});
        botReply("Image uploaded successfully ✅");

        setState(() {
          botReply("Upload transfer form");
        });
        messages
            .add({"sender": "user_widget", "widget": "litter_Dam_transfer_imagePath_other_club"});
      } else if ("litter_Dam_transfer_imagePath_other_club" == images) {
        litter_Dam_transfer_imagePath_other_club = File(image.path);
        messages.add({"sender": "user", "image": image.path});
        botReply("Image uploaded successfully ✅");

        setState(() {
          startLitterSireRegistrationFlow();
        });

        // messages.add({"sender": "user_widget", "widget": "Registraion_Number"});
      }
      //other club sire registration
      else if ("Litter_sire_otherclub_fornt_side_image_picker" == images) {
        litter_sire_front_side_imagePath_other_club = File(image.path);

        messages.add({"sender": "user", "image": image.path});
        botReply("Image uploaded successfully ✅");
        setState(() {
          botReply("Upload back of the certificate");
        });
        messages.add(
            {"sender": "user_widget", "widget": "Litter_sire_otherclub_back_side_image_picker"});
      } else if ("Litter_sire_otherclub_back_side_image_picker" == images) {
        litter_sire_back_side_imagePath_other_club = File(image.path);
        messages.add({"sender": "user", "image": image.path});
        botReply("Image uploaded successfully ✅");

        setState(() {
          botReply("Upload transfer form");
        });
        messages
            .add({"sender": "user_widget", "widget": "litter_sire_transfer_imagePath_other_club"});
      } else if ("litter_sire_transfer_imagePath_other_club" == images) {
        litter_sire_transfer_imagePath_other_club = File(image.path);
        messages.add({"sender": "user", "image": image.path});
        botReply("Image uploaded successfully ✅");

        setState(() {
          botReply("Stud Agreement Form");
          messages.add({"sender": "user_widget", "widget": "Litter_stud_image_picker"});
          showTextInput = false; // show text field
        });

        // messages.add({"sender": "user_widget", "widget": "Registraion_Number"});
      } else if ("litter_dogs_image" == images) {
        litter_dog_image = File(image.path);
        messages.add({"sender": "user", "image": image.path});
        botReply("Image uploaded successfully ✅");

        setState(() {
          botReply("Kennel Club Name");
          showTextInput = false; // show text field
          messages.add({"sender": "user_widget", "widget": "Litter_kennel_name"});
        });

        // messages.add({"sender": "user_widget", "widget": "Registraion_Number"});
      }
    }
  }

  /// ================================
  /// INIT
  /// ================================
  @override
  void initState() {
    super.initState();

    fetchBreeds();
    fetchKennel();
    // botReply("Hi 👋 What is your name?");
    // botReply("Hi 👋 Please Enter Your Phone Number");
    // showFinalOptions();
    checkLogin();
  }

  bool _isShow = false;

  checkLogin() async {
    SharedPreferences sharedprefrence = await SharedPreferences.getInstance();
    String? check = sharedprefrence.getString("Token");
    print("${check}with me");
    if (check.toString() == "null") {
      setState(() {
        _isShow = false;
        botReply("Hi 👋 Please Enter Your Phone Number");
        GlobalValidations = "PhoneNumber";
      });
    } else {
      setState(() {
        _isShow = true;
        botReply("Select Services...");
        showTextInput = false;
        showFinalOptions();
      });
    }
  }

  /// ================================
  //api call here

  String? breedId;
  String? breedName;

  List<BreedModel> breedList = [];

  Future<void> fetchBreeds() async {
    SharedPreferences sharedprefrence = await SharedPreferences.getInstance();
    String userid = sharedprefrence.getString("Userid")!;
    String token = sharedprefrence.getString("Token")!;

    print('$userid / $token');

    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Usertoken': token,
      'Userid': userid
    };
    final response = await http.post(
      Uri.parse("https://inkc.in/api/dog/dog_breed_list"),
      headers: requestHeaders,
    );

    final data = jsonDecode(response.body);

    if (data["data"] != null) {
      breedList = (data["data"] as List).map((e) => BreedModel.fromJson(e)).toList();
    }

    setState(() {});
  }

  // litter registration dam list

  String? DamId;
  String? DamName;

  List<DogDamLisrModel> DamList = [];
  Future<void> fetchdamName() async {
    SharedPreferences sharedprefrence = await SharedPreferences.getInstance();
    String userid = sharedprefrence.getString("Userid")!;
    String token = sharedprefrence.getString("Token")!;

    print('$userid / $token');

    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Usertoken': token,
      'Userid': userid
    };
    final response = await http.post(
      Uri.parse("https://inkc.in//api/dog/dog_dam_list"),
      headers: requestHeaders,
    );

    final data = jsonDecode(response.body);
    if (data['data'].toString() == "false") {
      removeLastWidget();
      botReply("You don't have dam INKC registration number");

      botReply("Registration Number of Dam ?");
      showTextInput = true;
      GlobalValidations = "liiterregNumDam";
    }
    print(data['data'].toString() + "i am ");

    if (data["data"] != null) {
      DamList = (data["data"] as List).map((e) => DogDamLisrModel.fromJson(e)).toList();
    }

    setState(() {});
  }

  GetDetailLitterCertificate() async {
    // botReply("stud agreement form " + litter_stud_imagePath.toString());

    // botReply("litter_Dam_front_side_imagePath_other_club " +
    //     litter_Dam_front_side_imagePath_other_club.toString());
    // botReply("litter_Dam_back_side_imagePath_other_club " +
    //     litter_Dam_back_side_imagePath_other_club.toString());
    // botReply("litter_Dam_transfer_imagePath_other_club " +
    //     litter_Dam_transfer_imagePath_other_club.toString());

    // botReply("litter_sire_front_side_imagePath_other_club " +
    //     litter_sire_front_side_imagePath_other_club.toString());
    // botReply("litter_sire_back_side_imagePath_other_club " +
    //     litter_sire_back_side_imagePath_other_club.toString());
    // botReply("litter_sire_transfer_imagePath_other_club " +
    //     litter_sire_transfer_imagePath_other_club.toString());
    botReply("Please wait...");

    SharedPreferences sharedprefrence = await SharedPreferences.getInstance();
    String userid = sharedprefrence.getString("Userid")!;
    String token = sharedprefrence.getString("Token")!;
    Dio dio = Dio();
    DateTime now = DateTime.now();

    FormData formData = FormData.fromMap({
      if (litter_stud_imagePath.toString() != "null")
        'stud_agreement_form': await MultipartFile.fromFile(litter_stud_imagePath!.path,
            filename: "${now.second}.jpg"),
      if (litter_sire_front_side_imagePath_other_club.toString() != "null")
        'sire_front_side_certificate': await MultipartFile.fromFile(
            litter_sire_front_side_imagePath_other_club!.path,
            filename: "${now.second}.jpg"),
      if (litter_sire_back_side_imagePath_other_club.toString() != "null")
        'sire_back_side_certificate': await MultipartFile.fromFile(
            litter_sire_back_side_imagePath_other_club!.path,
            filename: "${now.second}.jpg"),
      if (litter_sire_transfer_imagePath_other_club.toString() != "null")
        'other_club_transfer_form_sire': await MultipartFile.fromFile(
            litter_sire_transfer_imagePath_other_club!.path,
            filename: "${now.second}.jpg"),
      if (litter_Dam_transfer_imagePath_other_club.toString() != "null")
        'other_club_transfer_form_dam': await MultipartFile.fromFile(
            litter_Dam_transfer_imagePath_other_club!.path,
            filename: "${now.second}.jpg"),
      if (litter_Dam_transfer_imagePath_other_club.toString() != "null")
        'other_club_transfer_form_dam': await MultipartFile.fromFile(
            litter_Dam_transfer_imagePath_other_club!.path,
            filename: "${now.second}.jpg"),
      if (litter_Dam_transfer_imagePath_other_club.toString() != "null")
        'other_club_transfer_form_dam': await MultipartFile.fromFile(
            litter_Dam_transfer_imagePath_other_club!.path,
            filename: "${now.second}.jpg"),
    });

    Response response = await dio.post('https://inkc.in/api/dog/litter_registration_upload',
        data: formData,
        options: Options(headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Usertoken': token,
          'Userid': userid
        }));

    print(response);

    if (response.statusCode == 200) {
      // _image = response[]
      var responseData = jsonDecode(response.data);
      setState(() {
        studAgreementForm = responseData['data']['stud_agreement_form'];
        damfront = responseData['data']['dam_front_side_certificate'];
        damback = responseData['data']['dam_back_side_certificate'];
        sirefront = responseData['data']['sire_front_side_certificate'];
        sireback = responseData['data']['sire_back_side_certificate'];

        sirefransferform = responseData['data']['other_club_transfer_form_sire'];
        damfransferform = responseData['data']['other_club_transfer_form_dam'];
        // botReply(responseData.toString());
      });

      // var damfront = responseData['data']['dam_front_side_certificate'];
      // var damback = responseData['data']['dam_back_side_certificate'];
      // var damfransferform = responseData['data']['other_club_transfer_form_dam'];

      // Navigator.of(context).push(MaterialPageRoute(
      //     builder: (BuildContext context) => LitterPuppyRegistration(
      //           sire: SIRE,
      //           dam: "",
      //           dob: DOB,
      //           country: counrty.text.toString(),
      //           puppy: numbers.text.toString(),
      //           image: _image.toString(),
      //           sirebackcerificate: sireback,
      //           sirefrontcerificate: sirefront,
      //           siretranferform: siretranferform.toString(),
      //           damfrontcerificate: damfront,
      //           dambackcerificate: damback,
      //           damtranform: damfransferform,
      //           petcolordid: breedid.toString(),
      //           siretranform: "",
      //         )));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Something went wrong')));
      print('something worng');
    }
  }

  // LitterRegistrationApi() async {
  //   String puppyname = puppyNames.toString();
  //   puppyname.replaceAll("[", "").replaceAll("]", "");

  //   print(puppyname);

  //   String colo = puppyColorIds.toString();
  //   colo.replaceAll("[", "").replaceAll("]", "");

  //   String Gend = puppyGenders.toString();
  //   Gend.replaceAll("[", "").replaceAll("]", "");

  //   // SharedPreferences sharedprefrence = await SharedPreferences.getInstance();
  //   // String KennelName = sharedprefrence.getString("KennelName")!;

  //   try {
  //     SharedPreferences sharedprefrence = await SharedPreferences.getInstance();
  //     String userid = sharedprefrence.getString("Userid")!;
  //     String token = sharedprefrence.getString("Token")!;
  //     Dio dio = Dio();
  //     DateTime now = DateTime.now();

  //     FormData formDatas = FormData.fromMap({
  //       'pet_image': await MultipartFile.fromFile(firstImage!.path, filename: "${now.second}.jpg"),
  //       'sire_reg_number': widget.sire,
  //       'dam_reg_number': widget.dam.toString(),
  //       'pet_sub_category_id': widget.petcolordid.toString(),
  //       'pet_gender[]': Gend,
  //       'birth_date': widget.dob.toString(),
  //       'pet_name[]': puppyname,
  //       'color_marking[]': colo,
  //       'sire_front_side_certificate': widget.sirefrontcerificate.toString(),
  //       'sire_back_side_certificate': widget.sirebackcerificate.toString(),
  //       'kennel_name': selectedValue,
  //       'kennel_name_pre': prifixdata, // if (widget.sirefrontcerificate.toString() != "null")
  //       // 'sire_front_side_certificate': await MultipartFile.fromFile(
  //       //     widget.sirefrontcerificate!.path,
  //       //     filename: "${now.second}.jpg"),
  //       // if (widget.sirebackcerificate.toString() != "null")
  //       // 'sire_back_side_certificate': await MultipartFile.fromFile(
  //       //     widget.sirebackcerificate!.path,
  //       //     filename: "${now.second}.jpg"),
  //       // if (widget.image.toString() != "null")
  //       //   'stud_agreement_form': await MultipartFile.fromFile(
  //       //       widget.image!.path,
  //       //       filename: "${now.second}.jpg"),
  //     });

  //     Response response =
  //         await dio.post('https://inkc.in/api/dog/litter_registration_new',
  //             data: formDatas,
  //             options: Options(headers: {
  //               'Content-type': 'application/json',
  //               'Accept': 'application/json',
  //               'Usertoken': token,
  //               'Userid': userid
  //             }));

  //     if (response.statusCode == 200) {
  //       print(response.toString());

  //       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Success')));
  //     } else {
  //       ScaffoldMessenger.of(context)
  //           .showSnackBar(const SnackBar(content: Text('Something went wrong')));
  //       //print('something worng');
  //     }

  //     // images = File(pickedFile.path);
  //   } catch (e) {
  //     print('no image  selected false');
  //   }
  // }

  //=====================
  //Color and Marking
  //===================

  String? colorAndMarkingId;
  String? colorAndMarkingName;
  List<ColorAndMaking> colorAndMarkingList = [];

  Future<void> fetchcolorAndMarkings() async {
    SharedPreferences sharedprefrence = await SharedPreferences.getInstance();
    String userid = sharedprefrence.getString("Userid")!;
    String token = sharedprefrence.getString("Token")!;

    print('$userid / $token');

    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Usertoken': token,
      'Userid': userid
    };
    final response = await http.post(
      Uri.parse("https://inkc.in/api/dog/dog_color_marking_list"),
      headers: requestHeaders,
    );

    final data = jsonDecode(response.body);
    print(data);

    if (data["data"] != null) {
      colorAndMarkingList = (data["data"] as List).map((e) => ColorAndMaking.fromJson(e)).toList();
    }

    setState(() {});
  }

  //=========================
  //Kennel Name drop down
  //======================
  String? KennelId;
  String? KennelName;
  List<Kennelmodel> KennelList = [];

  Future<void> fetchKennel() async {
    SharedPreferences sharedprefrence = await SharedPreferences.getInstance();
    String userid = sharedprefrence.getString("Userid")!;
    String token = sharedprefrence.getString("Token")!;

    print('$userid / $token');

    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Usertoken': token,
      'Userid': userid
    };
    final response = await http.post(
      Uri.parse("https://inkc.in/api/dog/kennel_list_for_non_inkc"),
      headers: requestHeaders,
    );

    final data = jsonDecode(response.body);
    print(data);

    if (data["data"] != null) {
      KennelList = (data["data"] as List).map((e) => Kennelmodel.fromJson(e)).toList();
    }

    setState(() {});
  }

  /// ================================
  /// SHOW CONFIRM BUTTON
  /// ================================
  void Single_Form_Done_confirmshowConfirmButton() {
    setState(() {
      messages.add({"sender": "user_widget", "widget": "Single_Form_Done_confirm"});
    });
    scrollToBottom();
  }

  /// ================================
  /// CONFIRM FORM
  /// ================================
  void Single_Form_Done_confirmconfirmForm() async {
    removeLastWidget();

    SharedPreferences sharedprefrence = await SharedPreferences.getInstance();
    String userid = sharedprefrence.getString("Userid")!;
    String token = sharedprefrence.getString("Token")!;
    Dio dio = Dio();
    DateTime now = DateTime.now();

    if (registration_number != "") {
      try {
        if (dog_tranform_imagePath.toString() == "null") {
          FormData formData = FormData.fromMap({
            'pet_image':
                await MultipartFile.fromFile(dog_imagePath!.path, filename: "${now.second}.jpg"),
            'front_side_certificate': await MultipartFile.fromFile(
                Front_side_Certificate_imagePath!.path,
                filename: "${now.second}.jpg"),
            'back_side_certificate': await MultipartFile.fromFile(
                Back_side_Certificate_imagePath!.path,
                filename: "${now.second}.jpg"),
            'pet_sub_category_id': breedId,
            'kennel_club_prefix': KennelId,
            'pet_gender': Dog_gender == "Male" ? "1" : "0",
            'color_marking': colorAndMarkingId,
            'birth_date': Date_of_birth,
            'pet_name': Name_of_the_dog,
            'pet_registration_number': registration_number,
            'breded_country': country_bred_in,
            'is_microchip_require': microChipyesorno == "yes" ? "1" : "0",
          });

          Response response = await dio.post('https://inkc.in/api/dog/non_inkc_registration',
              data: formData,
              options: Options(headers: {
                'Content-type': 'application/json',
                'Accept': 'application/json',
                'Usertoken': token,
                'Userid': userid
              }));

          if (response.statusCode == 200) {
            botReply("SuccessFully Registered 🙌");
            startDogForm(); // START FORM AFTER ENTER

            // QuickAlert.show(
            //   context: context,
            //   type: QuickAlertType.success,
            //   title: 'Success...',
            //   text: 'SuccessFully Registered',
            // );

            // print(response.toString());
            // setState(() {
            //   RefreshCart();
            //   showSpinner = false;
            // });

            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text('SuccessFully Registered')));
          } else {
            // setState(() {
            //   showSpinner = false;
            // });
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text('Something went wrong')));
            print('something worng');
          }
        } else {
          FormData formData = FormData.fromMap({
            'pet_image':
                await MultipartFile.fromFile(dog_imagePath!.path, filename: "${now.second}.jpg"),
            'front_side_certificate': await MultipartFile.fromFile(
                Front_side_Certificate_imagePath!.path,
                filename: "${now.second}.jpg"),
            'back_side_certificate': await MultipartFile.fromFile(
                Back_side_Certificate_imagePath!.path,
                filename: "${now.second}.jpg"),
            'other_club_transfer_form': await MultipartFile.fromFile(dog_tranform_imagePath!.path,
                filename: "${now.second}.jpg"),
            'pet_sub_category_id': breedId,
            'kennel_club_prefix': KennelId,
            'pet_gender': Dog_gender == "Male" ? "1" : "0",
            'color_marking': colorAndMarkingId,
            'birth_date': Date_of_birth,
            'pet_name': Name_of_the_dog,
            'pet_registration_number': registration_number,
            'breded_country': country_bred_in,
            'is_microchip_require': microChipyesorno == "yes" ? "1" : "0",
          });

          Response response = await dio.post('https://inkc.in/api/dog/non_inkc_registration',
              data: formData,
              options: Options(headers: {
                'Content-type': 'application/json',
                'Accept': 'application/json',
                'Usertoken': token,
                'Userid': userid
              }));

          if (response.statusCode == 200) {
            botReply("SuccessFully Registered 🙌");
            startDogForm(); // START FORM AFTER ENTER

            // QuickAlert.show(
            //   context: context,
            //   type: QuickAlertType.success,
            //   title: 'Success...',
            //   text: 'SuccessFully Registered',
            // );

            // print(response.toString());
            // setState(() {
            //   RefreshCart();
            //   showSpinner = false;
            // });

            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text('SuccessFully Registered')));
          } else {
            // setState(() {
            //   showSpinner = false;
            // });
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text('Something went wrong')));
            print('something worng');
          }
        }

        // images = File(pickedFile.path);
      } catch (e) {
        // setState(() {
        //   showSpinner = false;
        // });
        print('no image  selected false');
      }
    } else if (KennelNameForRegis != "") {
      try {
        const uri = "https://inkc.in/api/dog/kennel_name_registration";

        Map<String, String> requestHeaders = {
          'Accept': 'application/json',
          'Usertoken': token,
          'Userid': userid
        };

        final responce = await http.post(Uri.parse(uri), headers: requestHeaders, body: {
          'kennel_club_name': KennelNameForRegis.toString(),
          'second_owner_id': coOwnerId
        });
        var data = json.decode(responce.body);

        if (data['code'].toString() == "200") {
          SharedPreferences Kennelnamestore = await SharedPreferences.getInstance();
          await Kennelnamestore.setString("Kennelnamestore", KennelNameForRegis.toString());
        }
        botReply(" Kennel Name Registered 🙌");
        showFinalOptions();
      } catch (e) {
        // setState(() {
        //   showSpinner = false;
        // });
        print('no image  selected false');
      }
    } else if (heignt6monthold != "") {
      try {
        FormData formData = FormData.fromMap({
          'pet_image':
              await MultipartFile.fromFile(dog_imagePath!.path, filename: "${now.second}.jpg"),
          'pet_height_image': await MultipartFile.fromFile(upload_dog_height_imagePath!.path,
              filename: "${now.second}.jpg"),
          'pet_side_image': await MultipartFile.fromFile(upload_one_side_imagePath!.path,
              filename: "${now.second}.jpg"),
          'pet_gender': Dog_gender == "Male" ? "1" : "0",
          'birth_date': Coman_filed_date_of_birth,
          'pet_name': NameOfTheDog,
          'second_owner_id': coOwnerId,
          'is_second_owner': coOwnerId == "" ? "0" : "1",
          'is_microchip_require': microChipyesorno == "yes" ? "1" : "0",
          'color_marking': comanfiledcolorAndMarkingId,
          'breded_country': Coman_filed_country_bred_in,
          'pet_sub_category_id': DambreedId,
          'pet_height_inches': heignt6monthold,
        });
        print(
            "${dog_imagePath!.path + "-\n" + upload_dog_height_imagePath!.path + "-\n" + upload_one_side_imagePath!.path + "-'n" + Dog_gender + "-" + Coman_filed_date_of_birth.toString() + "-" + NameOfTheDog + "-" + coOwnerId}-$microChipyesorno-$comanfiledcolorAndMarkingId  ${Coman_filed_country_bred_in} \n ${DambreedId} - \n   ${heignt6monthold}");

        Response response =
            await dio.post('https://inkc.in/api/dog/unknown_pedigree_dog_registration',
                data: formData,
                options: Options(headers: {
                  'Content-type': 'application/json',
                  'Accept': 'application/json',
                  'Usertoken': token,
                  'Userid': userid
                }));

        if (response.statusCode == 200) {
          print(response.toString());

          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('SuccessFully Registered')));

          botReply("SuccessFully Registered 🙌");
          showFinalOptions();
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('Something went wrong')));
          print('something worng');
        }

        // images = File(pickedFile.path);
      } catch (e) {
        print('no image  selected false');
      }
    } else if (SIreFatherInkcRegNum != "" && DamMotherInkcRegNum != "") {
      try {
        FormData formData = FormData.fromMap({
          'pet_image':
              await MultipartFile.fromFile(dog_imagePath!.path, filename: "${now.second}.jpg"),
          'pet_gender': Dog_gender == "Male" ? "1" : "0",
          'birth_date': Coman_filed_date_of_birth,
          'pet_name': NameOfTheDog,
          'second_owner_id': coOwnerId,
          'is_second_owner': coOwnerId == "" ? "0" : "1",
          'is_microchip_require': microChipyesorno == "yes" ? "1" : "0",
          'color_marking': comanfiledcolorAndMarkingId,
          'breded_country': Coman_filed_country_bred_in,
          'pet_sub_category_id': DambreedId,
          'dam_reg_number': DamMotherInkcRegNum,
          'sire_reg_number': SIreFatherInkcRegNum,
        });

        Response response = await dio.post('https://inkc.in/api/dog/pedigree_dog_registration',
            data: formData,
            options: Options(headers: {
              'Content-type': 'application/json',
              'Accept': 'application/json',
              'Usertoken': token,
              'Userid': userid
            }));

        if (response.statusCode == 200) {
          print(response.toString());

          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('SuccessFully Registered')));

          botReply("SuccessFully Registered 🙌");
          showFinalOptions();
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('Something went wrong')));
          print('something worng');
        }

        // images = File(pickedFile.path);
      } catch (e) {
        print('no image  selected false');
      }
    } else if (SIreFatherInkcRegNum != "") {
      try {
        FormData formData = FormData.fromMap({
          'pet_image':
              await MultipartFile.fromFile(dog_imagePath!.path, filename: "${now.second}.jpg"),
          'pet_gender': Dog_gender == "Male" ? "1" : "0",
          'birth_date': Coman_filed_date_of_birth,
          'pet_name': NameOfTheDog,
          'second_owner_id': coOwnerId,
          'is_second_owner': coOwnerId == "" ? "0" : "1",
          'is_microchip_require': microChipyesorno == "yes" ? "1" : "0",
          'color_marking': comanfiledcolorAndMarkingId,
          'breded_country': Coman_filed_country_bred_in,
          'pet_sub_category_id': DambreedId,
          'pet_category_id': DambreedId,
          'sire_reg_number': SIreFatherInkcRegNum,
        });

        Response response =
            await dio.post('https://inkc.in/api/dog/sire_registration_withINKC_dam_unknown',
                data: formData,
                options: Options(headers: {
                  'Content-type': 'application/json',
                  'Accept': 'application/json',
                  'Usertoken': token,
                  'Userid': userid
                }));

        if (response.statusCode == 200) {
          print(response.toString());

          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('SuccessFully Registered')));

          botReply("SuccessFully Registered 🙌");
          showFinalOptions();
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('Something went wrong')));
          print('something worng');
        }

        // images = File(pickedFile.path);
      } catch (e) {
        print('no image  selected false');
      }
    } else if (DamMotherInkcRegNum != "") {
      try {
        FormData formData = FormData.fromMap({
          'pet_image':
              await MultipartFile.fromFile(dog_imagePath!.path, filename: "${now.second}.jpg"),
          'pet_gender': Dog_gender == "Male" ? "1" : "0",
          'birth_date': Coman_filed_date_of_birth,
          'pet_name': NameOfTheDog,
          'second_owner_id': coOwnerId,
          'is_second_owner': coOwnerId == "" ? "0" : "1",
          'is_microchip_require': microChipyesorno == "yes" ? "1" : "0",
          'color_marking': comanfiledcolorAndMarkingId,
          'breded_country': Coman_filed_country_bred_in,
          'pet_sub_category_id': DambreedId,
          'pet_category_id': DambreedId,
          'dam_reg_number': DamMotherInkcRegNum,
        });

        Response response = await dio.post('https://inkc.in/api/dog/pedigree_dog_registration',
            data: formData,
            options: Options(headers: {
              'Content-type': 'application/json',
              'Accept': 'application/json',
              'Usertoken': token,
              'Userid': userid
            }));

        if (response.statusCode == 200) {
          print(response.toString());

          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('SuccessFully Registered')));

          botReply("SuccessFully Registered 🙌");
          showFinalOptions();
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('Something went wrong')));
          print('something worng');
        }

        // images = File(pickedFile.path);
      } catch (e) {
        print('no image  selected false');
      }
    } else if (sire_father_font_side_imagePath.toString() == "null" &&
        sire_father_back_side_imagePath.toString() == "null" &&
        dam_mother_font_side_imagePath.toString() == "null" &&
        dam_mother_back_side_imagePath.toString() == "null") {
      try {
        FormData formData = FormData.fromMap({
          'pet_image':
              await MultipartFile.fromFile(dog_imagePath!.path, filename: "${now.second}.jpg"),
          // 'stud_agreement_form':
          //     await MultipartFile.fromFile(_studcertificate!.path, filename: "${now.second}.jpg"),
          'dam_front_side_certificate': await MultipartFile.fromFile(
              dam_mother_font_side_imagePath!.path,
              filename: "${now.second}.jpg"),
          'dam_back_side_certificate': await MultipartFile.fromFile(
              dam_mother_back_side_imagePath!.path,
              filename: "${now.second}.jpg"),
          'sire_front_side_certificate': await MultipartFile.fromFile(
              sire_father_font_side_imagePath!.path,
              filename: "${now.second}.jpg"),
          'sire_back_side_certificate': await MultipartFile.fromFile(
              sire_father_back_side_imagePath!.path,
              filename: "${now.second}.jpg"),
          if (sire_transfer_form_imagePath.toString() != "null")
            'other_club_transfer_form_sire': await MultipartFile.fromFile(
                sire_transfer_form_imagePath!.path,
                filename: "${now.second}.jpg"),
          if (dam_transfer_form_imagePath.toString() != "null")
            'other_club_transfer_form_dam': await MultipartFile.fromFile(
                dam_transfer_form_imagePath!.path,
                filename: "${now.second}.jpg"),
          'pet_gender': Dog_gender == "Male" ? "1" : "0",
          'birth_date': Coman_filed_date_of_birth,
          'pet_name': NameOfTheDog,
          'second_owner_id': coOwnerId,
          'is_second_owner': coOwnerId == "" ? "0" : "1",
          'is_microchip_require': microChipyesorno == "yes" ? "1" : "0",
          'color_marking': comanfiledcolorAndMarkingId,
          'breded_country': Coman_filed_country_bred_in,
          'pet_sub_category_id': DambreedId,
          'pet_category_id': DambreedId,
        });

        Response response = await dio.post('https://inkc.in/api/dog/bothparentregisterwithKCI',
            data: formData,
            options: Options(headers: {
              'Content-type': 'application/json',
              'Accept': 'application/json',
              'Usertoken': token,
              'Userid': userid
            }));

        if (response.statusCode == 200) {
          print(response.toString());

          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('SuccessFully Registered')));

          botReply("SuccessFully Registered 🙌");
          showFinalOptions();
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('Something went wrong')));
          print('something worng');
        }

        // images = File(pickedFile.path);
      } catch (e) {
        print('no image  selected false');
      }
    }
    // sire front side and back side image imp
    else if (sire_father_font_side_imagePath.toString() == "null" &&
        sire_father_back_side_imagePath.toString() == "null") {
      try {
        FormData formData = FormData.fromMap({
          'pet_image':
              await MultipartFile.fromFile(dog_imagePath!.path, filename: "${now.second}.jpg"),
          'sire_front_side_certificate': await MultipartFile.fromFile(
              sire_father_font_side_imagePath!.path,
              filename: "${now.second}.jpg"),
          'sire_back_side_certificate': await MultipartFile.fromFile(
              sire_father_back_side_imagePath!.path,
              filename: "${now.second}.jpg"),
          if (sire_transfer_form_imagePath.toString() != "null")
            'other_club_transfer_form_sire': await MultipartFile.fromFile(
                sire_transfer_form_imagePath!.path,
                filename: "${now.second}.jpg"),
          'pet_gender': Dog_gender == "Male" ? "1" : "0",
          'birth_date': Coman_filed_date_of_birth,
          'pet_name': NameOfTheDog,
          'second_owner_id': coOwnerId,
          'is_second_owner': coOwnerId == "" ? "0" : "1",
          'is_microchip_require': microChipyesorno == "yes" ? "1" : "0",
          'color_marking': comanfiledcolorAndMarkingId,
          'breded_country': Coman_filed_country_bred_in,
          'pet_sub_category_id': DambreedId,
          'pet_category_id': DambreedId,
        });

        Response response =
            await dio.post('https://inkc.in/api/dog/sire_register_with_other_club_dam_unknown',
                data: formData,
                options: Options(headers: {
                  'Content-type': 'application/json',
                  'Accept': 'application/json',
                  'Usertoken': token,
                  'Userid': userid
                }));

        if (response.statusCode == 200) {
          print(response.toString());

          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('SuccessFully Registered')));

          botReply("SuccessFully Registered 🙌");
          showFinalOptions();
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('Something went wrong')));
          print('something worng');
        }

        // images = File(pickedFile.path);
      } catch (e) {
        print('no image  selected false');
      }
    }
    // dam number and sire front and back side imp
    else if (sire_father_font_side_imagePath.toString() == "null" &&
        sire_father_back_side_imagePath.toString() == "null" &&
        DamMotherInkcRegNum != "") {
      try {
        FormData formData = FormData.fromMap({
          'pet_image':
              await MultipartFile.fromFile(dog_imagePath!.path, filename: "${now.second}.jpg"),
          'sire_front_side_certificate': await MultipartFile.fromFile(
              sire_father_font_side_imagePath!.path,
              filename: "${now.second}.jpg"),
          'sire_back_side_certificate': await MultipartFile.fromFile(
              sire_father_back_side_imagePath!.path,
              filename: "${now.second}.jpg"),
          if (sire_transfer_form_imagePath.toString() != "null")
            'other_club_transfer_form_sire': await MultipartFile.fromFile(
                sire_transfer_form_imagePath!.path,
                filename: "${now.second}.jpg"),
          'dam_reg_number': DamMotherInkcRegNum,
          'pet_gender': Dog_gender == "Male" ? "1" : "0",
          'birth_date': Coman_filed_date_of_birth,
          'pet_name': NameOfTheDog,
          'second_owner_id': coOwnerId,
          'is_second_owner': coOwnerId == "" ? "0" : "1",
          'is_microchip_require': microChipyesorno == "yes" ? "1" : "0",
          'color_marking': comanfiledcolorAndMarkingId,
          'breded_country': Coman_filed_country_bred_in,
          'pet_sub_category_id': DambreedId,
          'pet_category_id': DambreedId,
        });

        Response response = await dio.post('https://inkc.in/api/dog/damregistrationwithINKC',
            data: formData,
            options: Options(headers: {
              'Content-type': 'application/json',
              'Accept': 'application/json',
              'Usertoken': token,
              'Userid': userid
            }));

        if (response.statusCode == 200) {
          print(response.toString());

          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('SuccessFully Registered')));

          botReply("SuccessFully Registered 🙌");
          showFinalOptions();
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('Something went wrong')));
          print('something worng');
        }

        // images = File(pickedFile.path);
      } catch (e) {
        print('no image  selected false');
      }
    }
    // dam frint and back side imp
    else if (dam_mother_font_side_imagePath.toString() == "null" &&
        dam_mother_back_side_imagePath.toString() == "null") {
      try {
        FormData formData = FormData.fromMap({
          'pet_image':
              await MultipartFile.fromFile(dog_imagePath!.path, filename: "${now.second}.jpg"),
          // 'stud_agreement_form':
          //     await MultipartFile.fromFile(_studcertificate!.path, filename: "${now.second}.jpg"),
          'dam_front_side_certificate': await MultipartFile.fromFile(
              dam_mother_font_side_imagePath!.path,
              filename: "${now.second}.jpg"),
          'dam_back_side_certificate': await MultipartFile.fromFile(
              dam_mother_back_side_imagePath!.path,
              filename: "${now.second}.jpg"),

          if (dam_transfer_form_imagePath.toString() != "null")
            'other_club_transfer_form_dam': await MultipartFile.fromFile(
                dam_transfer_form_imagePath!.path,
                filename: "${now.second}.jpg"),

          'pet_gender': Dog_gender == "Male" ? "1" : "0",
          'birth_date': Coman_filed_date_of_birth,
          'pet_name': NameOfTheDog,
          'second_owner_id': coOwnerId,
          'is_second_owner': coOwnerId == "" ? "0" : "1",
          'is_microchip_require': microChipyesorno == "yes" ? "1" : "0",
          'color_marking': comanfiledcolorAndMarkingId,
          'breded_country': Coman_filed_country_bred_in,
          'pet_sub_category_id': DambreedId,
          'pet_category_id': DambreedId,
        });

        Response response =
            await dio.post('https://inkc.in/api/dog/dam_register_with_other_club_sire_unknown',
                data: formData,
                options: Options(headers: {
                  'Content-type': 'application/json',
                  'Accept': 'application/json',
                  'Usertoken': token,
                  'Userid': userid
                }));

        if (response.statusCode == 200) {
          print(response.toString());

          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('SuccessFully Registered')));

          botReply("SuccessFully Registered 🙌");
          showFinalOptions();
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('Something went wrong')));
          print('something worng');
        }

        // images = File(pickedFile.path);
      } catch (e) {
        print('no image  selected false');
      }
    }
    // sire number and dam frint and back side imp
    else if (SIreFatherInkcRegNum != "" &&
        dam_mother_font_side_imagePath.toString() == "null" &&
        dam_mother_back_side_imagePath.toString() == "null") {
      try {
        FormData formData = FormData.fromMap({
          'pet_image':
              await MultipartFile.fromFile(dog_imagePath!.path, filename: "${now.second}.jpg"),
          // 'stud_agreement_form':
          //     await MultipartFile.fromFile(_studcertificate!.path, filename: "${now.second}.jpg"),
          'dam_front_side_certificate': await MultipartFile.fromFile(
              dam_mother_font_side_imagePath!.path,
              filename: "${now.second}.jpg"),
          'dam_back_side_certificate': await MultipartFile.fromFile(
              dam_mother_back_side_imagePath!.path,
              filename: "${now.second}.jpg"),

          if (dam_transfer_form_imagePath.toString() != "null")
            'other_club_transfer_form_dam': await MultipartFile.fromFile(
                dam_transfer_form_imagePath!.path,
                filename: "${now.second}.jpg"),
          'sire_reg_number': SIreFatherInkcRegNum,
          'pet_gender': Dog_gender == "Male" ? "1" : "0",
          'birth_date': Coman_filed_date_of_birth,
          'pet_name': NameOfTheDog,
          'second_owner_id': coOwnerId,
          'is_second_owner': coOwnerId == "" ? "0" : "1",
          'is_microchip_require': microChipyesorno == "yes" ? "1" : "0",
          'color_marking': comanfiledcolorAndMarkingId,
          'breded_country': Coman_filed_country_bred_in,
          'pet_sub_category_id': DambreedId,
          'pet_category_id': DambreedId,
        });

        Response response = await dio.post('https://inkc.in/api/dog/sireregistrationwithINKC',
            data: formData,
            options: Options(headers: {
              'Content-type': 'application/json',
              'Accept': 'application/json',
              'Usertoken': token,
              'Userid': userid
            }));

        if (response.statusCode == 200) {
          print(response.toString());

          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('SuccessFully Registered')));

          botReply("SuccessFully Registered 🙌");
          showFinalOptions();
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('Something went wrong')));
          print('something worng');
        }

        // images = File(pickedFile.path);
      } catch (e) {
        print('no image  selected false');
      }
    }
    // nothing
    else {
      botReply(" $registration_number 🙌");
      botReply(" $Front_side_Certificate_imagePath 🙌");
      botReply(" $Back_side_Certificate_imagePath 🙌");
      botReply(" $dog_tranform_imagePath 🙌");
      botReply(" $KennelId 🙌");
      botReply(" $breedId 🙌");
      botReply(" $Name_of_the_dog 🙌");
      botReply(" $Date_of_birth 🙌");
      botReply(" $colorAndMarkingId 🙌");
      botReply(" $dog_imagePath 🙌");
      botReply(" $Dog_gender 🙌");
      botReply(" $country_bred_in 🙌");
      botReply(" $microChipyesorno 🙌");
      botReply(" $coOwnerId 🙌");
      // botReply(" $name 🙌");
      // botReply(" $name 🙌");

      startDogForm(); // START FORM AFTER ENTER
    }
  }
  //===================
  ///.Finished
  //========================

  /// ================================
  /// SCROLL TO BOTTOM
  /// ================================
  void scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  /// ================================
  /// BOT MESSAGE
  /// ================================
  void botReply(String text) {
    setState(() {
      messages.add({"sender": "bot", "text": text});
    });
    scrollToBottom();
  }

  /// ================================
  /// USER MESSAGE
  /// ================================
  void userReply(String text) {
    setState(() {
      messages.add({"sender": "user", "text": text});
    });
    scrollToBottom();
  }

  //loginModule

  String getUserId(dynamic response) {
    if (response["data"] is Map) {
      // First API response
      return response["data"]["user_id"].toString();
    } else {
      // Second API response
      return response["data"].toString();
    }
  }

  NumberCheckAPIModule(String number) async {
    const uri = "https://inkc.in/api/login/new_login";

    final responce = await http.post(
      Uri.parse(uri),
      body: {"user_phone_number": number},
    );
    var data = json.decode(responce.body);
    if (data['code'] == 200) {
      String userId = getUserId(data);

      NewUserID = userId;
      botReply("Enter your OTP");
      GlobalValidations = "Password";

      print("USER ID: $userId");
    }
  }

  OtpCheckModule(String password) async {
    const uri = "https://inkc.in/api/login/verification";

    final responce = await http.post(
      Uri.parse(uri),
      body: {
        "user_id": NewUserID,
        "user_otp": password,
      },
    );
    var data = json.decode(responce.body);
    if (data['code'] == 200) {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      print("1st");
      if (data['data'][0]['user_address'].toString() == "null") {
        SharedPreferences fulladdress = await SharedPreferences.getInstance();
        await fulladdress.setString("fulladdress", "null");
      } else {
        SharedPreferences fulladdress = await SharedPreferences.getInstance();
        await fulladdress.setString(
            "fulladdress",
            data['data'][0]['user_address'] +
                " " +
                data['data'][0]['user_address_2'] +
                " " +
                data['data'][0]['user_local'] +
                " " +
                data['data'][0]['user_district'] +
                " " +
                data['data'][0]['user_state'] +
                " " +
                data['data'][0]['user_pincode']);
      }
      print("2st");

      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      await sharedPreferences.setString("First", data['data'][0]['first_name']);
      print("3st");

      SharedPreferences Token = await SharedPreferences.getInstance();
      await Token.setString("Token", data['user_token']);
      print("4st");

      SharedPreferences Userid = await SharedPreferences.getInstance();
      await Userid.setString("Userid", data['data'][0]['user_id']);
      print("5st");

      if (data['data'][0]['user_full_name'].toString() == "") {
        SharedPreferences EmpFullName = await SharedPreferences.getInstance();
        await EmpFullName.setString("EmpFullName", "null");
      } else {
        SharedPreferences EmpFullName = await SharedPreferences.getInstance();
        await EmpFullName.setString("EmpFullName", data['data'][0]['user_full_name']);
      }
      print("6st");

      SharedPreferences EmpTypeId = await SharedPreferences.getInstance();
      await EmpTypeId.setString("EmpTypeId", data['data'][0]['user_employee_type']);
      print("7st");

      SharedPreferences EmpTypeName = await SharedPreferences.getInstance();
      await EmpTypeName.setString("EmpTypeName", 'User');
      print("8st");
      SharedPreferences PhoneNumber = await SharedPreferences.getInstance();
      await PhoneNumber.setString("phoneNumber", data['data'][0]['user_phone_number']);
      print("9st");
      SharedPreferences UserVerification = await SharedPreferences.getInstance();
      await UserVerification.setString("UserVerification", data['data'][0]['is_verified']);
      print("10st");
      SharedPreferences FontUserid = await SharedPreferences.getInstance();
      await FontUserid.setString("FontUserid", data['data'][0]['user_id']);
      print("11st");
      if (data['data'][0]['user_address'].toString() == "null") {
      } else {
        SharedPreferences FontEmpFullName = await SharedPreferences.getInstance();
        await FontEmpFullName.setString(
            "FontEmpFullName", data['data'][0]['first_name'] + " " + data['data'][0]['last_name']);
      }
      print("12st");
      SharedPreferences FontEmpTypeId = await SharedPreferences.getInstance();
      await FontEmpTypeId.setString("FontEmpTypeId", data['data'][0]['user_employee_type']);
      print("13st");
      SharedPreferences FontUserEmailId = await SharedPreferences.getInstance();
      await FontUserEmailId.setString("FontUserEmailId", data['data'][0]['user_email_id']);
      print("14st");
      SharedPreferences FontEmpTypeName = await SharedPreferences.getInstance();
      await FontEmpTypeName.setString("FontEmpTypeName", "User");
      print("15st");
      SharedPreferences FontPhoneNumber = await SharedPreferences.getInstance();
      await FontPhoneNumber.setString("FontPhoneNumber", data['data'][0]['user_phone_number']);
      print("16st");
      SharedPreferences FontUserVerification = await SharedPreferences.getInstance();
      await FontUserVerification.setString("FontUserVerification", data['data'][0]['is_verified']);
      print("17st");
      SharedPreferences FontKennelClubStatus = await SharedPreferences.getInstance();
      await FontKennelClubStatus.setString(
          "FontKennelClubStatus", data['data'][0]['kennel_club_status']);
      print("18st");
      SharedPreferences FontMemberStatus = await SharedPreferences.getInstance();
      await FontMemberStatus.setString("FontMemberStatus", data['data'][0]['member_status']);
      print("19st");
      if (data['data'][0]['user_profile_image'].toString() == "null") {
        SharedPreferences UserProfileImage = await SharedPreferences.getInstance();
        await UserProfileImage.setString("UserProfileImage", "null");
      } else {
        SharedPreferences UserProfileImage = await SharedPreferences.getInstance();
        await UserProfileImage.setString("UserProfileImage", data['data'][0]['user_profile_image']);
      }
      print("20st");
      // card code with id card
      if (data['data'][0]['card_code'].toString() == "null") {
        SharedPreferences cardCode = await SharedPreferences.getInstance();
        await cardCode.setString("card_code", "null");
      } else {
        SharedPreferences cardCode = await SharedPreferences.getInstance();
        await cardCode.setString("card_code", data['data'][0]['card_code']);
      }
      print("21st");
      SharedPreferences UserName = await SharedPreferences.getInstance();
      await UserName.setString("UserName", data['data'][0]['first_name']);
      print("22st");
      SharedPreferences UserEmpId = await SharedPreferences.getInstance();
      await UserEmpId.setString("UserEmpId", data['data'][0]['user_employee_type']);

      SharedPreferences LastName = await SharedPreferences.getInstance();
      await LastName.setString("LastName", data['data'][0]['last_name']);

      SharedPreferences Firstname = await SharedPreferences.getInstance();
      await Firstname.setString("Firstname", data['data'][0]['first_name']);

      await prefs.setBool('isLoggedIn', true);
      // Get.to(MyApp());
      // Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //         builder: (context) => MyApp()));

      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp();
      await FireBaseApi().initNotification();

      if (data['data'][0]['user_address'] == "null") {
        print("Null available");
      } else {
        print(data['data'][0]['user_address']);
      }
    }
  }

  LoginModule(String number, String password) async {
    // EasyLoading.showToast('Please Wait...');

    const uri = "https://inkc.in/api/login";

    final responce = await http.post(
      Uri.parse(uri),
      body: {"user_phone_number": number, "user_password": password},
    );
    var data = json.decode(responce.body);
    if (data['code'] == 200) {
      // QuickAlert.show(
      //   context: context,
      //   type: QuickAlertType.loading,
      //   title: 'Loading',
      // );

      // EasyLoading.dismiss();
      print(data['data']['user_token']);

      print("1st");
      if (data['data']['user_address'].toString() == "null") {
        SharedPreferences fulladdress = await SharedPreferences.getInstance();
        await fulladdress.setString("fulladdress", "null");
      } else {
        SharedPreferences fulladdress = await SharedPreferences.getInstance();
        await fulladdress.setString(
            "fulladdress",
            data['data']['user_address'] +
                " " +
                data['data']['user_address_2'] +
                " " +
                data['data']['user_local'] +
                " " +
                data['data']['user_district'] +
                " " +
                data['data']['user_state'] +
                " " +
                data['data']['user_pincode']);
      }
      print("2st");

      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      await sharedPreferences.setString("First", data['data']['first_name']);

      SharedPreferences Token = await SharedPreferences.getInstance();
      await Token.setString("Token", data['user_token']);

      SharedPreferences Userid = await SharedPreferences.getInstance();
      await Userid.setString("Userid", data['data']['user_id']);

      if (data['data']['user_full_name'].toString() == "") {
        SharedPreferences EmpFullName = await SharedPreferences.getInstance();
        await EmpFullName.setString("EmpFullName", "null");
      } else {
        SharedPreferences EmpFullName = await SharedPreferences.getInstance();
        await EmpFullName.setString("EmpFullName", data['data']['user_full_name']);
      }

      SharedPreferences EmpTypeId = await SharedPreferences.getInstance();
      await EmpTypeId.setString("EmpTypeId", data['data']['emp_type_id']);

      SharedPreferences EmpTypeName = await SharedPreferences.getInstance();
      await EmpTypeName.setString("EmpTypeName", data['data']['emp_type_name']);

      SharedPreferences PhoneNumber = await SharedPreferences.getInstance();
      await PhoneNumber.setString("phoneNumber", data['data']['user_phone_number']);

      SharedPreferences UserVerification = await SharedPreferences.getInstance();
      await UserVerification.setString("UserVerification", data['data']['is_verified']);

      SharedPreferences FontUserid = await SharedPreferences.getInstance();
      await FontUserid.setString("FontUserid", data['data']['user_id']);

      if (data['data']['user_address'].toString() == "null") {
      } else {
        SharedPreferences FontEmpFullName = await SharedPreferences.getInstance();
        await FontEmpFullName.setString(
            "FontEmpFullName", data['data']['first_name'] + " " + data['data']['last_name']);
      }

      SharedPreferences FontEmpTypeId = await SharedPreferences.getInstance();
      await FontEmpTypeId.setString("FontEmpTypeId", data['data']['emp_type_id']);

      SharedPreferences FontUserEmailId = await SharedPreferences.getInstance();
      await FontUserEmailId.setString("FontUserEmailId", data['data']['user_email_id']);

      SharedPreferences FontEmpTypeName = await SharedPreferences.getInstance();
      await FontEmpTypeName.setString("FontEmpTypeName", data['data']['emp_type_name']);

      SharedPreferences FontPhoneNumber = await SharedPreferences.getInstance();
      await FontPhoneNumber.setString("FontPhoneNumber", data['data']['user_phone_number']);

      SharedPreferences FontUserVerification = await SharedPreferences.getInstance();
      await FontUserVerification.setString("FontUserVerification", data['data']['is_verified']);

      SharedPreferences FontKennelClubStatus = await SharedPreferences.getInstance();
      await FontKennelClubStatus.setString(
          "FontKennelClubStatus", data['data']['kennel_club_status']);

      SharedPreferences FontMemberStatus = await SharedPreferences.getInstance();
      await FontMemberStatus.setString("FontMemberStatus", data['data']['member_status']);

      if (data['data']['user_profile_image'].toString() == "null") {
        SharedPreferences UserProfileImage = await SharedPreferences.getInstance();
        await UserProfileImage.setString("UserProfileImage", "null");
      } else {
        SharedPreferences UserProfileImage = await SharedPreferences.getInstance();
        await UserProfileImage.setString("UserProfileImage", data['data']['user_profile_image']);
      }
      // card code with id card
      if (data['data']['card_code'].toString() == "null") {
        SharedPreferences cardCode = await SharedPreferences.getInstance();
        await cardCode.setString("card_code", "null");
      } else {
        SharedPreferences cardCode = await SharedPreferences.getInstance();
        await cardCode.setString("card_code", data['data']['card_code']);
      }

      SharedPreferences UserName = await SharedPreferences.getInstance();
      await UserName.setString("UserName", data['data']['first_name']);

      SharedPreferences UserEmpId = await SharedPreferences.getInstance();
      await UserEmpId.setString("UserEmpId", data['data']['emp_type_id']);

      SharedPreferences LastName = await SharedPreferences.getInstance();
      await LastName.setString("LastName", data['data']['last_name']);

      SharedPreferences Firstname = await SharedPreferences.getInstance();
      await Firstname.setString("Firstname", data['data']['first_name']);

      // Get.to(MyApp());
      // Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //         builder: (context) => MyApp()));

      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp();
      await FireBaseApi().initNotification();

      botReply("Done");
      showTextInput = false;
      _isShow = true;
      showFinalOptions();
    }
  }

  /// ================================
  /// HANDLE TEXT INPUT FLOW
  /// ================================
  void handleMessage(String text) {
    userReply(text);
    print(GlobalValidations);

    messageController.clear();
    //=====================
    // This for login module
    //=====================
    if (_isShow == false) {
      if (GlobalValidations == "PhoneNumber") {
        name = text;
        step++;
        PhoneNumber = text;
        NumberCheckAPIModule(PhoneNumber);
      } else if (GlobalValidations == "Password") {
        print(NewUserID);
        name = text;
        step++;
        Passwwrod = text;

        botReply("Please Wait.....");
        OtpCheckModule(Passwwrod);
        // NumberCheckAPIModule(PhoneNumber, Passwwrod);
        // LoginModule(PhoneNumber, Passwwrod);
      }
    }

    if (GlobalValidations == "KennelNameNeter") {
      KennelNameForRegis = text;
      showTextInput = false;
      askAddCoOwner();
    }

    if (GlobalValidations == "heightInches6monthold") {
      heignt6monthold = text;
      showTextInput = false;
      botReply("Upload photograph of the dog'd height");
      messages.add({"sender": "user_widget", "widget": "upload_dog_height_image_picker"});
    }

    // else if (step == 0) {
    //   name = text;
    //   step++;
    //   botReply("Enter your mobile number");
    // } else if (step == 1) {
    //   mobile = text;
    //   step++;
    //   botReply("Enter your email");
    // } else if (step == 2) {
    //   email = text;
    //   step++;
    //   botReply("Enter your address");
    // } else if (step == 3) {
    //   address = text;
    //   step++;
    //   botReply("Select your gender");
    //   showGenderOptions();
    // }

    // else if (dogStep >= 0) {
    //   if (dogStep == 0) {
    //     userReply(text);
    //     dogStep++;

    //     botReply("Select Dog Date Of Birth");

    //     messages.add({"sender": "user_widget", "widget": "dog_dob"});

    //     showTextInput = false;
    //   } else if (dogStep == 1) {
    //     userReply(text);
    //     dogStep++;
    //     botReply("Enter Breed of Dog");
    //   } else if (dogStep == 2) {
    //     userReply(text);
    //     dogStep++;
    //     botReply("Enter Color & Markings");
    //   } else if (dogStep == 3) {
    //     userReply(text);
    //     dogStep++;
    //     botReply("Select Dog Gender");
    //     showDogGender();
    //   }
    // }

    // if (FirstYesDogRegis >= 0) {
    //   // if (FirstYesDogRegis == 0) {
    //   //   print(FirstYesDogRegis.toString() + "0");
    //   //   FirstYesDogRegis++;
    //   //   botReply("Upload Your Dog's Front Side of the certificate");
    //   //   messages.add({"sender": "user_widget", "widget": "Front_image_picker"});
    //   //   showTextInput = false;
    //   // }
    //   // // else if (FirstYesDogRegis == 1) {
    //   // //   print(FirstYesDogRegis.toString() + "1");

    //   // //   FirstYesDogRegis++;
    //   // //   showTextInput = false;
    //   // //   print(FirstYesDogRegis);
    //   // // }

    //=====================
    // This for Single dog registration module
    //=====================
    if (GlobalValidations == "NonINKCRegNum") {
      registration_number = text;
      showTextInput = false;
      botReply("Kennel Club Name");
      messages.add({"sender": "user_widget", "widget": "kennel_dropdown"});
      setState(() {
        fetchBreeds();
      });
    } else if (GlobalValidations == "NameOfTheDog") {
      Name_of_the_dog = text;

      botReply("Date of Birth");
      messages.add({"sender": "user_widget", "widget": "dog_dob"});
      showTextInput = false;
    } else if (GlobalValidations == "CountryBredIn_SingleDog") {
      country_bred_in = text;
      showTextInput = false;
      botReply("Do you require a microchip for your dog?");
      messages.add({"sender": "user_widget", "widget": "MicroChipAsked"});
    }

    if (GlobalValidations == "whatIsYourDogName") {
      NameOfTheDog = text;
      showTextInput = false;
      startDogRegistrationFlow();
    }

    // }

    // //====================
    // //Sire father number enter here
    // //===================
    if (GlobalValidations == "SireFatherINKCNumb") {
      print(text);
      SIreFatherInkcRegNum = text;
      showTextInput = false;
      is_dam_register_startDogRegistrationFlow();
    }

    // //====================
    // //Sire registered with any other club
    // //===================
    if (GlobalValidations == "SireNonINKCRegNumb") {
      Sire_non_inkc_reg_numb = text;
      botReply("Upload Sire's(Father's) Front Side of the certificate");
      messages.add({"sender": "user_widget", "widget": "sire_front_image_picker"});
      showTextInput = false; // show text field
    }

    //==================
    //Coman for all dog  detaqils
    if (GlobalValidations == "Coman_filed_CountryBredIn_SingleDog") {
      Coman_filed_country_bred_in = text;
      showTextInput = false;
      botReply("Do you require a microchip for your dog?");
      messages.add({"sender": "user_widget", "widget": "MicroChipAsked"});
    }

    // //====================
    // // //Dam mother number enter here
    // // //===================
    if (GlobalValidations == "DamMotherRegsNumb") {
      DamMotherInkcRegNum = text;
      showTextInput = false; // show text field

      botReply("Breed of the Dam");
      messages.add({"sender": "user_widget", "widget": "Dam_breed_dropdown"});

      // botReply("Select your Date of Birth");
      // ComanFiledshowDateOption();
    }

    // //====================
    // //dam registered with any other club
    // //===================
    if (GlobalValidations == "motherfrontsidecertificate") {
      dam_non_inkc_reg_numb = text;
      botReply("Upload Dam's(Mother's) Front Side of the certificate");
      messages.add({"sender": "user_widget", "widget": "dam_front_image_picker"});
      showTextInput = false; // show text field
    }

    // //====================
    // //Litter registration start
    // //===================
    if (GlobalValidations == "litterInkcNumber") {
      litterDamInkcregNumb = text;
      startLitterSireRegistrationFlow();
      showTextInput = false; // show text field
    }
    if (GlobalValidations == "litterSireInkcNumber") {
      littersireInkcregNumb = text;
      botReply("Stud Agreement Form");
      messages.add({"sender": "user_widget", "widget": "Litter_stud_image_picker"});
      showTextInput = false; // show text field
    }
    // liiter registration for cother club in dam
    if (GlobalValidations == "liiterregNumDam") {
      litter_dam_req_other_club = text;

      if (checkvisible == true) {
        botReply("Kennel Club Name");
        showTextInput = false; // show text field
        messages.add({"sender": "user_widget", "widget": "Litter_kennel_name"});
      } else {
        botReply("Upload Front Side of the Certificate.");
        messages.add(
            {"sender": "user_widget", "widget": "Litter_dam_otherclub_fornt_side_image_picker"});
      }
    }
    // liiter registration for cother club in sire
    if (GlobalValidations == "liiterregNumSire") {
      litter_sire_req_other_club = text;

      if (checkvisible == true) {
        botReply("Kennel Club Name");
        showTextInput = false; // show text field
        messages.add({"sender": "user_widget", "widget": "Litter_kennel_name_sire"});
      } else {
        botReply("Upload Front Side of the Certificate.");
        messages.add(
            {"sender": "user_widget", "widget": "Litter_sire_otherclub_fornt_side_image_picker"});
      }
    }

    //===============
    //litter country bred in
    //==============
    if (GlobalValidations == "littercountrybredin") {
      littercountrybredin = text;

      botReply("Upload litter photograph with the mother.");
      messages.add({"sender": "user_widget", "widget": "litter_dog_image"});

      showTextInput = false;
    }
    // if (GlobalValidations == "numberopuppies") {
    //   numberopuppies = text;
    //   // botReply("Number of puppies in the litter");
    //   showTextInput = false;
    // }

    // =========================
    // NUMBER OF PUPPIES
    // =========================
    if (GlobalValidations == "numberopuppies") {
      totalPuppies = int.tryParse(text) ?? 0;

      if (totalPuppies <= 0) {
        botReply("Please enter valid number");
        return;
      }
      if (totalPuppies != 0) {
        GetDetailLitterCertificate();
      }

      currentPuppyIndex = 0;

      botReply("🐶 Puppy 1\nEnter puppy name");

      showTextInput = true;
      GlobalValidations = "puppy_name";
    }

    // =========================
    // PUPPY NAME
    // =========================
    else if (GlobalValidations == "puppy_name") {
      puppyNames.add(text);

      botReply("Select gender for puppy ${currentPuppyIndex + 1}");

      messages.add({"sender": "user_widget", "widget": "gender_selection_widget"});

      showTextInput = false;
      GlobalValidations = "puppy_gender";
    }

//     if (GlobalValidations == "numberopuppies") {
//   numberopuppies = text;

//   totalPuppies = int.tryParse(text) ?? 0;
//   currentPuppyIndex = 0;

//   if (totalPuppies <= 0) {
//     botReply("Please enter valid number");
//     return;
//   }

//   botReply("Enter name for puppy 1");

//   showTextInput = true;
//   GlobalValidations = "puppy_name";
// }
// if (GlobalValidations == "puppy_name") {
//       puppyNames.add(text);

//       botReply("Select gender for puppy ${currentPuppyIndex + 1}");

//       messages.add({"sender": "user_widget", "widget": "gender_selection_widget"});

//       showTextInput = false;
//       GlobalValidations = "puppy_gender";
//     }

//     if (GlobalValidations == "numberopuppies") {
//       numberopuppies = text;

//       totalPuppies = int.tryParse(text) ?? 0;
//       currentPuppyIndex = 0;

//       if (totalPuppies <= 0) {
//         botReply("Please enter valid number");
//         return;
//       }

//       // 👉 Ask for first puppy dropdown
//       botReply("Select color & marking for puppy 1");

//       messages.add({"sender": "user_widget", "widget": "color_and_marking_dropdown_for_litter"});

//       showTextInput = false;
//       GlobalValidations = "puppy_color_loop";
//     }
  }

  /// ================================
  /// SHOW GENDER BUTTONS
  /// ================================
  void showGenderOptions() {
    setState(() {
      showTextInput = false;

      messages.add({"sender": "user_widget", "widget": "gender"});
    });
    scrollToBottom();
  }

  /// ================================
  /// SELECT GENDER
  /// ================================
  void selectGender(String value) {
    removeLastWidget();
    gender = value;
    userReply(value);

    botReply("Select your Date of Birth");
    showDateOption();
  }

  /// ================================
  /// SELECT GENDER FOR CO_OWNER FORM
  /// ================================
  void showDogGender() {
    setState(() {
      messages.add({"sender": "user_widget", "widget": "dog_gender"});
    });

    scrollToBottom();
  }

  /// ================================
  /// SHOW DATE BUTTON
  /// ================================
  void showDateOption() {
    setState(() {
      showTextInput = false;

      messages.add({"sender": "user_widget", "widget": "date"});
    });
    scrollToBottom();
  }

  /// ================================
  /// SELECT DATE
  /// ================================
  Future<void> selectDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      removeLastWidget();
      dob = "${pickedDate.day}-${pickedDate.month}-${pickedDate.year}";
      userReply(dob);

      botReply("✅ All details collected!");
      showConfirmButton();
    }
  }

  /// ================================
  /// COMMAN FILED FOR EVERY DOG SELECT DATE
  /// ================================

  // COMON FIED FOR EVERY DOH
  Future<void> ComanFieldsselectDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      removeLastWidget();
      Coman_filed_date_of_birth = "${pickedDate.day}-${pickedDate.month}-${pickedDate.year}";
      userReply(dob);

      botReply("Color and Marking");

      messages.add({"sender": "user_widget", "widget": "coman_field_color_and_marking_dropdown"});

      setState(() {
        fetchcolorAndMarkings();
      });
    }
  }

  void ComanFiledshowDateOption() {
    setState(() {
      showTextInput = false;

      messages.add({"sender": "user_widget", "widget": "coman_field_date"});
    });
    scrollToBottom();
  }

  /// ================================
  /// SHOW CONFIRM BUTTON
  /// ================================
  void showConfirmButton() {
    setState(() {
      messages.add({"sender": "user_widget", "widget": "confirm"});
    });
    scrollToBottom();
  }

  /// ================================
  /// CONFIRM FORM
  /// ================================
  void confirmForm() {
    removeLastWidget();
    botReply("Thank you $name 🙌");
    showFinalOptions();
  }

  /// ================================
  /// FINAL OPTIONS
  /// ================================
  void showFinalOptions() {
    setState(() {
      messages.add({"sender": "user_widget", "widget": "final_options"});
    });
    scrollToBottom();
  }

  /// ================================
  /// Litter Registration
  /// ================================
  ///
  /// Dam number asked
  void startLitterDamRegistrationFlow() {
    removeLastWidget();
    setState(() {
      messages.add({"sender": "bot", "text": "Is Dam Registerd with INKC?"});
      messages.add({"sender": "user_widget", "widget": "is_Dam_litter_yes_no"});
    });
    scrollToBottom();
  }

  /// ================================
  /// Litter Registration
  /// ================================
  /// Sire number asked
  void startLitterSireRegistrationFlow() {
    setState(() {
      messages.add({"sender": "bot", "text": "Is Sire Registerd with INKC?"});
      messages.add({"sender": "user_widget", "widget": "is_Sire_litter_yes_no"});
    });
    scrollToBottom();
  }

  void Regstatus() {
    setState(() {
      messages.add({"sender": "bot", "text": "Registered Status?"});
      messages.add({"sender": "user_widget", "widget": "litter_status"});
    });
    scrollToBottom();
  }

  void RegstatusforSire() {
    setState(() {
      messages.add({"sender": "bot", "text": "Registered Status?"});
      messages.add({"sender": "user_widget", "widget": "litter_status_sire"});
    });
    scrollToBottom();
  }

  /// ================================
  /// START DOG REGISTRATION
  /// ================================
  void startDogRegistrationFlow() {
    setState(() {
      messages.add({"sender": "bot", "text": "Is Your Dog Registerd with any other club?"});
      messages.add({"sender": "user_widget", "widget": "single_dog_yes_no"});
    });
    scrollToBottom();
  }

  //==========================
  // do you have pedigree info asking question
  //===========================

  void pedigreedogstartDogRegistrationFlow() {
    setState(() {
      messages.add({
        "sender": "bot",
        "text":
            "Do You have padigree infomation of the parents (both or any one parent) of the dog?"
      });
      messages.add({"sender": "user_widget", "widget": "pedigree_info_yes_no"});
    });
    scrollToBottom();
  }

  // // Is sire reqister here
  //=====================
  //=====================
  void is_sire_register_startDogRegistrationFlow() {
    setState(() {
      messages.add({"sender": "bot", "text": "Is sire Registered ?"});
      messages.add({"sender": "user_widget", "widget": "Is_sire_regis_yes_no"});
    });
    scrollToBottom();
  }

  // // Is sire reqister with inkc here
  //=====================
  //=====================
  void is_sire_register_with_inkc_startDogRegistrationFlow() {
    setState(() {
      messages.add({"sender": "bot", "text": "Is sire Registered with INKC ?"});
      messages.add({"sender": "user_widget", "widget": "Is_sire_regis_with_inkc_yes_no"});
    });
    scrollToBottom();
  }

  // // Is sire reqister with inkc here
  //=====================
  //=====================
  void Is_sire_reg_with_any_other_club_startDogRegistrationFlow() {
    setState(() {
      messages.add({"sender": "bot", "text": " Is Sire Registered with any other club?"});
      messages.add({"sender": "user_widget", "widget": "Is_Sire_Reg_other_club_yes_no"});
    });
    scrollToBottom();
  }

  // // Is Dam reqister here
  //=====================
  //=====================
  void is_dam_register_startDogRegistrationFlow() {
    setState(() {
      messages.add({"sender": "bot", "text": "Is Dam Registered ?"});
      messages.add({"sender": "user_widget", "widget": "Is_dam_regis_yes_no"});
    });
    scrollToBottom();
  }

  void Is_damreg_with_inkc() {
    setState(() {
      messages.add({"sender": "bot", "text": "Is Dam Registered with INKC?"});
      messages.add({"sender": "user_widget", "widget": "Is_dam_reg_with_inkc"});
    });
    scrollToBottom();
  }
  //===================
  // dam registration with any other club
  //======================

  void Is_dam_reg_with_any_other_club() {
    setState(() {
      messages.add({"sender": "bot", "text": "Is Dam Registered with any other club?"});
      messages.add({"sender": "user_widget", "widget": "Is_dam_reg_with_any_other_club"});
    });
    scrollToBottom();
  }

  /// ================================
  /// HANDLE YES NO FLOW
  /// ================================
  void handleYesNoSelection(String type, String answer) {
    removeLastWidget();
    userReply(answer);

    if (type == "single_dog") {
      if (answer == "Yes") {
        setState(() {
          botReply("Upload Your Dog's Front Side of the certificate");
          messages.add({"sender": "user_widget", "widget": "Front_image_picker"});
          showTextInput = false; // show text field
        });
        // botReply("Enter Dog Name");
        // askDogRegistered();
        // botReply("Thank you $name 🙌");
      } else {
        pedigreedogstartDogRegistrationFlow();
        // showFinalOptions();
      }
    } else if (type == "dog_registered") {
      if (answer == "Yes") {
        botReply("Proceeding with registered dog flow...");
        botReply("Thank you $name 🙌");
        showFinalOptions();
      } else {
        askDogAge();
      }
    } else if (type == "dog_age") {
      if (answer == "No") {
        botReply("Your dog should be more then 6 months old");
        showFinalOptions();
      } else {
        botReply("Height (in inches)");
        showTextInput = true; // show text field
        GlobalValidations = "heightInches6monthold";
      }
    } else if (type == "add_co_owner") {
      if (answer == "Yes") {
        showCoOwnerInput();
      } else {
        // startDogForm();
        botReply("✅ All details collected!");
        Single_Form_Done_confirmshowConfirmButton();
      }
    }
    //// co-onwer id enter
    else if (type == "add_co_owner") {
      if (answer == "Yes") {
        showCoOwnerInput();
      } else {
        coOwnerId = ""; // No co-owner
        // startDogForm();
        botReply("✅ All details collected!");
        Single_Form_Done_confirmshowConfirmButton();
      }
    } else if (type == "dog_gender") {
      userReply(answer);
      dogStep++;
      botReply("Thank you $name 🙌");
      showFinalOptions();
      // botReply("Enter Country Bred In");
    }

    //===================================
    //single god regsitration form select
    //===============================
    else if (type == "Single_dog_gender_registration_") {
      // userReply(answer);
      Dog_gender = answer;

      botReply("Enter Country Bred In");
      showTextInput = true;
      GlobalValidations = "CountryBredIn_SingleDog";
    }

    //=======================
    // microchip for everyone
    //=======================

    else if (type == "Coman_filed_evryone_dog_gender") {
      // userReply(answer);
      Coman_filed_Dog_gender = answer;

      botReply("Enter Country Bred In");
      showTextInput = true;
      GlobalValidations = "Coman_filed_CountryBredIn_SingleDog";
    } else if (type == "MicroChipAsked") {
      userReply(answer);
      microChipyesorno = answer;
      askAddCoOwner();

      // botReply("Enter Country Bred In");
      // showTextInput = true;
    }

    //==========================
    // do you have pedigree info asking question
    //===========================
    if (type == "pedigree_dog_info_yes_no") {
      if (answer == "Yes") {
        setState(() {
          // botReply("Is Sire registration?");

          is_sire_register_startDogRegistrationFlow();
          // messages.add({"sender": "user_widget", "widget": "Front_image_picker"});
          showTextInput = false; // show text field
        });
      } else {
        askDogAge();
        // pedigreedogstartDogRegistrationFlow();
        // showFinalOptions();
      }
    }

    //===========================
    if (type == "pedigree_Is_sire_regi_yes_no") {
      if (answer == "Yes") {
        setState(() {
          is_sire_register_with_inkc_startDogRegistrationFlow();
          // botReply("Is Sire registration with INKC");
          // messages.add({"sender": "user_widget", "widget": "Front_image_picker"});
          showTextInput = false; // show text field
        });
      } else {
        is_dam_register_startDogRegistrationFlow();
        // pedigreedogstartDogRegistrationFlow();
        // showFinalOptions();
      }
    }
    //===========================
    if (type == "pedigree_Is_sire_regi_with_inkc_yes_no") {
      if (answer == "Yes") {
        setState(() {
          messages.add({"sender": "bot", "text": "Sire's (Father's)INKC Registration number?"});

          // sire_father_inkc_startDogRegistrationFlow();
          // botReply("Is Sire registration with INKC");
          // messages.add({"sender": "user_widget", "widget": "Front_image_picker"});
          showTextInput = true; // show text field
          GlobalValidations = "SireFatherINKCNumb";
        });
      } else {
        Is_sire_reg_with_any_other_club_startDogRegistrationFlow();
        // pedigreedogstartDogRegistrationFlow();
        // showFinalOptions();
      }
    }
    // //===========================
    // if (type == "sire_father_inkc_yes_no") {
    //   if (answer == "Yes") {
    //     setState(() {
    //       botReply("Is Dam registration ?");
    //       // messages.add({"sender": "user_widget", "widget": "Front_image_picker"});
    //       showTextInput = false; // show text field
    //     });
    //   } else {
    //     // pedigreedogstartDogRegistrationFlow();
    //     // showFinalOptions();
    //   }
    // }
    //===========================
    if (type == "pedigreeIs_Sire_Reg_other_club_yes_no") {
      if (answer == "Yes") {
        setState(() {
          botReply("Sire Non-INKC Registration Number?");
          showTextInput = true; // show text field
          GlobalValidations = "SireNonINKCRegNumb";
        });
      } else {
        is_dam_register_startDogRegistrationFlow();
        // pedigreedogstartDogRegistrationFlow();
        // showFinalOptions();
      }
    }

    //============================
    // is dam start here
    //=====================

    if (type == "pedigree_Is_dame_regi_yes_no") {
      if (answer == "Yes") {
        setState(() {
          Is_damreg_with_inkc();
        });
      } else {
        botReply("Breed of the Dam");
        messages.add({"sender": "user_widget", "widget": "Dam_breed_dropdown"});
        // pedigreedogstartDogRegistrationFlow();
        // showFinalOptions();
      }
    }
    if (type == "pedigree_Is_dame_regi_with_inkc_yes_no") {
      if (answer == "Yes") {
        setState(() {
          botReply("Dam's (Mother's) INKC Registration Number?");
          showTextInput = true; // show text field
          GlobalValidations = "DamMotherRegsNumb";
        });
      } else {
        Is_dam_reg_with_any_other_club();
        // pedigreedogstartDogRegistrationFlow();
        // showFinalOptions();
      }
    }
    if (type == "pedigree_Is_dame_regi_with_any_other_club_yes_no") {
      if (answer == "Yes") {
        setState(() {
          botReply("Dam Non-INKC Registration Number?");
          showTextInput = true; // show text field
          GlobalValidations = "motherfrontsidecertificate";
        });
      } else {
        botReply("Select your Date of Birth");
        ComanFiledshowDateOption();
        // pedigreedogstartDogRegistrationFlow();
        // showFinalOptions();
      }
    }
    //==========================
    // Litter Registration start
    //=========================
    if (type == "litter_start") {
      if (answer == "Yes") {
        setState(() {
          botReply("Dam Inkc Registration Number?");
          messages.add({"sender": "user_widget", "widget": "Litter_Dam_list"});

          setState(() {
            fetchdamName();
          });
          // showTextInput = true;
          // GlobalValidations = "litterInkcNumber";
        });
        // botReply("Enter Dog Name");
        // askDogRegistered();
        // botReply("Thank you $name 🙌");
      } else {
        Regstatus(); // pedigreedogstartDogRegistrationFlow();
        // showFinalOptions();
      }
    }

    if (type == "litter_start_sire") {
      if (answer == "Yes") {
        setState(() {
          botReply("Sire INKC Registration Number ?");
          showTextInput = true;
          GlobalValidations = "litterSireInkcNumber";
        });
        // botReply("Enter Dog Name");
        // askDogRegistered();
        // botReply("Thank you $name 🙌");
      } else {
        RegstatusforSire();
        // pedigreedogstartDogRegistrationFlow();
        // showFinalOptions();
      }
    }

    //registered status for dam
    if (type == "litter_start_ask") {
      if (answer == "Yes") {
        setState(() {
          // if (checkvisible == true) {

          //   botReply("Kennel Club Name");
          //   showTextInput = false; // show text field
          //   messages.add({"sender": "user_widget", "widget": "Litter_kennel_name"});
          // } else {

          botReply("Upload Front Side of the Certificate.");
          messages.add(
              {"sender": "user_widget", "widget": "Litter_dam_otherclub_fornt_side_image_picker"});
          // }

          // botReply("Registration Number of Dam ?");
          // showTextInput = true;
          // GlobalValidations = "liiterregNumDam";
        });
        // botReply("Enter Dog Name");
        // askDogRegistered();
        // botReply("Thank you $name 🙌");
      } else {
        botReply(
            "Registration Number of Sire(Father's) and Dam(Mother's) is required for litter registration ?");
        showFinalOptions();
      }
    }
    //registered status for sire
    if (type == "litter_start_sire_ask") {
      if (answer == "Yes") {
        setState(() {
          // if (checkvisible == true) {
          //   botReply("Kennel Club Name");
          //   showTextInput = false; // show text field
          //   messages.add({"sender": "user_widget", "widget": "Litter_kennel_name_sire"});
          // } else {

          botReply("Upload Front Side of the Certificate.");
          messages.add(
              {"sender": "user_widget", "widget": "Litter_sire_otherclub_fornt_side_image_picker"});
          // }
          // botReply("Registration Number of Sire ?");
          // showTextInput = true;
          // GlobalValidations = "liiterregNumSire";
        });
        // botReply("Enter Dog Name");
        // askDogRegistered();
        // botReply("Thank you $name 🙌");
      } else {
        botReply(
            "Registration Number of Sire(Father's) and Dam(Mother's) is required for litter registration ?");
        showFinalOptions();
      }
    }
  }

  // void askDogRegistered() {
  //   botReply("Is your dog registered with any other club?");
  //   setState(() {
  //     showTextInput = false;
  //     messages.add({"sender": "user_widget", "widget": "dog_registered_yes_no"});
  //   });
  // }

  void askDogAge() {
    botReply("Is your dog more than 6 months old?");
    setState(() {
      showTextInput = false;
      messages.add({"sender": "user_widget", "widget": "dog_age_yes_no"});
    });
  }

  void askAddCoOwner() {
    botReply("Add Co-Owner?");
    setState(() {
      showTextInput = false;
      messages.add({"sender": "user_widget", "widget": "add_co_owner_yes_no"});
    });
  }

  void showCoOwnerInput() {
    botReply("Enter Co-Owner ID");
    setState(() {
      showTextInput = false;
      messages.add({"sender": "user_widget", "widget": "co_owner_input"});
    });
  }

  // void startDogForm() {
  //   botReply("Starting Dog Registration Form...");
  // }
  //co-onwer id form
  void startDogForm() {
    if (coOwnerId.isNotEmpty) {
      botReply("Co-Owner ID: $coOwnerId added successfully ✅");
    }
    // setState(() {
    //   showTextInput = true; // show text field
    // });
    // botReply("Enter Dog Name");
  }

  void removeLastWidget() {
    if (messages.isNotEmpty && messages.last["sender"] == "user_widget") {
      messages.removeLast();
    }
  }

  /// ================================
  /// BUILD UI
  /// ================================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("ChatBot")),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return buildMessage(messages[index]);
              },
            ),
          ),
          // if (step < 4)
          if (showTextInput)
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: messageController,
                    decoration: const InputDecoration(hintText: "Type message..."),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    if (messageController.text.isNotEmpty) {
                      handleMessage(messageController.text);
                    }
                  },
                )
              ],
            )
        ],
      ),
    );
  }

  //dog date of birth
  Future<void> selectDogDOB() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      removeLastWidget();

      Date_of_birth = "${pickedDate.day}-${pickedDate.month}-${pickedDate.year}";

      userReply(Date_of_birth);

      botReply("Color and Marking");

      messages.add({"sender": "user_widget", "widget": "color_and_marking_dropdown"});

      setState(() {
        fetchcolorAndMarkings();
      });
    }
  }

  //=================
  //dog date of birth
  // Litter dob
  Future<void> LitterselectDogDOB() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      removeLastWidget();

      litter_Date_of_birth = "${pickedDate.day}-${pickedDate.month}-${pickedDate.year}";

      userReply(litter_Date_of_birth);

      botReply("Breed of the dog");
      messages.add({"sender": "user_widget", "widget": "Litter_Dam_breed_dropdown"});

      setState(() {
        fetchcolorAndMarkings();
      });
    }
  }

  /// ================================
  /// BUILD MESSAGE WIDGETS
  /// ================================
  Widget buildMessage(Map<String, dynamic> message) {
    if (message["sender"] == "user_widget") {
      if (message["widget"] == "gender") {
        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(onPressed: () => selectGender("Male"), child: const Text("Male")),
            const SizedBox(width: 10),
            ElevatedButton(onPressed: () => selectGender("Female"), child: const Text("Female")),
          ],
        );
      }

      if (message["widget"] == "date") {
        return ElevatedButton(onPressed: selectDate, child: const Text("Select Date"));
      }

      if (message["widget"] == "confirm") {
        return ElevatedButton(onPressed: confirmForm, child: const Text("Confirm & Continue"));
      }

      if (message["widget"] == "final_options") {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            ElevatedButton(
                onPressed: () {
                  removeLastWidget();
                  botReply("Service is not Available");
                  showFinalOptions();
                },
                child: const Text("Become Member")),
            ElevatedButton(
                onPressed: () {
                  removeLastWidget();
                  botReply("Enter Kennel Name");
                  showTextInput = true;
                  GlobalValidations = "KennelNameNeter";
                },
                child: const Text("Register Kennel Name")),
            ElevatedButton(
                onPressed: () {
                  removeLastWidget();
                  botReply("What is the name of your dog?");
                  showTextInput = true;
                  GlobalValidations = "whatIsYourDogName";
                },
                child: const Text("Single Dog Registration")),
            ElevatedButton(
                onPressed: () {
                  startLitterDamRegistrationFlow();
                },
                child: const Text("Litter Registratin")),
          ],
        );
      }

      if (message["widget"] == "single_dog_yes_no") {
        return yesNo("single_dog");
      }

      if (message["widget"] == "dog_registered_yes_no") {
        return yesNo("dog_registered");
      }

      if (message["widget"] == "dog_age_yes_no") {
        return yesNo("dog_age");
      }

      if (message["widget"] == "add_co_owner_yes_no") {
        return yesNo("add_co_owner");
      }

      // if (message["widget"] == "co_owner_input") {
      //   TextEditingController controller = TextEditingController();
      //   return TextField(
      //     controller: controller,
      //     decoration: const InputDecoration(hintText: "Enter Co-Owner ID"),
      //     onSubmitted: (value) {
      //       removeLastWidget();
      //       userReply(value);
      //       startDogForm();
      //     },
      //   );
      // }

      //==============
      // litter start
      //===============
      if (message["widget"] == "is_Dam_litter_yes_no") {
        return yesNo("litter_start");
      }

      if (message["widget"] == "is_Sire_litter_yes_no") {
        return yesNo("litter_start_sire");
      }

      if (message["widget"] == "litter_status") {
        return RegStatusyesNo("litter_start_ask");
      }
      if (message["widget"] == "litter_status_sire") {
        return RegStatusSireyesNo("litter_start_sire_ask");
      }
      //// co-owner id form
      if (message["widget"] == "co_owner_input") {
        TextEditingController controller = TextEditingController();

        return TextField(
          controller: controller,
          decoration: const InputDecoration(
            hintText: "Enter Co-Owner ID",
          ),
          onSubmitted: (value) {
            removeLastWidget();
            coOwnerId = value; // SAVE CO OWNER ID
            userReply(value);

            botReply("✅ All details collected!");
            Single_Form_Done_confirmshowConfirmButton();
          },
        );
      }
      if (message["widget"] == "dog_gender") {
        return dogGender("dog_gender");
      }

      if (message["widget"] == "breed_dropdown") {
        return breedDropdownWidget();
      }

      if (message["widget"] == "dog_dob") {
        return ElevatedButton(
          onPressed: selectDogDOB,
          child: const Text("Select Dog Date Of Birth"),
        );
      }
      //=================
      // Litter dog of birth
      //=================
      if (message["widget"] == "litter_dog_dob") {
        return ElevatedButton(
          onPressed: LitterselectDogDOB,
          child: const Text("Select Dog Date Of Birth"),
        );
      }

      //=================
      // 6 month old form
      //=================
      if (message["widget"] == "upload_dog_height_image_picker") {
        return ElevatedButton(
          onPressed: () {
            pickImage("upload_dog_height_image_picker");
          },
          child: const Text("Select Image"),
        );
      }
      if (message["widget"] == "upload_dog_side_image") {
        return ElevatedButton(
          onPressed: () {
            pickImage("upload_dog_side_image");
          },
          child: const Text("Select Image"),
        );
      }

      //
      //==================================
      //single Dog retgistration first yes  start
      // Front image certificate
      //
      //======================
      if (message["widget"] == "Front_image_picker") {
        return ElevatedButton(
          onPressed: () {
            pickImage("Front_side_Certificate_imagePath");
          },
          child: const Text("Select Image"),
        );
      }

      //back side image cetrificate
      if (message["widget"] == "Back_image_picker") {
        return ElevatedButton(
          onPressed: () {
            pickImage("Back_side_Certificate_imagePath");
          },
          child: const Text("Select Image"),
        );
      }
      // if (message["image"] != null) {
      //   return Align(
      //     alignment: Alignment.centerRight,
      //     child: Container(
      //       margin: const EdgeInsets.all(10),
      //       child: Image.file(
      //         File(message["image"]),
      //         width: 200,
      //       ),
      //     ),
      //   );
      // }
      //dog transfer image cetrificate
      if (message["widget"] == "Dog_transfer_image_picker") {
        return ElevatedButton(
          onPressed: () {
            pickImage("dog_tranform_imagePath");
          },
          child: const Text("Select Image"),
        );
      }

      //dog image cetrificate
      if (message["widget"] == "Dog_image_picker") {
        return ElevatedButton(
          onPressed: () {
            pickImage("dog_imagePath");
          },
          child: const Text("Select Image"),
        );
      }

      if (message["widget"] == "kennel_dropdown") {
        return KennelDropdownWidget();
      }
      if (message["widget"] == "color_and_marking_dropdown") {
        return colorandmarkingDropdownWidget();
      }

      if (message["widget"] == "Single_dog_gender_registration_") {
        return dogGender("Single_dog_gender_registration_");
      }
      if (message["widget"] == "MicroChipAsked") {
        return MicroChip("MicroChipAsked");
      }
      if (message["widget"] == "Single_Form_Done_confirm") {
        return ElevatedButton(
            onPressed: Single_Form_Done_confirmconfirmForm,
            child: const Text("Confirm & Continue"));
      }
      //
      //==================================
      //single Dog retgistration first yes finished
      // Front image certificate
      //

      //==========================
      // do you have pedigree info asking question
      //===========================

      if (message["widget"] == "pedigree_info_yes_no") {
        return yesNo("pedigree_dog_info_yes_no");
      }
      if (message["widget"] == "Is_sire_regis_yes_no") {
        return yesNo("pedigree_Is_sire_regi_yes_no");
      }

      if (message["widget"] == "Is_sire_regis_with_inkc_yes_no") {
        return yesNo("pedigree_Is_sire_regi_with_inkc_yes_no");
      }
      if (message["widget"] == "Is_Sire_Reg_other_club_yes_no") {
        return yesNo("pedigreeIs_Sire_Reg_other_club_yes_no");
      }

      // Registration number sire non inkc after
      //dog transfer image cetrificate
      if (message["widget"] == "sire_front_image_picker") {
        return ElevatedButton(
          onPressed: () {
            pickImage("sire_father_front_side_image_picker");
          },
          child: const Text("Select Image"),
        );
      }
      if (message["widget"] == "sire_back_image_picker") {
        return ElevatedButton(
          onPressed: () {
            pickImage("sire_father_back_side_image_picker");
          },
          child: const Text("Select Image"),
        );
      }
      if (message["widget"] == "sire_tranfer_image_picker") {
        return ElevatedButton(
          onPressed: () {
            pickImage("sire_transfer_form_image_picker");
          },
          child: const Text("Select Image"),
        );
      }
      if (message["widget"] == "Sire_breed_dropdown") {
        return SirebreedDropdownWidget();
      }

      //==================
      // is dam start here
      //=================
      if (message["widget"] == "Is_dam_regis_yes_no") {
        return yesNo("pedigree_Is_dame_regi_yes_no");
      }
      if (message["widget"] == "Is_dam_reg_with_inkc") {
        return yesNo("pedigree_Is_dame_regi_with_inkc_yes_no");
      }

      //==================
      // any orher club dam registration
      //==================
      if (message["widget"] == "Is_dam_reg_with_any_other_club") {
        return yesNo("pedigree_Is_dame_regi_with_any_other_club_yes_no");
      }

      // Registration number dam non inkc after
      //dog transfer image cetrificate
      if (message["widget"] == "dam_front_image_picker") {
        return ElevatedButton(
          onPressed: () {
            pickImage("dam_mother_front_side_image_picker");
          },
          child: const Text("Select Image"),
        );
      }

      if (message["widget"] == "dam_back_image_picker") {
        return ElevatedButton(
          onPressed: () {
            pickImage("dam_mother_back_side_image_picker");
          },
          child: const Text("Select Image"),
        );
      }
      if (message["widget"] == "dam_tranfer_image_picker") {
        return ElevatedButton(
          onPressed: () {
            pickImage("dam_transfer_form_image_picker");
          },
          child: const Text("Select Image"),
        );
      }
      if (message["widget"] == "Dam_breed_dropdown") {
        return DambreedDropdownWidget();
      }
      if (message["widget"] == "Litter_Dam_breed_dropdown") {
        return LitterbreedDropdownWidget();
      }

      //===============
      //Coman fileds for every dog
      //====================

      if (message["widget"] == "coman_field_date") {
        return ElevatedButton(onPressed: ComanFieldsselectDate, child: const Text("Select Date"));
      }

      if (message["widget"] == "coman_field_color_and_marking_dropdown") {
        return colorandmarkingDropdownWidget();
      }

      if (message["widget"] == "Coman_Filed_Dog_image_picker") {
        return ElevatedButton(
          onPressed: () {
            pickImage("Coman_Filed_Dog_image_picker");
          },
          child: const Text("Select Image"),
        );
      }
      if (message["widget"] == "Coman_filed_dog_gender") {
        return dogGender("Coman_filed_evryone_dog_gender");
      }

      // Litter Registration
      //Stud agreement form
      if (message["widget"] == "Litter_stud_image_picker") {
        return ElevatedButton(
          onPressed: () {
            pickImage("Litter_stud_form_image_picker");
          },
          child: const Text("Select Image"),
        );
      }

      if (message["sender"] == "user_widget") {
        if (message["widget"] == "gender_selection_widget") {
          return genderSelectionWidget();
        }

        if (message["widget"] == "colorandmarkingDropdownWidgetforLitter") {
          return colorandmarkingDropdownWidgetforLitter();
        }

        // litter registration with other club

        if (message["widget"] == "Litter_kennel_name") {
          return LitterKennelNameDropdownWidget();
        }

        if (message["widget"] == "Litter_Dam_list") {
          return LitterDamListDropdownWidget();
        }

        if (message["widget"] == "Litter_dam_otherclub_fornt_side_image_picker") {
          return ElevatedButton(
            onPressed: () {
              pickImage("Litter_dam_otherclub_fornt_side_image_picker");
            },
            child: const Text("Select Image"),
          );
        }
        if (message["widget"] == "Litter_dam_otherclub_back_side_image_picker") {
          return ElevatedButton(
            onPressed: () {
              pickImage("Litter_dam_otherclub_back_side_image_picker");
            },
            child: const Text("Select Image"),
          );
        }
        if (message["widget"] == "litter_Dam_transfer_imagePath_other_club") {
          return ElevatedButton(
            onPressed: () {
              pickImage("litter_Dam_transfer_imagePath_other_club");
            },
            child: const Text("Select Image"),
          );
        }
        // litter registration  sire with other club
        if (message["widget"] == "Litter_kennel_name_sire") {
          return LitterKennelNameSireDropdownWidget();
        }

        if (message["widget"] == "Litter_sire_otherclub_fornt_side_image_picker") {
          return ElevatedButton(
            onPressed: () {
              pickImage("Litter_sire_otherclub_fornt_side_image_picker");
            },
            child: const Text("Select Image"),
          );
        }

        if (message["widget"] == "Litter_sire_otherclub_back_side_image_picker") {
          return ElevatedButton(
            onPressed: () {
              pickImage("Litter_sire_otherclub_back_side_image_picker");
            },
            child: const Text("Select Image"),
          );
        }
        if (message["widget"] == "litter_sire_transfer_imagePath_other_club") {
          return ElevatedButton(
            onPressed: () {
              pickImage("litter_sire_transfer_imagePath_other_club");
            },
            child: const Text("Select Image"),
          );
        }

        if (message["widget"] == "litter_dog_image") {
          return ElevatedButton(
            onPressed: () {
              pickImage("litter_dogs_image");
            },
            child: const Text("Select Image"),
          );
        }

        // if (message["widget"] == "color_and_marking_dropdown_for_litter") {
        //   return colorandmarkingDropdownWidgetforLitter();
        // }
        // if (message["widget"] == "gender_selection_widget") {
        //   return genderSelectionWidget();
      }
    }
    if (message["image"] != null) {
      return Align(
        alignment: Alignment.centerRight,
        child: Container(
          margin: const EdgeInsets.all(10),
          child: Image.file(
            File(message["image"]),
            width: 200,
          ),
        ),
      );
    }

    bool isUser = message["sender"] == "user";

    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: isUser ? Colors.blue : Colors.grey.shade300,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          message["text"] ?? "",
          style: TextStyle(color: isUser ? Colors.white : Colors.black),
        ),
      ),
    );
  }

  Widget yesNo(String type) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ElevatedButton(
            onPressed: () => handleYesNoSelection(type, "Yes"), child: const Text("Yes")),
        const SizedBox(width: 10),
        ElevatedButton(onPressed: () => handleYesNoSelection(type, "No"), child: const Text("No")),
      ],
    );
  }

  Widget RegStatusyesNo(String type) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        ElevatedButton(
            onPressed: () => handleYesNoSelection(type, "Yes"),
            child: const Text("Registered With Other Club")),
        const SizedBox(width: 10),
        ElevatedButton(
            onPressed: () => handleYesNoSelection(type, "No"), child: const Text("Not Registered")),
      ],
    );
  }

  Widget RegStatusSireyesNo(String type) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        ElevatedButton(
            onPressed: () => handleYesNoSelection(type, "Yes"),
            child: const Text("Registered With Other Club")),
        const SizedBox(width: 10),
        ElevatedButton(
            onPressed: () => handleYesNoSelection(type, "No"), child: const Text("Not Registered")),
      ],
    );
  }

  Widget dogGender(String type) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ElevatedButton(
            onPressed: () => handleYesNoSelection(type, "Male"), child: const Text("Male")),
        const SizedBox(width: 10),
        ElevatedButton(
            onPressed: () => handleYesNoSelection(type, "Female"), child: const Text("Female")),
      ],
    );
  }

  Widget MicroChip(String type) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ElevatedButton(
            onPressed: () => handleYesNoSelection(type, "Yes"), child: const Text("Yes")),
        const SizedBox(width: 10),
        ElevatedButton(onPressed: () => handleYesNoSelection(type, "No"), child: const Text("No")),
      ],
    );
  }

  Widget SirebreedDropdownWidget() {
    return Container(
      padding: const EdgeInsets.all(3),
      child: DropdownButtonFormField<BreedModel>(
        hint: const Text("Select Dog Breed"),
        items: breedList.map((breed) {
          return DropdownMenuItem(
            value: breed,
            child: Text(breed.name),
          );
        }).toList(),
        onChanged: (value) {
          SirebreedId = value!.id;
          SirebreedName = value.name;

          removeLastWidget();

          userReply(SirebreedName!);

          is_dam_register_startDogRegistrationFlow();
          // showTextInput = true; // show text field

          setState(() {});
        },
      ),
    );
  }

  Widget DambreedDropdownWidget() {
    return Container(
      padding: const EdgeInsets.all(3),
      child: DropdownButtonFormField<BreedModel>(
        hint: const Text("Select Dog Breed"),
        items: breedList.map((breed) {
          return DropdownMenuItem(
            value: breed,
            child: Text(breed.name),
          );
        }).toList(),
        onChanged: (value) {
          DambreedId = value!.id;
          DambreedName = value.name;

          removeLastWidget();

          userReply(DambreedName!);

          botReply("Select your Date of Birth");
          ComanFiledshowDateOption();
        },
      ),
    );
  }

  // litter registation drop down
  Widget LitterbreedDropdownWidget() {
    return Container(
      padding: const EdgeInsets.all(3),
      child: DropdownButtonFormField<BreedModel>(
        hint: const Text("Select Dog Breed"),
        items: breedList.map((breed) {
          return DropdownMenuItem(
            value: breed,
            child: Text(breed.name),
          );
        }).toList(),
        onChanged: (value) {
          litterbreedId = value!.id;
          litterbreedName = value.name;

          removeLastWidget();

          userReply(litterbreedName!);

          botReply("Contry bred in");
          showTextInput = true;
          GlobalValidations = "littercountrybredin";
        },
      ),
    );
  }

  Widget LitterDamListDropdownWidget() {
    return Container(
      padding: const EdgeInsets.all(3),
      child: DropdownButtonFormField<DogDamLisrModel>(
        hint: const Text("Select Dog dam"),
        items: DamList.map((breed) {
          return DropdownMenuItem(
            value: breed,
            child: Text(breed.name.toString() + "(${breed.pet_registration_number})"),
          );
        }).toList(),
        onChanged: (value) {
          DamId = value!.id;
          DamName = value.name.toString() + "(${value.pet_registration_number})";

          removeLastWidget();

          userReply(DamName!);

          startLitterSireRegistrationFlow();
          showTextInput = false; // show text field
        },
      ),
    );
  }

  //  inside when puppy work
  Widget LitterKennelNameDropdownWidget() {
    return Container(
        padding: const EdgeInsets.all(3),
        child: Visibility(
          visible: checkvisible,
          child: FutureBuilder(
              future: insertvalue(),
              builder: (context, snapshot) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        DropdownButtonFormField<String>(
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.only(left: 30, right: 10),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10))),
                          ),
                          hint: const Text("selected value"),
                          value: selectedValue,
                          onChanged: (String? newValue) {
                            setState(() {
                              litterdamKennelNam_other_club = newValue;
                              String nameStore = newValue!;
                              // print("$newValue new values");

                              removeLastWidget();

                              userReply(litterdamKennelNam_other_club!);

                              botReply("Number of puppies in the litter");
                              GlobalValidations = "numberopuppies";
                              showTextInput = true;
                            });
                            if (newValue != null) {
                              //Handle dropdown value change
                              print(newValue);
                              selectedValue = newValue;
                            }
                          },
                          isExpanded: true,
                          items: keyValueList
                              .map<DropdownMenuItem<String>>((Map<String, String> pair) {
                            final String key = pair.keys.first;
                            final String value = pair.values.first;

                            return DropdownMenuItem<String>(
                              value: key,
                              child: Text(
                                value.toString(),
                                style: TextStyle(
                                    color: const Color.fromARGB(255, 95, 46, 46),
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                );
              }),
        ));
  }

  Widget LitterKennelNameSireDropdownWidget() {
    return Container(
        padding: const EdgeInsets.all(3),
        child: Visibility(
          visible: checkvisible,
          child: FutureBuilder(
              future: insertvalue(),
              builder: (context, snapshot) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        DropdownButtonFormField<String>(
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.only(left: 30, right: 10),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10))),
                          ),
                          hint: const Text("selected value"),
                          value: selectedValue,
                          onChanged: (String? newValue) {
                            setState(() {
                              littersireKennelNam_other_club = newValue;
                              print("$newValue new values");

                              botReply("Upload Front Side of the Certificate.");
                              messages.add({
                                "sender": "user_widget",
                                "widget": "Litter_sire_otherclub_fornt_side_image_picker"
                              });
                            });
                            // if (newValue != null) {
                            //   //Handle dropdown value change
                            //   print(newValue);
                            //   selectedValue = newValue;
                            // }
                          },
                          isExpanded: true,
                          items: keyValueList
                              .map<DropdownMenuItem<String>>((Map<String, String> pair) {
                            final String key = pair.keys.first;
                            final String value = pair.values.first;

                            return DropdownMenuItem<String>(
                              value: key,
                              child: Text(
                                value.toString(),
                                style: TextStyle(
                                    color: const Color.fromARGB(255, 95, 46, 46),
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                );
              }),
        ));
  }

//==============
// first dog Form drop down
////================
  Widget KennelDropdownWidget() {
    return Container(
      padding: const EdgeInsets.all(3),
      child: DropdownButtonFormField<Kennelmodel>(
        hint: const Text("Select kennel name"),
        items: KennelList.map((kennel) {
          return DropdownMenuItem(
            value: kennel,
            child: Text(kennel.name),
          );
        }).toList(),
        onChanged: (value) {
          KennelId = value!.id;
          kennelName = value.name;

          removeLastWidget();

          userReply(kennelName!);

          botReply("Select Dog Breed");

          messages.add({"sender": "user_widget", "widget": "breed_dropdown"});

          setState(() {
            fetchBreeds();
          });
        },
      ),
    );
  }

  Widget colorandmarkingDropdownWidget() {
    return Container(
      padding: const EdgeInsets.all(3),
      child: DropdownButtonFormField<ColorAndMaking>(
        hint: const Text("Select kennel name"),
        items: colorAndMarkingList.map((kennel) {
          return DropdownMenuItem(
            value: kennel,
            child: Text(kennel.colourName.toString()),
          );
        }).toList(),
        onChanged: (value) {
          colorAndMarkingId = value!.colourId;
          colorAndMarkingName = value.colourName.toString();

          removeLastWidget();

          userReply(colorAndMarkingName!);

          botReply("Upload your dog's photograph");

          messages.add({"sender": "user_widget", "widget": "Dog_image_picker"});
          showTextInput = false;
        },
      ),
    );
  }

  // Widget colorandmarkingDropdownWidgetforLitter() {
  //   return Container(
  //     padding: const EdgeInsets.all(3),
  //     child: DropdownButtonFormField<ColorAndMaking>(
  //         hint: const Text("Select kennel name"),
  //         items: colorAndMarkingList.map((kennel) {
  //           return DropdownMenuItem(
  //             value: kennel,
  //             child: Text(kennel.colourName.toString()),
  //           );
  //         }).toList(),
  //         onChanged: (value) {
  //           if (value == null) return;

  //           puppyColorIds.add(value.colourId!);

  //           removeLastWidget();

  //           userReply(value.colourName.toString());

  //           currentPuppyIndex++;

  //           if (currentPuppyIndex < totalPuppies) {
  //             // 🔁 Next puppy
  //             botReply("Enter name for puppy ${currentPuppyIndex + 1}");

  //             showTextInput = true;
  //             GlobalValidations = "puppy_name";
  //           } else {
  //             // ✅ Done
  //             botReply("All puppy data collected ✅");

  //             print("Names: $puppyNames");
  //             print("Genders: $puppyGenders");
  //             print("Colors: $puppyColorIds");

  //             GlobalValidations = "next_step";
  //             showTextInput = true;
  //           }
  //         }
  //         // onChanged: (value) {
  //         //   if (value == null) return;

  //         //   // ✅ Store in array
  //         //   puppyColorIds.add(value.colourId!);
  //         //   puppyColorNames.add(value.colourName.toString());

  //         //   removeLastWidget();

  //         //   userReply(value.colourName.toString());

  //         //   currentPuppyIndex++;

  //         //   if (currentPuppyIndex < totalPuppies) {
  //         //     // 🔁 Ask next puppy
  //         //     botReply("Select color & marking for puppy ${currentPuppyIndex + 1}");

  //         //     messages.add(
  //         //         {"sender": "user_widget", "widget": "color_and_marking_dropdown_for_litter"});
  //         //   } else {
  //         //     // ✅ All puppies done
  //         //     botReply("All puppy data collected ✅");

  //         //     print("Puppy Color IDs: $puppyColorIds");
  //         //     print("Puppy Names: $puppyColorNames");

  //         //     // 👉 Move to next step
  //         //     GlobalValidations = "next_step"; // change as per your flow
  //         //     showTextInput = true;
  //         //   }
  //         // }

  //         ),
  //   );
  // }

  Widget colorandmarkingDropdownWidgetforLitter() {
    return Container(
      padding: const EdgeInsets.all(3),
      child: DropdownButtonFormField<ColorAndMaking>(
        hint: const Text("Select color & marking"),
        items: colorAndMarkingList.map((kennel) {
          return DropdownMenuItem(
            value: kennel,
            child: Text(kennel.colourName.toString()),
          );
        }).toList(),
        onChanged: (value) {
          if (value == null) return;

          puppyColorIds.add(value.colourId!);
          puppyColorNames.add(value.colourName.toString());

          removeLastWidget();

          userReply(value.colourName.toString());

          currentPuppyIndex++;

          if (currentPuppyIndex < totalPuppies) {
            // 🔁 NEXT PUPPY
            botReply("🐶 Puppy ${currentPuppyIndex + 1}\nEnter puppy name");

            showTextInput = true;
            GlobalValidations = "puppy_name";
          } else {
            // ✅ DONE
            botReply("All puppy data collected ✅");
            botReply("Please Wait...");

            // LitterRegistrationApi();

            print("Names: $puppyNames");
            print("Genders: $puppyGenders");
            print("Colors: $puppyColorIds");

            GlobalValidations = "next_step";
            showTextInput = true;
          }
        },
      ),
    );
  }

  Widget genderSelectionWidget() {
    return Row(
      children: [
        ElevatedButton(
          onPressed: () => onGenderSelected(1),
          child: Text("Male"),
        ),
        SizedBox(width: 10),
        ElevatedButton(
          onPressed: () => onGenderSelected(0),
          child: Text("Female"),
        ),
      ],
    );
  }

  void onGenderSelected(int gender) {
    puppyGenders.add(gender);

    removeLastWidget();

    userReply(gender == 1 ? "Male" : "Female");

    botReply("Select color & marking for puppy ${currentPuppyIndex + 1}");

    messages.add({"sender": "user_widget", "widget": "colorandmarkingDropdownWidgetforLitter"});

    GlobalValidations = "puppy_color";
  }

  Widget breedDropdownWidget() {
    return Container(
      padding: const EdgeInsets.all(3),
      child: DropdownButtonFormField<BreedModel>(
        hint: const Text("Select Dog Breed"),
        items: breedList.map((breed) {
          return DropdownMenuItem(
            value: breed,
            child: Text(breed.name),
          );
        }).toList(),
        onChanged: (value) {
          breedId = value!.id;
          breedName = value.name;

          removeLastWidget();

          userReply(breedName!);

          botReply("Name of the dog");
          showTextInput = true; // show text field
          GlobalValidations = "NameOfTheDog";
          setState(() {});
        },
      ),
    );
  }
// first dog finisherd

  Widget ComanFieldscolorandmarkingDropdownWidget() {
    return Container(
      padding: const EdgeInsets.all(3),
      child: DropdownButtonFormField<ColorAndMaking>(
        hint: const Text("Select kennel name"),
        items: colorAndMarkingList.map((kennel) {
          return DropdownMenuItem(
            value: kennel,
            child: Text(kennel.colourName.toString()),
          );
        }).toList(),
        onChanged: (value) {
          comanfiledcolorAndMarkingId = value!.colourId;
          comanfiledcolorAndMarkingName = value.colourName.toString();

          removeLastWidget();

          userReply(colorAndMarkingName!);

          botReply("Upload your dog's photograph");

          messages.add({"sender": "user_widget", "widget": "Coman_Filed_Dog_image_picker"});
          showTextInput = false;
        },
      ),
    );
  }
}
