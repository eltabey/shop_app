import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/components/cmponents.dart';
import 'package:shop_app/shared/cubit/states.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'layout/shop_app/cubit/cubit.dart';
import 'layout/shop_app/shop_layout.dart';
import 'modules/login/cubit/cubit.dart';
import 'modules/login/shop_login.dart';
import 'modules/on_boarding/on_boarding_screen.dart';
import 'shared/cubit/cubit.dart';

void main() async {
  // عشان يتأكد ان كل حاجه المفروض تحصل قبل ما يرن لابلكيشن انها حصلت فعلا و خلصت
  WidgetsFlutterBinding.ensureInitialized();

  await CacheHelper.init();

  Widget widget;
  bool onBoarding = CacheHelper.getData(key: 'onBoarding');
  String token = CacheHelper.getData(key: 'token');

  token = CacheHelper.getData(key: 'token');


  if (onBoarding != null) {
    if (token != null)
      widget = ShopLayout();
    else
      widget = LoginScreen();
  } else {
    widget = OnBoardingScreen();
  }

  runApp(
    MyApp(
      startWidget: widget,
    ),
  );
}

class MyApp extends StatelessWidget {
  final Widget startWidget;

  MyApp({
    this.startWidget,
  });

  @override
  Widget build(BuildContext context) {
    DioHelper.init();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (BuildContext context) =>AppCubit(),
        ),
        BlocProvider(
          create: (BuildContext context) =>LoginCubit()..userLogin(),
        ),
        BlocProvider(
          create: (BuildContext context) =>ShopCubit()..getHomeData(),
        ),
      ],
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (context,state){},
        builder: (context,state){
          return MaterialApp(
            theme: ThemeData(
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Colors.deepOrange,
                unselectedItemColor: Colors.grey,
                elevation: 20.0,
                //backgroundColor: HexColor('333739'),
              ),
              primarySwatch: Colors.orange,
              fontFamily: 'jannah',
              //visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            home: startWidget,
            //ShopLayout(),
          );
        },

      ),
    );

    /*   */
  }
}
