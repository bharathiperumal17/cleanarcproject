import 'package:cleanarcproject/features/Auth/presentation/pages/log_in.dart';
import 'package:cleanarcproject/features/Auth/presentation/pages/sign_up.dart';
import 'package:cleanarcproject/features/home/presentation/screen/add_new_blog.dart';
import 'package:cleanarcproject/features/home/presentation/screen/home_page.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  Route onGenerateRoutes(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => const LogIn(),
        );
      case 'signup':
        return MaterialPageRoute(
          builder: (_) => const SignUp(),
        );
      case 'home':
        return MaterialPageRoute(
          builder: (_) => const HomePage(),
        );
      case 'newBlog':
        return MaterialPageRoute(
          builder: (_) => const AddNewBlogPage(),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => const LogIn(),
        );
    }
  }
}
