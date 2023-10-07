import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jaredah/cubit/cubit.dart';
import 'package:jaredah/cubit/mode_cubit.dart';
import 'package:jaredah/cubit/states.dart';
import 'package:jaredah/shared/components.dart';

import '../cubit/mode_states.dart';


class BusinessScreen extends StatelessWidget {

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
        var list = cubit.business;

        return articleListBuilder(list);
      },
    );
  }
}
