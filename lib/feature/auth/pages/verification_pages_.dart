import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whats_app_me/common/Wigets/custom_icon_button.dart';
import 'package:whats_app_me/common/extention/custom_Theme_extention.dart';
import 'package:whats_app_me/feature/auth/Controller/auth_controller.dart';
import 'package:whats_app_me/feature/auth/Widgets/custom_text_filed.dart';

class verificationPage extends ConsumerWidget {
  const verificationPage({Key? key, required this.smsCodeId, required this.phoneNumber,}) : super(key: key);
  final String smsCodeId;
  final String phoneNumber;

void verifySmsCode(BuildContext context,WidgetRef ref,String smsCode,){
  ref.read(authControllerProvider).verifySmsCode(context: context, smsCodeId: smsCodeId, smsCode: smsCode, mounted: true);
}

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        elevation: 0,
        title: Text(
          "verify your number",
          style: TextStyle(color: context.theme.authAppbarTextColor),
        ),
        centerTitle: true,
        actions: [
          CustomIconButton(onTap:(){}, icon: Icons.more_vert)
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Padding(padding: EdgeInsets.symmetric(horizontal: 10),
            child:RichText(
              textAlign: TextAlign.center,text: TextSpan(
              style: TextStyle(color: context.theme.graycolor,height: 1.5,),
              children: [
                TextSpan(text: "You've tried to register +918168456920.before requsting an SMS or call with your code.",),
                TextSpan(text: "Wrong number?",style: TextStyle(color: context.theme.bluecolor),),
              ]
            ),
            )
            ),
            SizedBox(height: 20,),
            Container(
              padding:  EdgeInsets.symmetric(horizontal: 80),
              child: CustomTextFiled(
                hintText: "- - - - - -",
                fontSize: 30,
                maxLength: 6,
                autoFocus: true,
               keyboradType: TextInputType.number,
                onChanged: (value){
                  if(value.length == 6){
                    return verifySmsCode(context, ref, value);
                  }
                },
              ),
            ),
            SizedBox(height: 20,),
            Text("Enter 6-digit code",style: TextStyle(color: context.theme.graycolor),

            ),
            SizedBox(height: 30,),
            Row(children: [
              Icon(Icons.message,color: context.theme.graycolor,),
              SizedBox(width: 20,),
              Text('Resend SMS',style: TextStyle(color: context.theme.graycolor),),

            ],),
            SizedBox(height: 10,),
            Divider(color: context.theme.bluecolor!.withOpacity(0.2),),

      Row(children: [
        Icon(Icons.phone,color: context.theme.graycolor,),
        SizedBox(width: 20,),
        Text('Call Me ',style: TextStyle(color: context.theme.graycolor),),


      ],
        ),]
    ),
    ),
    );
  }
}
