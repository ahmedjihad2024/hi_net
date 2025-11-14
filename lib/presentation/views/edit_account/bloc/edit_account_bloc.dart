import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import '../../../common/utils/state_render.dart';

part 'edit_account_event.dart';
part 'edit_account_state.dart';

class EditAccountBloc extends Bloc<EditAccountEvent, EditAccountState> {
  ImagePicker imagePicker = ImagePicker();

  EditAccountBloc() : super(EditAccountState()) {
    on<EditAccountCountryCodeChanged>((event, emit) {
      emit(
        state.copyWith(
          countryCode: event.countryCode,
          dialCode: event.dialCode,
        ),
      );
    });
    on<SelectImageProfile>(_onSelectImageProfile);
    on<UpdateProfile>(_onUpdateProfile);
    on<RemoveImageProfile>(_onRemoveImageProfile);
  }

  Future<void> _onSelectImageProfile(
    SelectImageProfile event,
    Emitter<EditAccountState> emit,
  ) async {
    final value = await imagePicker.pickImage(source: ImageSource.gallery);
    if (value != null) {
      emit(state.copyWith(selectedImage: File(value.path)));
    }
  }

  Future<void> _onUpdateProfile(
    UpdateProfile event,
    Emitter<EditAccountState> emit,
  ) async {
    if (event.image == null &&
        event.email == null &&
        event.fullName == null &&
        event.phone == null) {
      return;
    }
  }

  Future<void> _onRemoveImageProfile(
    RemoveImageProfile event,
    Emitter<EditAccountState> emit,
  ) async {
    emit(state.removeImageProfile());
  }
}
