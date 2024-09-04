
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:task2/shared/MainCubit/cubit.dart';
import 'package:task2/shared/network/local/Cash_helper.dart';
import 'package:task2/shared/network/local/Database_helper.dart';
import 'package:task2/shared/network/remote/dio_helper.dart';

import 'generated/l10n.dart';
import 'modules/homeScreen/homeScreen.dart';







final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();


  await DioHelper.init();
  await CashHelper.init();
  await DBHelper.initDb();
  runApp( const MyApp( ));
}










class MyApp extends StatelessWidget {

  const MyApp({super.key});



  @override
  Widget build(BuildContext context) {


    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) {
          return AppCubit()..getALLFavoritesTitles();
        }),
      ],
      child:   GetMaterialApp(
          key: const Key('ar'),
          locale: const Locale('ar'),
          localizationsDelegates:  const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
          debugShowCheckedModeBanner: false,
          home:  const HomeScreen()
      ),
    );
  }
}
