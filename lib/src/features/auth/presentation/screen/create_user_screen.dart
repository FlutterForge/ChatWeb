import 'package:chat_web/src/core/extension/size_extenstion.dart';
import 'package:chat_web/src/core/utils/show_notification.dart';
import 'package:chat_web/src/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:chat_web/src/features/auth/presentation/widget/custom_elevated_button.dart';
import 'package:chat_web/src/features/home/presentation/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:chat_web/src/core/constants/colors/app_colors.dart';
import 'package:chat_web/src/core/extension/context_text_theme.dart';
import 'package:chat_web/src/features/auth/presentation/widget/custom_text_form_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateUserScreen extends StatefulWidget {
  const CreateUserScreen({super.key, required this.phoneNumber});

  final String phoneNumber;

  @override
  State<CreateUserScreen> createState() => _CreateUserScreenState();
}

class _CreateUserScreenState extends State<CreateUserScreen> {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: CustomElevatedButton(
        title: 'Next',
        onTap: () => context.read<AuthBloc>().add(
              CreateUserEvent(
                username: "${_firstNameController.text} ${_lastNameController.text}",
                phoneNumber: widget.phoneNumber,
              ),
            ),
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state.status == AuthStatus.authorized) {
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomeScreen()), (_) => false);
          } else {
            showNotification(message: "Failed to create telegram account");
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Column(
            children: [
              const SizedBox(height: 50),
              Text('Your Info', style: context.textTheme.displayLarge),
              const SizedBox(height: 15),
              Form(
                key: _globalKey,
                child: Column(
                  children: [
                    CustomTextFormField(
                      controller: _firstNameController,
                      hinText: 'First Name',
                    ),
                    const SizedBox(height: 30),
                    CustomTextFormField(
                      controller: _lastNameController,
                      hinText: 'Last Name',
                      textInputAction: TextInputAction.done,
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Text.rich(
                textAlign: TextAlign.center,
                TextSpan(
                  text: 'By signing up,\nyou agree to the ',
                  style: context.textTheme.titleLarge,
                  children: <InlineSpan>[
                    TextSpan(
                      text: 'Terms of Service',
                      style: context.textTheme.titleLarge!.copyWith(color: AppColors.instance.blue),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: context.h * 0.15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
