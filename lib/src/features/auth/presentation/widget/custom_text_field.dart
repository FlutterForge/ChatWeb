import 'package:chat_web/src/core/constants/colors/app_colors.dart';
import 'package:chat_web/src/features/auth/presentation/screen/otp_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chat_web/src/core/extension/context_text_theme.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required TextEditingController phoneNumberController,
  }) : _phoneNumberController = phoneNumberController;

  final TextEditingController _phoneNumberController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _phoneNumberController,
      autofocus: true,
      onChanged: (value) {
        if (_phoneNumberController.text.length == 17) {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                actionsAlignment: MainAxisAlignment.spaceBetween,
                title: Text(
                  'Is this the correct number?',
                  style: context.textTheme.titleMedium!.copyWith(color: AppColors.instance.grey),
                ),
                content: Text(
                  '+${_phoneNumberController.text}',
                  style: context.textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w600),
                ),
                actions: <Widget>[
                  TextButton(
                    style: TextButton.styleFrom(
                      textStyle: Theme.of(context).textTheme.labelLarge,
                    ),
                    child: const Text('Edit'),
                    onPressed: () {
                      Navigator.of(context).pop();
                      _phoneNumberController.clear();
                    },
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      textStyle: Theme.of(context).textTheme.labelLarge,
                    ),
                    child: const Text('Yes'),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OtpScreen(
                            phoneNumber: _phoneNumberController.text,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              );
            },
          );
        }
      },
      inputFormatters: [
        TextInputFormatter.withFunction(
          (oldValue, newValue) {
            String digits = newValue.text.replaceAll(RegExp(r'\D'), '');

            if (digits.length > 12) {
              digits = digits.substring(0, 12);
            }

            //? Mask format  +(###) ##-###-#####
            String formatted = '';
            if (digits.isNotEmpty) {
              formatted = '(${digits.substring(0, digits.length < 3 ? digits.length : 3)}';
            }
            if (digits.length >= 3) {
              formatted += ') ${digits.substring(3, digits.length < 5 ? digits.length : 5)}';
            }
            if (digits.length >= 5) {
              formatted += '-${digits.substring(5, digits.length < 8 ? digits.length : 8)}';
            }
            if (digits.length >= 8) {
              formatted += '-${digits.substring(8, digits.length < 12 ? digits.length : 12)}';
            }

            int cursorPosition = formatted.length;

            return TextEditingValue(
              text: formatted,
              selection: TextSelection.collapsed(offset: cursorPosition),
            );
          },
        ),
      ],
      decoration: InputDecoration(
        prefixText: '+',
        prefixStyle: context.textTheme.labelMedium,
        suffixIcon: IconButton(
          onPressed: () {
            _phoneNumberController.clear();
          },
          icon: const Icon(CupertinoIcons.trash),
        ),
      ),
    );
  }
}
