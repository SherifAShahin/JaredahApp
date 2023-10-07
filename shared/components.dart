import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:jaredah/cubit/cubit.dart';

Widget articleItemBuilder({
  required Map article,
  required context
}) => InkWell(
  onTap: ()
  {
    JaredahCubit.get(context).webView(
        url: article['url'],
        context: context
    );
  },
  child:   Padding(

    padding: const EdgeInsets.all(16.0),

    child: Row(

      crossAxisAlignment: CrossAxisAlignment.start,

      mainAxisAlignment: MainAxisAlignment.start,

      children:

      [

        Container(

          width: 100.0,

          height: 100.0,

          decoration: BoxDecoration(

              borderRadius: BorderRadius.circular(

                10.0,

              ),

              image: DecorationImage(

                fit: BoxFit.fill,

                image: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQYN09MsHDipPCV4-D-ECTD1y-HLUOA9eSy_g&usqp=CAU'),

              )

          ),

        ),

        SizedBox(

          width: 10.0,

        ),

        Expanded(

          child: Container(

            height: 100.0,

            child: Column(

              crossAxisAlignment: CrossAxisAlignment.start,

              mainAxisAlignment: MainAxisAlignment.start,

              mainAxisSize: MainAxisSize.min,

              children:

              [

                Text(

                  article['title'],

                  maxLines: 3,

                  overflow: TextOverflow.ellipsis,

                  style: Theme.of(context).textTheme.titleLarge,

                ),

                Expanded(

                  child: Container(

                    alignment: AlignmentDirectional.bottomEnd,

                    child: Text(

                      article['publishedAt'],

                      textAlign: TextAlign.end,

                      style: TextStyle(

                        fontSize: 15.0,

                        color: Colors.grey,

                      ),

                    ),

                  ),

                ),

              ],

            ),

          ),

        ),

      ],

    ),

  ),
);

Widget articleListBuilder(
    list,
    {isSearch = false}
    ) => ConditionalBuilder(
  condition: list.length > 0,
  builder: (context) => ListView.separated(
    physics: BouncingScrollPhysics(),
    itemBuilder: (context, index) => articleItemBuilder(
      article: list[index],
      context: context,
    ),
    separatorBuilder: (context, index) => Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
      ),
      child: Container(
        color: Colors.grey,
        height: 1.0,
      ),
    ),
    itemCount: list.length,
  ),
  fallback: (context) => isSearch ? Container(
    alignment: Alignment.center,
    child: Text('Search!',
    style: TextStyle(
      fontSize: 30,
      color: Colors.grey
    ),),
  ) : Center(child: CircularProgressIndicator()),
);

