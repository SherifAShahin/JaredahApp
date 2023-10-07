import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jaredah/cubit/cubit.dart';
import 'package:jaredah/cubit/mode_cubit.dart';
import 'package:jaredah/cubit/states.dart';
import 'package:jaredah/modules/search_screen.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<JaredahCubit, JaredahStates>(
      listener: (context, state) {},
      builder: (context, state) {
        JaredahCubit cubit = JaredahCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Jaredah',
            ),
            actions: [
              IconButton(
                onPressed: ()
                {
                  Navigator.push(context,
                  MaterialPageRoute(
                    builder: (context) => SearchScreen(cubit),
                  ));
                },
                icon: Icon(
                  Icons.search,
                  // size: 35.0,
                ),
              ),
              IconButton(
                onPressed: ()
                {
                  JaredahModeCubit.get(context).changeAppMode();
                  JaredahCubit.get(context).refresh();
                },
                icon: Icon(
                  Icons.brightness_4_outlined,
                  // size: 35.0,
                ),
              ),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 10.0,
                ),
              ],
            ),
            child: BottomNavigationBar(
              items: cubit.BottomNavBarItems,
              currentIndex: cubit.currentIndex,
              onTap: (index)
              {
                cubit.changeBottomNavBar(index);
                cubit.screens[cubit.currentIndex];
              },
            ),
          ),
        );
      },
    );
  }
}
