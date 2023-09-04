import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:get/get.dart';
import 'package:push_notification/Pages/main_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({ Key? key }) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 2),(){
      Get.to(()=>MainPage(),transition: Transition.fade,duration: Duration(seconds: 1),);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody,
    );
  }
  Widget get _buildBody{
    return Center(
      child: SizedBox(
        width: 300,
        height: 300,
        child: Lottie.asset('assets/lotties/msgLoading.json')),
    );
  }
}