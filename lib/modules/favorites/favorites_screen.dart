import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_app/cubit/cubit.dart';
import 'package:shop_app/layout/shop_app/cubit/states.dart';
import 'package:shop_app/models/favorites_model.dart';
import 'package:shop_app/shared/components/cmponents.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopCubit()..getFavorites(),
      child: BlocConsumer<ShopCubit, ShopStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return ListView.separated(
              itemBuilder: (context, index) => buildFavItem(
                  ShopCubit.get(context).favoritesModel.data.data[index],
                  context),
              //ShopCubit.get(context).categoriesModel.data.data[index]),
              separatorBuilder: (context, index) => myDivider(),
              itemCount: ShopCubit.get(context).favoritesModel.data.data.length,
            );
          }),
    );
  }

  Widget buildFavItem(FavoritesData model, context) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          height: 120,
          child: Row(
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  Image(
                    image: NetworkImage(model.product.image),
                    height: 120,
                    width: 120,
                    //fit: BoxFit.cover,
                  ),
                  if (model.product.discount != 0)
                    Container(
                      color: Colors.red,
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: Text(
                        'DISCOUNT',
                        style: TextStyle(color: Colors.white, fontSize: 10.0),
                      ),
                    )
                ],
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                      model.product.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(height: 1.3, fontSize: 14.0),
                    ),
                    Spacer(),
                    Row(
                      children: [
                        Text(
                          '${model.product.price.round()}',
                          style: TextStyle(
                            fontSize: 12.0,
                            color: Colors.deepOrange,
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        if (
                        //model.discount
                        1 != 0)
                          Text(
                            '${model.product.oldPrice.round()}',
                            style: TextStyle(
                              fontSize: 10.0,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        Spacer(),
                        IconButton(
                          onPressed: () {
                            ShopCubit.get(context)
                                .changeFavorites(model.product.id);
                            //print(model.id);
                            //  print(model.name);
                          },
                          icon: CircleAvatar(
                            radius: 15.0,
                            backgroundColor: ShopCubit.get(context)
                                    .favorites[model.product.id]
                                ? Colors.deepOrangeAccent
                                : Colors.grey,
                            child: Icon(
                              Icons.favorite_border,
                              color: Colors.white,
                              size: 14.0,
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
