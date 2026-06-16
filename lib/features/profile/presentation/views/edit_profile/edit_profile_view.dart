import 'dart:async';
import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flower_app/core/app_extension/app_extension.dart';
import 'package:flower_app/core/app_extension/app_spacing_extension.dart';
import 'package:flower_app/core/di/di.dart';
import 'package:flower_app/core/helper/app_routes.dart';
import 'package:flower_app/core/helper/app_validator.dart';
import 'package:flower_app/core/helper/assets_manager.dart';
import 'package:flower_app/core/helper/image_source_title.dart';
import 'package:flower_app/core/helper/show_toast.dart';
import 'package:flower_app/features/auth/domain/models/user_entity.dart';
import 'package:flower_app/features/profile/data/models/edit_profile_request.dart';
import 'package:flower_app/features/profile/presentation/views/edit_profile/view_model/edit_profile_view_state.dart';
import 'package:flower_app/features/profile/presentation/views/edit_profile/view_model/edit_profile_intent.dart';
import 'package:flower_app/features/profile/presentation/views/edit_profile/view_model/edit_profile_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  final _formKey = GlobalKey<FormState>();

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  StreamSubscription<EditProfileUIEvents>? _uiEventsSubscription;

  final EditProfileViewModel _viewModel = getIt<EditProfileViewModel>();

  @override
  void initState() {
    super.initState();
    _viewModel.doIntent(GetProfileData());
    _listenToUIEvents();
  }

  void _listenToUIEvents() {
    _uiEventsSubscription = _viewModel.uiEventsStream.listen((event) {
      if (!mounted) return;
      switch (event) {
        case NavigateToResetPasswordEvent():
          context.pushName(AppRoutes.changePassword);
        case EditProfileViewShowToast():
          Toast.showToast(context, event.message, isError: event.isError);
        case UploadPhotoViewShowToast():
          Toast.showToast(context, event.message, isError: event.isError);
        case PopWithImageSource():
          Navigator.pop(context, event.source);
        case PopScreenEvent():
          Navigator.pop(context);
      }
    });
  }

  void _fillForm(UserEntity user) {
    _firstNameController.text = user.firstName ?? '';
    _lastNameController.text = user.lastName ?? '';
    _emailController.text = user.email ?? '';
    _phoneController.text = user.phone ?? '';
  }

  Future<void> _pickImageAndUpload() async {
    final picker = ImagePicker();

    final source = await _showImageSourceBottomSheet(context);
    if (source == null) return;

    final pickedFile = await picker.pickImage(source: source, imageQuality: 85);
    if (pickedFile == null) return;

    final file = File(pickedFile.path);

    _viewModel.doIntent(SelectLocalPhoto(file));

    _viewModel.doIntent(UploadPhoto(file));
  }

  Future<ImageSource?> _showImageSourceBottomSheet(BuildContext context) {
    return showModalBottomSheet<ImageSource>(
      context: context,
      backgroundColor: context.appTheme.backgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ImageSourceTile(
                icon: Icons.photo_library_outlined,
                title: 'gallery'.tr(),
                onTap: () => _viewModel.doIntent(PickImageFromGallery()),
              ),
              ImageSourceTile(
                icon: Icons.camera_alt_outlined,
                title: 'camera'.tr(),
                onTap: () => _viewModel.doIntent(PickImageFromCamera()),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ImageProvider? _getAvatarImage(EditProfileViewState state) {
    // 1️⃣ local preview
    if (state.localImage != null) {
      return FileImage(state.localImage!);
    }
    // 2️⃣ API image
    final user = state.getProfileDateStates.data;
    if (user?.photo != null && user!.photo!.isNotEmpty) {
      return NetworkImage(user.photo!);
    }
    // 3️⃣ default image
    return const AssetImage(AssetsManager.defaultProfile);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _viewModel,
      child: Scaffold(
        appBar: AppBar(title: Text('edit_profile'.tr())),
        body: BlocConsumer<EditProfileViewModel, EditProfileViewState>(
          listener: (context, state) {
            if (state.getProfileDateStates.isLoaded) {
              _fillForm(state.getProfileDateStates.data!);
            }
          },
          builder: (context, state) {
            if (state.getProfileDateStates.isLoading &&
                !state.getProfileDateStates.isLoaded) {
              return Center(
                child: CircularProgressIndicator(
                  color: context.appTheme.primary,
                ),
              );
            }
            if (state.getProfileDateStates.isError &&
                !state.getProfileDateStates.isLoaded) {
              return _isErrorGetProfileData(state);
            }
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Center(
                        child: Stack(
                          children: [
                            GestureDetector(
                              onTap: state.uploadPhotoStates.isLoading
                                  ? null
                                  : _pickImageAndUpload,
                              child: Badge(
                                offset: const Offset(-15, -24),
                                padding: const EdgeInsets.all(6),
                                alignment: Alignment.bottomRight,
                                label: Icon(
                                  Icons.camera_alt_outlined,
                                  size: 18,
                                  color: context.appTheme.secondary[90],
                                ),
                                backgroundColor: state.uploadPhotoStates.isError
                                    ? context.appTheme.error
                                    : context.appTheme.lightPink,
                                child: CircleAvatar(
                                  radius: 54,
                                  backgroundImage: _getAvatarImage(state),
                                  backgroundColor: context.appTheme.lightPink,
                                ),
                              ),
                            ),
                            if (state.getProfileDateStates.isLoading ||
                                state.uploadPhotoStates.isLoading) ...[
                              _isLoadingUploadPhoto(),
                            ],
                          ],
                        ),
                      ),
                      context.h(24),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _firstNameController,
                              validator: AppValidator.validateFirstName,
                              decoration: InputDecoration(
                                labelText: 'first_name'.tr(),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                              ),
                            ),
                          ),
                          const SizedBox(width: 18),
                          Expanded(
                            child: TextFormField(
                              controller: _lastNameController,
                              validator: AppValidator.validateLastName,
                              decoration: InputDecoration(
                                labelText: 'Last name'.tr(),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                              ),
                            ),
                          ),
                        ],
                      ),
                      context.h(24),
                      TextFormField(
                        controller: _emailController,
                        validator: AppValidator.validateEmail,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'Email'.tr(),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                        ),
                      ),
                      context.h(24),
                      TextFormField(
                        controller: _phoneController,
                        validator: AppValidator.validatePhone,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          labelText: 'Phone number'.tr(),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                        ),
                      ),
                      context.h(24),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Password'.tr(),
                          hintText: '••••••••',
                          suffixIcon: TextButton(
                            onPressed: () => _viewModel.doUIEvent(
                              NavigateToResetPasswordEvent(),
                            ),
                            child: Text(
                              'Change',
                              style: context.appTheme.semiBold12.copyWith(
                                color: context.appTheme.primary,
                              ),
                            ),
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                        ),
                      ),
                      context.h(40),
                      ElevatedButton(
                        onPressed: state.editProfileStates.isLoading
                            ? null
                            : _submitProfile,
                        child: _showLoadingOrText(
                          state.editProfileStates.isLoading,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _submitProfile() {
    if (!_formKey.currentState!.validate()) return;
    final request = EditProfileRequest(
      firstName: _firstNameController.text.trim(),
      lastName: _lastNameController.text.trim(),
      email: _emailController.text.trim(),
      phone: _phoneController.text.trim(),
    );
    _viewModel.doIntent(EditProfile(request));
  }

  Widget _showLoadingOrText(bool isLoading) {
    return isLoading
        ? CircularProgressIndicator(color: context.appTheme.secondary)
        : Text('update'.tr());
  }

  Widget _isErrorGetProfileData(EditProfileViewState state) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: 64,
                color: context.appTheme.error,
              ),
              context.h(20),
              Text(
                state.getProfileDateStates.errorMessage ??
                    'error_loading_profile'.tr(),
                style: context.appTheme.medium16,
                textAlign: TextAlign.center,
              ),
              context.h(20),
              ElevatedButton.icon(
                onPressed: () => _viewModel.doIntent(GetProfileData()),
                icon: const Icon(Icons.refresh),
                label: Text('retry'.tr()),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _uiEventsSubscription?.cancel();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Widget _isLoadingUploadPhoto() {
    return Positioned.fill(
      child: Container(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.black54,
        ),
        child: const Center(
          child: CircularProgressIndicator(color: Colors.white, strokeWidth: 3),
        ),
      ),
    );
  }
}
