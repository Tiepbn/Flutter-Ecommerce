import 'package:emart_app/controllers/auth_controller.dart';
import 'package:emart_app/view/auth_screen/login_screen.dart';
import 'package:emart_app/view/home_screen/home.dart';
import 'package:flutter/material.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/widgets_common/applogo_widget.dart';
import 'package:emart_app/widgets_common/bg_widget.dart';
import 'package:emart_app/widgets_common/custom_textfield.dart';
import 'package:emart_app/widgets_common/our_button.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool? isCheck = false;
  var controller = Get.put(AuthController());

  //text controller
  var nameController = TextEditingController();
  var emailContronller = TextEditingController();
  var passwordController = TextEditingController();
  var passwordRetypeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return bgWidget(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Column(
            children: [
              (context.screenHeight * 0.1).heightBox,
              applogoWidget(),
              10.heightBox,
              "Join to Hanh Ecommerct"
                  .text
                  .fontFamily(regular)
                  .white
                  .size(18)
                  .make(),
              15.heightBox,
              10.heightBox,
              Obx(
                () => Column(
                  children: [
                    customTextField(
                        hint: nameHint,
                        title: name,
                        controller: nameController,
                        isPass: false),
                    customTextField(
                        hint: emailHint,
                        title: email,
                        controller: emailContronller,
                        isPass: false),
                    customTextField(
                        hint: passwordHint,
                        title: password,
                        controller: passwordController,
                        isPass: true),
                    customTextField(
                        hint: password,
                        title: retypePassword,
                        controller: passwordRetypeController,
                        isPass: true),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                          onPressed: () {}, child: forgetPass.text.make()),
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: alreadyHaveAccount,
                            style:
                                TextStyle(fontFamily: regular, color: fontGrey),
                          ),
                          TextSpan(
                            text: login,
                            style:
                                TextStyle(fontFamily: regular, color: redColor),
                          ),
                        ],
                      ),
                    ).onTap(() {
                      Get.back();
                    }),
                    5.heightBox,
                    5.heightBox,
                    controller.isloadng.value
                        ? const CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(redColor),
                          )
                        : ourButton(
                            color: isCheck == true ? redColor : lightGrey,
                            title: signup,
                            textColor: whiteColor,
                            onPress: () async {
                              if (isCheck != false) {
                                controller.isloadng(true);
                                try {
                                  await controller
                                      .signupMethod(
                                          context: context,
                                          email: emailContronller.text,
                                          password: passwordController.text)
                                      .then((value) {
                                    return controller.storeUserData(
                                      email: emailContronller.text,
                                      password: passwordController.text,
                                      name: nameController.text,
                                    );
                                  }).then((value) {
                                    VxToast.show(context, msg: loggedin);
                                    Get.offAll(() => Home());
                                  });
                                } catch (e) {
                                  auth.signOut();
                                  VxToast.show(context, msg: e.toString());
                                  controller.isloadng(false);
                                }
                              }
                            },
                          ).box.width(context.screenWidth - 50).make(),
                    Row(
                      children: [
                        Checkbox(
                          checkColor: whiteColor,
                          activeColor: redColor,
                          value: isCheck,
                          onChanged: (newValue) {
                            setState(() {
                              isCheck = newValue;
                            });
                          },
                        ),
                        10.widthBox,
                        Expanded(
                          child: RichText(
                              text: TextSpan(children: [
                            TextSpan(
                              text: "I agree to the ",
                              style: TextStyle(
                                fontFamily: regular,
                                color: fontGrey,
                              ),
                            ),
                            TextSpan(
                                text: termAndCond,
                                style: TextStyle(
                                  fontFamily: regular,
                                  color: redColor,
                                )),
                            TextSpan(
                                text: " & ",
                                style: TextStyle(
                                  fontFamily: regular,
                                  color: fontGrey,
                                )),
                            TextSpan(
                                text: privacyPolicy,
                                style: TextStyle(
                                  fontFamily: regular,
                                  color: redColor,
                                ))
                          ])),
                        )
                      ],
                    )
                  ],
                )
                    .box
                    .white
                    .rounded
                    .padding(const EdgeInsets.all(16))
                    .width(context.screenWidth - 70)
                    .make(),
              ),
              10.heightBox,
            ],
          ),
        ),
      ),
    );
  }
}
