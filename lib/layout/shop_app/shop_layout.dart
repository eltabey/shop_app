import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_app/cubit/states.dart';
import 'package:shop_app/modules/login/cubit/states.dart';
import 'package:shop_app/modules/login/shop_login.dart';
import 'package:shop_app/modules/sarsh/searsh_screen.dart';
import 'package:shop_app/shared/components/cmponents.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'cubit/cubit.dart';

class ShopLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopCubit()..getHomeData()..getCategories(),
      child: BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = ShopCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              title: Text('Salla'),
              elevation: 0.0,
              actions: [
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SearchScreen()),
                    );
                  },
                )
              ],
            ),
            body: cubit.bottomScreens[cubit.currentIndex],
            floatingActionButton: FloatingActionButton(
              onPressed: ()
              {
                CacheHelper.removeData(key: 'token').then((value)
                {
                  if(value)
                  {
                    navigateAndFinish(
                      context: context,
                      widget: LoginScreen()
                    );
                  }
                });
              },
              child: Text('Sign out'),
            ),
            bottomNavigationBar: BottomNavigationBar(
              onTap: (index) {
                cubit.changeBottom(index);
              },
              currentIndex: cubit.currentIndex,
              items: [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                  ),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.apps,
                  ),
                  label: 'Categories',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.favorite,
                  ),
                  label: 'favorites',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.settings,
                  ),
                  label: 'settings',
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
