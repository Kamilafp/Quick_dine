
import 'package:flutter/material.dart';
import 'package:quick_dine/models/core/user.dart';
import 'package:quick_dine/views/screens/page_switcher.dart';
import 'package:shared_preferences/shared_preferences.dart';

const baseURL='http://127.0.0.1:8000/api';
const loginURL=baseURL+'/login';
const registerURL=baseURL+'/register';
const logoutURL=baseURL+'/logout';
const userURL=baseURL+'/users';
const kantinURL=baseURL+'/kantin';
const menuURL=baseURL+'/menu';
const pesananURL=baseURL+'/pesanan';

const serverError='Server error';
const unauthorized='Unauthorized';
const somethingWentWrong='Something went wrong, try again!';
