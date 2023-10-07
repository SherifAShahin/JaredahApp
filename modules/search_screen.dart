import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jaredah/cubit/cubit.dart';
import 'package:jaredah/cubit/states.dart';
import 'package:jaredah/shared/components.dart';

class SearchScreen extends StatelessWidget {

  JaredahCubit? cubit;

  SearchScreen(
      this.cubit,
      );

  @override
  Widget build(BuildContext context) {

    var searchController = TextEditingController();
    var searchKey = GlobalKey<FormState>();

    return BlocConsumer<JaredahCubit, JaredahStates>(
      listener: (context, state) {},
      builder: (context, state) {
        cubit = BlocProvider.of(context);

        var list = cubit?.searchList;
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Search',
            ),
            leading: IconButton(
              onPressed: (){
                Navigator.pop(context);
                list = [];
                cubit!.refresh();
              },
              icon: Icon(
                Icons.arrow_back_outlined
              ),
            ),
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: searchKey,
                  child: TextFormField(
                    controller: searchController,
                    onChanged: (value)
                    {
                      if(searchKey.currentState!.validate())
                      {
                        cubit!.search(searchValue: value);
                        print(list);
                      }
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Search should not be empty!';
                      }
                      else
                        return null;
                    },
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      // labelStyle: TextStyle(
                      //   color: Colors.grey,
                      // ),
                      hintText: 'Search...',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                      ),
                      label: Text(
                        'search',
                        style: TextStyle(
                          fontSize: 25,
                        ),
                      ),
                      prefixIcon: Icon(
                        Icons.search,
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                            width: 2.0,
                          )
                      ),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: articleListBuilder(list, isSearch: true),
              ),
            ],
          ),
        );
      },
    );
  }
}
