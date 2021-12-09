import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:light_mart/layout/cubit/cubit.dart';
import 'package:light_mart/layout/cubit/states.dart';
import 'package:light_mart/models/categoriesModel.dart';
import 'package:light_mart/models/homeModel.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: ShopCubit.get(context).homeModel != null &&
              ShopCubit.get(context).categoriesModel != null,
          builder: (context) => ProductsBuilder(
              ShopCubit.get(context).homeModel,
              ShopCubit.get(context).categoriesModel,
              context),
          fallback: (context) => Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  Widget ProductsBuilder(
          HomeModel? model, CategoriesModel? categoriesModel, context) =>
      SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Categories',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    height: 100,
                    child: ListView.separated(
                      physics: BouncingScrollPhysics(),
                      itemCount: categoriesModel!.data.data.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) =>
                          builCategoryItem(categoriesModel.data.data[index]),
                      separatorBuilder: (BuildContext context, int index) =>
                          SizedBox(
                        width: 20.0,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    'New Products',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
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
                childAspectRatio: 1 / 1.58,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                children: List.generate(
                  model.data.products.length,
                  (index) =>
                      buildGridProductItem(model.data.products[index], context),
                ),
              ),
            )
          ],
        ),
      );

  Widget buildGridProductItem(ProductModel model,context) => Column(
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
                                fontSize: 12,
                                height: 1.3,
                                color: Colors.deepOrange),
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
                          IconButton(
                            onPressed: () {
                              ShopCubit.get(context).changeFavorites(model.id);
                            },
                            icon: CircleAvatar(
                              backgroundColor: ((ShopCubit.get(context).favorites[model.id]) != null && (ShopCubit.get(context).favorites[model.id])  == true)
                                  ? Colors.deepOrange : Colors.grey,
                              radius: 15.0,
                              child: Icon(
                                Icons.favorite_border,
                                color: Colors.white,
                              ),
                            ),
                          ),
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

  Widget builCategoryItem(ProductData data) => Container(
        height: 100,
        width: 100,
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            Image(
              image: NetworkImage(
                '${data.image}',
              ),
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            ),
            Container(
              width: double.infinity,
              child: Text(
                data.name,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              color: Colors.black.withOpacity(0.8),
            ),
          ],
        ),
      );
}
