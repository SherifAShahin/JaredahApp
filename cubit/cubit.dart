import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jaredah/cubit/states.dart';
import 'package:jaredah/modules/business_screen.dart';
import 'package:jaredah/modules/science_screen.dart';
import 'package:jaredah/modules/settings_screen.dart';
import 'package:jaredah/modules/sports_screen.dart';
import 'package:jaredah/modules/webview_screen.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../network/remote/dio_helper.dart';

class JaredahCubit extends Cubit<JaredahStates>
{
  JaredahCubit() : super(JaredahInitialState());

  static JaredahCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<BottomNavigationBarItem> BottomNavBarItems = [
    BottomNavigationBarItem(
      icon: Icon(
          Icons.business_center_outlined,
      ),
      label: 'Business',
    ),
    BottomNavigationBarItem(
      icon: Icon(
          Icons.sports_handball,
      ),
      label: 'Sports',
    ),
    BottomNavigationBarItem(
      icon: Icon(
          Icons.science_outlined,
      ),
      label: 'Science',
    ),
    // BottomNavigationBarItem(
    //   icon: Icon(
    //       Icons.settings,
    //   ),
    //   label: 'Settings',
    // ),
  ];

  List<Widget> screens = [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
    // SettingsScreen(),
  ];

  void changeBottomNavBar(int index)
  {
    currentIndex = index;
    if(currentIndex == 1)
      getSportsData();
    else if(currentIndex == 2)
      getSciencecData();
    emit(JaredahBottomNaveBarState());
  }

  List business = [];

  void getBusinessData()
  {
    emit(JaredahGetBusinessDataLoadingState());
    if(business.length == 0)
    {
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          "country" : "eg",
          "category" : "business",
          "apiKey" : "747e7ba538494b3caed96dc703efef31",
        },
      ).then((value)
      {
        business = value.data['articles'];
        print(business);
        emit(JaredahGetBusinessDataSuccessState());
      }).catchError((error)
      {
        print('####--- Error When Getting Business Data: ${error.data.toString()} ---###');
        emit(JaredahGetBusinessDataErrorState(error.toString()));
      });
    } else
    {
      emit(JaredahGetBusinessDataSuccessState());
    }
  }

  List sports = [];

  void getSportsData()
  {
    emit(JaredahGetSportsDataLoadingState());
    if(sports.length == 0)
    {
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          "country" : "eg",
          "category" : "sports",
          "apiKey" : "747e7ba538494b3caed96dc703efef31",
        },
      ).then((value)
      {
        sports = value.data['articles'];
        print(sports);
        emit(JaredahGetSportsDataSuccessState());
      }).catchError((error)
      {
        print('####--- Error When Getting Sports Data: ${error.data.toString()} ---###');
        emit(JaredahGetSportsDataErrorState(error.toString()));
      });
    } else
    {
      emit(JaredahGetSportsDataSuccessState());
    }
  }

  List science = [];

  void getSciencecData()
  {
    emit(JaredahGetScienceDataLoadingState());
    if(science.length == 0)
    {
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          "country" : "eg",
          "category" : "science",
          "apiKey" : "747e7ba538494b3caed96dc703efef31",
        },
      ).then((value)
      {
        science = value.data['articles'];
        print(science);
        emit(JaredahGetScienceDataSuccessState());
      }).catchError((error)
      {
        print('####--- Error When Getting Science Data: ${error.data.toString()} ---###');
        emit(JaredahGetScienceDataErrorState(error.toString()));
      });
    } else
    {
      emit(JaredahGetScienceDataSuccessState());
    }
  }

  void refresh()
  {
    emit(JaredahRefresh());
  }
  void refreshDone()
  {
    emit(JaredahRefreshDone());
  }

  List searchList = [];

  void search({
  required String searchValue,
  })
  {
    emit(JaredahSearchLoadingState());
    searchList = [];

    if(searchList.length == 0)
    {
      DioHelper.getData(
        url: 'v2/everything',
        query: {
          "q" : "$searchValue",
          "apiKey" : "fde894cd53b04786aa5c330ad49b97bf",
        },
      ).then((value)
      {
        searchList = value.data['articles'];
        print(searchList);
        emit(JaredahSearchSuccessState());
      }).catchError((error)
      {
        print('####--- Error When Getting Search Data: ${error.data.toString()} ---###');
        emit(JaredahSearchErrorState(error.toString()));
      });
    } else
    {
      emit(JaredahSearchSuccessState());
    }
  }

  void webView({
    required url,
    required context,
  })
  {
    var controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(url));
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => WebviewScreen(controller),
      ),
    );
    emit(JaredahWebVieSuccess());
  }
}