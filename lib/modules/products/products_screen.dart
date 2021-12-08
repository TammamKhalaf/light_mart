import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:light_mart/layout/cubit/cubit.dart';
import 'package:light_mart/layout/cubit/states.dart';
import 'package:light_mart/models/homeModel.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: ShopCubit.get(context).homeModel != null,
          builder: (context) =>
              ProductsBuilder(ShopCubit.get(context).homeModel),
          fallback: (context) => Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  Widget ProductsBuilder(HomeModel? model) => SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            CarouselSlider(
              items: model!.data.banners
                  .map((e) => Image(
                        image: NetworkImage(
                          e.image,
                        ),
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ))
                  .toList(),
              options: CarouselOptions(
                height: 250,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                viewportFraction: 1.0,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(seconds: 1),
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollDirection: Axis.horizontal,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Container(
              color: Colors.white,
              child: GridView.count(
                mainAxisSpacing: 1,
                crossAxisSpacing: 1,
                childAspectRatio: 1 / 1.5,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                children: List.generate(
                  model.data.products.length,
                  (index) => buildGridProductItem(model.data.products[index]),
                ),
              ),
            )
          ],
        ),
      );

  Widget buildGridProductItem(ProductModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.all(10.0),
            child: Column(
              children: [
                Stack(
                  alignment: AlignmentDirectional.bottomStart,
                  children: [
                    Image(
                        height: 200,
                        fit: BoxFit.contain,
                        width: 200,
                        image: NetworkImage(
                          model.image,
                        )),
                    if (model.discount != 0)
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 5.0),
                        color: Colors.red,
                        child: Text(
                          'Discount',
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.white,
                          ),
                        ),
                      ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Text(
                        model.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 14,
                          height: 1.3,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            '${model.price.round()}',
                            style: TextStyle(
                                fontSize: 12, height: 1.3, color: Colors.deepOrange),
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          if (model.discount != 0)
                            Text(
                              '${model.oldPrice.round()}',
                              style: TextStyle(
                                fontSize: 12,
                                height: 1.3,
                                color: Colors.grey,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                          Spacer(),
                          Icon(Icons.favorite_border),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      );
}
