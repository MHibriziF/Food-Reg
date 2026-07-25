import 'dart:io';

import 'package:firebase_ml_model_downloader/firebase_ml_model_downloader.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as img;
import 'package:injectable/injectable.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

import '../../../../services/logger_service.dart';
import '../../domain/entities/classification_result.dart';

part 'classification_local_data_source.dart';
