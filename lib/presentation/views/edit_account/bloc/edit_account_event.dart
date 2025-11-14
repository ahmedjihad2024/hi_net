part of 'edit_account_bloc.dart';

sealed class EditAccountEvent {
  const EditAccountEvent();
}

class EditAccountCountryCodeChanged extends EditAccountEvent {
  final String dialCode;
  final String countryCode;

  EditAccountCountryCodeChanged(this.dialCode, this.countryCode);
}

class SelectImageProfile extends EditAccountEvent {
  SelectImageProfile();
}

class UpdateProfile extends EditAccountEvent {
  final String? email;
  final String? fullName;
  final String? phone;
  final File? image;
  final void Function() onSuccess;

  UpdateProfile(
      this.email, this.fullName, this.phone, this.image, this.onSuccess);
}

class RemoveImageProfile extends EditAccountEvent {
  final void Function() onSuccessDelete;
  const RemoveImageProfile(this.onSuccessDelete);
}
