import 'dart:async';
import 'package:barber/constants/error_codes.dart';
import 'package:barber/firebase_db_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

import '../models/user_model.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseService service;

  AuthBloc(this.service) : super(AuthInitial()) {
    on<AddUser>((event, emit) async {
      emit(AuthLoading());

      try {
        if (event.name.length < 3 || event.phone.length < 4) {
          emit(AuthError(ErrorCodes.INPUT_LENGTH));
        } else {
          UserModel model = UserModel(name: event.name, phone: event.phone);
          await service.register(model);
          var box = Hive.box('auth');
          box.put('name', model.name);
          emit(AuthSuccess());
        }
      } catch (error) {
        emit(AuthError(ErrorCodes.CONNECTIVITY));
      }
    });
    on<CheckUser>((event, emit) async {
      try {
        if (event.name.length < 3 || event.phone.length < 4) {
          emit(AuthError(ErrorCodes.INPUT_LENGTH));
        } else {
          UserModel model = UserModel(name: event.name, phone: event.phone);
          bool isExist = await service.login(model);
          emit(isExist?AuthSuccess():AuthError(ErrorCodes.INPUT_LENGTH));
          if(isExist) {
            var box = Hive.box('auth');
            box.put('name', model.name);
          }
        }
      } catch (error){
        emit(AuthError(ErrorCodes.CONNECTIVITY));
        print(error);
      }
    });
  }
}
