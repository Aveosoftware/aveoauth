library auth;

import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:aveoauth/widgets/loader.dart';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get_storage/get_storage.dart';
import 'package:github_sign_in/github_sign_in.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:local_auth/local_auth.dart';
import 'package:logger/logger.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:twitter_login/entity/auth_result.dart';
import 'package:twitter_login/twitter_login.dart';

part 'authentication/apple_login.dart';
part 'authentication/biometric_login.dart';
part 'authentication/facebook_login.dart';
part 'authentication/firebase_email_login.dart';
part 'authentication/github_login.dart';
part 'authentication/google_login.dart';
part 'authentication/login_mode.dart';
part 'authentication/phone_login.dart';
part 'authentication/twitter_login.dart';
part 'utils/custom_types.dart';
part 'utils/enum_to_string_converter.dart';
part 'utils/exception_handling_helper.dart';
part 'utils/logger.dart';
part 'utils/logout_helper.dart';
part 'utils/validators.dart';
part 'widgets/custom_pin_field.dart';
