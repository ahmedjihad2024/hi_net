part of 'edit_account_bloc.dart';

class EditAccountState extends Equatable {
  final ReqState reqState;
  final String errorMessage;

  final String countryCode;
  final String dialCode;
  final File? selectedImage;
  final String? imageUrl;

  const EditAccountState(
      {this.reqState = ReqState.idle,
      this.errorMessage = '',
      this.dialCode = '+966',
      this.countryCode = 'SA',
      this.selectedImage,
      this.imageUrl
      });

  EditAccountState copyWith({
    ReqState? reqState,
    String? errorMessage,
    String? countryCode,
    String? dialCode,
    File? selectedImage,
    String? imageUrl,
  }) {
    return EditAccountState(
      reqState: reqState ?? this.reqState,
      errorMessage: errorMessage ?? this.errorMessage,
      countryCode: countryCode ?? this.countryCode,
      dialCode: dialCode ?? this.dialCode,
      selectedImage: selectedImage ?? this.selectedImage,
      imageUrl: imageUrl ?? this.imageUrl
    );
  }

  EditAccountState removeImageProfile() {
    return EditAccountState(
      reqState: reqState,
      errorMessage: errorMessage,
      countryCode: countryCode,
      dialCode: dialCode,
      selectedImage: null,
      imageUrl: imageUrl
    );
  }

    EditAccountState removeImageProfileUrl() {
    return EditAccountState(
      reqState: reqState,
      errorMessage: errorMessage,
      countryCode: countryCode,
      dialCode: dialCode,
      selectedImage: selectedImage,
      imageUrl: null
    );
  }

  @override
  List<Object?> get props =>
      [reqState, errorMessage, countryCode, dialCode, selectedImage, imageUrl];
}
