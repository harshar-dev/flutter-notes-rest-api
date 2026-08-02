import 'package:get/get.dart';
import 'package:notes_app/add_notes/add_notes_view.dart';
import 'package:notes_app/detail/detail_view.dart';
import 'package:notes_app/home/home_view.dart';
import 'package:notes_app/login/login_view.dart';
import 'package:notes_app/signup/signup_view.dart';
import 'package:notes_app/splash/splash_view.dart';


dynamic appRoutes()=>[
  GetPage(name: '/home', page: ()=>HomeView()),
  GetPage(name: '/add-notes', page: ()=>AddNotesView()),
  GetPage(name: '/detailpage', page: ()=>DetailView()),
  GetPage(name: '/signup', page: ()=>SignupView()),
  GetPage(name: '/login', page: ()=>LoginView()),
  GetPage(name: '/splash', page: ()=>SplashView())
];