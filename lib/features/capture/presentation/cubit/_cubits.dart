import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/failure.dart';
import '../../../classification/domain/entities/classification_result.dart';
import '../../../classification/domain/repositories/_repositories.dart';
import '../../domain/repositories/_repositories.dart';

part 'capture_cubit.dart';
part 'capture_state.dart';
part '_cubits.freezed.dart';
