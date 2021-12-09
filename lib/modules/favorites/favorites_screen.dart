import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:light_mart/layout/cubit/cubit.dart';
import 'package:light_mart/layout/cubit/states.dart';
import 'package:light_mart/models/favorites_model.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) => ConditionalBuilder(
        condition: state is !ShopLoadingGetFavoritesStates,
        builder: (context) => ListView.separated(
          itemBuilder: (context, index) => buildFavItem(
              context, ShopCubit.get(context).favoritesModel.data.data[index]),
          separatorBuilder: (context, index) => Divider(),
          itemCount: ShopCubit.get(context).favoritesModel.data.data.length,
        ),
        fallback: (BuildContext context) => Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  Widget buildFavItem(
    BuildContext context,
    FavoritesData data,
  ) =>
      Container(
        height: 120,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                    height: 120,
                    width: 120,
                    fit: BoxFit.contain,
                    image: NetworkImage(
                      '${data.product.image}',
                    )),
                if (data.product.discount != 0)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 5.0),
                    color: Colors.red,
                    child: Text('discount',
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.white,
                      ),
                    ),
                  ),
              ],
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    '${data.product.name}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      height: 1.3,
                    ),
                  ),
                  Spacer(),
                  Expanded(
                    child: Row(
                      children: [
                        Text(
                          '${data.product.price}',
                          style: TextStyle(
                              fontSize: 12,
                              height: 1.3,
                              color: Colors.deepOrange),
                        ),
                        if (data.product.oldPrice != 0)
                          Text(
                            '${data.product.oldPrice}',
                            style: TextStyle(
                              fontSize: 12,
                              height: 1.3,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        Spacer(),
                        IconButton(
                          onPressed: () {
                            ShopCubit.get(context)
                                .changeFavorites(data.product.id);
                          },
                          icon: CircleAvatar(
                            backgroundColor: ShopCubit.get(context)
                                        .favorites[data.product.id] !=
                                    null
                                ? Colors.deepOrange
                                : Colors.grey,
                            radius: 15.0,
                            child: Icon(
                              Icons.favorite_border,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}
