import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shop_app/layout/news_app/cubit/states.dart';


class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;


  List<String> titles = [
    'Business',
    'Sports',
    'Science',
    'Setting'
  ];

  void changeIndex(int index) {

  /*  if(index == 1)
      getScience();
    if(index == 2)
      getScience();*/

    currentIndex = index;
    emit(NewsChangeBottomNavState());
  }
/*
  List <dynamic> business = [];

  void getBusiness() {
    emit(NewsBusinessLoadingState());
    DioHelper.getData(
      url: 'v2/top-headlines',
      query:
      {
        'country': 'eg',
        'category': 'business',
        'apiKey': '65f7f556ec76449fa7dc7c0069f040ca',
      },
    ).then((response) {
      print(response.data);
      business = response.data['articles'];
      print(business.length);

      emit(NewsBusinessSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsBusinessErrorState(error.toString()));
    });

    // try
    // {
    //   Response response = await DioHelper.getData(
    //     url: 'v2/top-headlines',
    //     query:
    //     {
    //       'country':'eg',
    //       'category':'business',
    //       'apiKey':'65f7f556ec76449fa7dc7c0069f040ca',
    //     },
    //   );
    //
    //   print(response.data);
    //   print(response.data['totalResults']);
    //
    //   emit(NewsBusinessSuccessState());
    // } catch(error)
    // {
    //   print(error.toString());
    //   emit(NewsBusinessErrorState(error.toString()));
    // }
  }

  List <dynamic> sports = [];

  void getSports() {
    emit(NewsSportsLoadingState());
    DioHelper.getData(
      url: 'v2/top-headlines',
      query:
      {
        'country': 'eg',
        'category': 'sports',
        'apiKey': '65f7f556ec76449fa7dc7c0069f040ca',
      },
    ).then((response) {
      print(response.data);
      sports = response.data['articles'];
      print(sports.length);

      emit(NewsSportsSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsSportsErrorState(error.toString()));
    });
  }

  List <dynamic> science = [];

  void getScience() {
    emit(NewsScienceLoadingState());
    DioHelper.getData(
      url: 'v2/top-headlines',
      query:
      {
        'country': 'eg',
        'category': 'business',
        'apiKey': '65f7f556ec76449fa7dc7c0069f040ca',
      },
    ).then((response) {
      print(response.data);
      science = response.data['articles'];
      print(science.length);

      emit(NewsScienceSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsScienceErrorState(error.toString()));
    });
  }*/
}