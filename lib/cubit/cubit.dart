import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/cubit/states.dart';
import 'package:news_app/modules/business/business_screen.dart';
import 'package:news_app/modules/science/science_screen.dart';
import 'package:news_app/modules/setting_screen/settings_screen.dart';
import 'package:news_app/modules/sports/sports_screen.dart';

import '../network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> screens = [
    const BusinessScreen(),
    const SportsScreen(),
    const ScienceScreen(),
  ];
  List<BottomNavigationBarItem> bottomItems = [
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.business,
      ),
      label: 'Business',
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.sports,
      ),
      label: 'Sports',
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.science,
      ),
      label: 'Science',
    ),
  ];

  void changeBottomNavBar(int index) {
    currentIndex = index;
    if (currentIndex == 1) getSports();
    if (currentIndex == 2) getScience();
    emit(NewsBottomNavState());
  }

  List<dynamic> business = [];

  void getBusiness() {
    emit(NewsGetBusinessLoadingState());
    if (business.length == 0) {
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: ({
          'country': 'us',
          'category': 'business',
          'apiKey': '65f7f556ec76449fa7dc7c0069f040ca',
        }),
      )
          .then((value) => {
                //print(value.data['articles'][0]['title']),
                business = value.data['articles'],
                print(business[0]['title']),
                emit(NewsGetBusinessSucessState()),
              })
          .catchError((e) {
        print(e.toString());
        emit(NewsGetBusinessErrorState(e.toString()));
      });
    } else {
      emit(NewsGetBusinessSucessState());
    }
  }

  List<dynamic> sports = [];

  void getSports() {
    emit(NewsGetSportsLoadingState());
    if (sports.length == 0) {
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: ({
          'country': 'us',
          'category': 'sports',
          'apiKey': '65f7f556ec76449fa7dc7c0069f040ca',
        }),
      )
          .then((value) => {
                //print(value.data['articles'][0]['title']),
                sports = value.data['articles'],
                print(sports[0]['title']),
                emit(NewsGetSportsSucessState()),
              })
          .catchError((e) {
        print(e.toString());
        emit(NewsGetSportsErrorState(e.toString()));
      });
    } else {
      emit(NewsGetSportsSucessState());
    }
  }

  List<dynamic> science = [];

  void getScience() {
    emit(NewsGetScienceLoadingState());
    if (science.length == 0) {
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: ({
          'country': 'us',
          'category': 'science',
          'apiKey': '65f7f556ec76449fa7dc7c0069f040ca',
        }),
      )
          .then((value) => {
                //print(value.data['articles'][0]['title']),
                science = value.data['articles'],
                print(science[0]['title']),
                emit(NewsGetScienceSucessState()),
              })
          .catchError((e) {
        print(e.toString());
        emit(NewsGetScienceErrorState(e.toString()));
      });
    } else {
      emit(NewsGetScienceSucessState());
    }
  }
}
