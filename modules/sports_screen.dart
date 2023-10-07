import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/cubit.dart';
import '../cubit/mode_cubit.dart';
import '../cubit/states.dart';
import '../shared/components.dart';

class SportsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<JaredahCubit, JaredahStates>(
      listener: (context, state)
      {
        JaredahCubit cubit = BlocProvider.of(context);
        JaredahModeCubit cubitMode = BlocProvider.of(context);
        if(state is JaredahRefresh)
        {
          Future.delayed(const Duration(milliseconds: 220), () {
            cubit.refreshDone();
          });
        }
      },
      builder: (context, state)
      {
        JaredahCubit cubit = BlocProvider.of(context);
        var list = cubit.sports;

        return articleListBuilder(list);
      },
    );
  }
}
