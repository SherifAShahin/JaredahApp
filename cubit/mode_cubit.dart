import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jaredah/network/local/cashe_helper.dart';
import 'mode_states.dart';

class JaredahModeCubit extends Cubit<JaredahModeStates>
{
  JaredahModeCubit() : super(JaredahModeInitialState());

  static JaredahModeCubit get(context) => BlocProvider.of(context);

  bool isDark = false;
  void changeAppMode({
    bool? fromShared
  })
  {
    if(fromShared != null)
    {
      isDark = fromShared;
      emit(JaredahChangeMode());
    } else
    {
      isDark = !isDark;
      CasheHelper.putBoolean(key: 'isDark', value: isDark).then(
              (value){
            print('Saved in cache!');
            emit(JaredahChangeMode());
          }
      ).catchError((error)
      {
        print('+++++++++  error when putting data in cashe $error  +++++++++');
      });
    }
  }

  void refresh()
  {
    emit(JaredahModeRefresh());
  }

}