part of '../aveoauth.dart';

typedef SussessCallback = void Function(String successMessage,UserCredential userCredential);
typedef GeneralSussessCallback = void Function(String successMessage);
typedef PhoneSussessCallback = void Function(String successMessage,PhoneAuthCredential userCredential);
typedef ErrorCallback = void Function(String errorMessage);
typedef AuthCallback = void Function(bool );
