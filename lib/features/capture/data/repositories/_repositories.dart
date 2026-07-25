import 'dart:io';

import 'package:either_dart/either.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';

import '../datasources/_datasources.dart';
import '../../../../core/client/_client.dart';
import '../../../../core/errors/failure.dart';
import '../../domain/repositories/_repositories.dart';

part 'capture_repository_impl.dart';
