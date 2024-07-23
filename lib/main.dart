import 'package:cleanarcproject/core/common/widget/cubit/app_user_cubit/appuser_cubit.dart';
import 'package:cleanarcproject/core/routes/name_routes.dart';
import 'package:cleanarcproject/core/theme/theme.dart';
import 'package:cleanarcproject/features/Auth/presentation/bloc/auth_bloc.dart';
import 'package:cleanarcproject/features/home/presentation/bloc/bloc/blog_bloc.dart';
import 'package:cleanarcproject/init_dependecies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependecies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => serviceLocator<AppuserCubit>(),
        ),
        BlocProvider(
          create: (_) => serviceLocator<AuthBloc>(),
        ),
        BlocProvider(
          create: (context) => serviceLocator<BlogBloc>(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.darkThemeMode,
        initialRoute: '/',
        onGenerateRoute: AppRoutes().onGenerateRoutes,
      ),
    );
  }
}
