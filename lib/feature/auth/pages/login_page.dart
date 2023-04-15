import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whats_app_me/common/Wigets/custom_elevated_button.dart';
import 'package:whats_app_me/common/Wigets/custom_icon_button.dart';
import 'package:whats_app_me/common/extention/custom_Theme_extention.dart';
import 'package:whats_app_me/common/helper/show_alert_dialog.dart';
import 'package:whats_app_me/common/utils/coloors.dart';
import 'package:whats_app_me/feature/auth/Controller/auth_controller.dart';
import 'package:whats_app_me/feature/auth/Widgets/custom_text_filed.dart';
import 'package:country_picker/country_picker.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});


  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  TextEditingController? countryNameController;
  TextEditingController? countryCodeController;
  TextEditingController? phoneNumberController;

  sendCodeToPhone() async{
    final phoneNumber = phoneNumberController!.text;
    final countryName = countryNameController!.text;
    final countryCode = countryCodeController!.text;

    if (phoneNumber.isEmpty) {
      showAlertDialog(

        context: context,
        Message: "please enter your phone number",
      );
    } else if (phoneNumber.length < 9) {
      showAlertDialog(
        context: context,
        Message:
            "The phone number you entered is too short for the country: $countryName.\n\nInclude your area code if you heven't",
      );
    } else if (phoneNumber.length > 10) {
       showAlertDialog(
        context: context,
        Message:
            "The phone number entered you is too long for the country:$countryName",
      );
    }else{
      print("hgfhfhfg");
      ref.read<AuthController>(authControllerProvider).sendSmsCode(context: context, PhoneNumber: "+$countryCode$phoneNumber",);
    }

  }

  showCounteryCodePicker() {
    showCountryPicker(
      context: context,
      showPhoneCode: true,
      favorite: ['IN'],
      countryListTheme: CountryListThemeData(
        bottomSheetHeight: 600,
        backgroundColor: Theme.of(context).backgroundColor,
        flagSize: 22,
        borderRadius: BorderRadius.circular(20),
        textStyle: TextStyle(color: context.theme.graycolor),
        inputDecoration: InputDecoration(
          labelStyle: TextStyle(color: context.theme.graycolor),
          prefixIcon: const Icon(
            Icons.language,
            color: coloors.greendark,
          ),
          hintText: "Search countery code or name",
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: context.theme.graycolor!.withOpacity(0.2),
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: context.theme.graycolor!.withOpacity(0.2),
            ),
          ),
        ),
      ),
      onSelect: (country) {
        countryNameController!.text = country.name;
        countryCodeController!.text = country.phoneCode;
      },
    );
  }

  @override
  void initState() {
    countryNameController = TextEditingController(text: "INDIA");
    countryCodeController = TextEditingController(text: "91");
    phoneNumberController = TextEditingController();
    setState(() {

    });
    super.initState();
  }

  @override
  void dispose() {
    countryNameController!.dispose();
    countryCodeController!.dispose();
    phoneNumberController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        title: Text(
          "Enter you phone number",
          style: TextStyle(color: context.theme.authAppbarTextColor),
        ),
        centerTitle: true,
        actions: [
          CustomIconButton(
            onTap: () {},
            icon: Icons.more_vert,
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                  text: "WhatApp will need to verify yours phone number.'",
                  style: TextStyle(color: context.theme.graycolor),
                  children: [
                    TextSpan(
                        text: "What's my number?",
                        style: TextStyle(color: context.theme.bluecolor))
                  ]),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: CustomTextFiled(
              onTap: (){
                showCounteryCodePicker();
              },
              controller: countryNameController,
              readOnly: true,
              suffixIcone: Icon(
                Icons.arrow_drop_down,
                color: coloors.greendark,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Row(
              children: [
                SizedBox(
                  width: 70,
                  child: CustomTextFiled(
                    onTap: (){
                      showCounteryCodePicker();
                    },
                    controller: countryCodeController,
                    prefixText: "+",
                    readOnly: true,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: CustomTextFiled(
                    controller: phoneNumberController,
                    hintText: "Phone Number",
                    textAlign: TextAlign.left,
                    keyboradType: TextInputType.number,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "Carrier charges may apply",
            style: TextStyle(color: context.theme.graycolor),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Custom_ElevatedButton(
        onPressed: (){
          print("vhncnb");
          sendCodeToPhone();
        },
        text: 'NEXT',
        buttonwidth: 90,
      ),
    );
  }
}
