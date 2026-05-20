# Task: Add Validations And Improve Figma Replica

## Task Summary

You have done a good job creating the login and signup screens from the Figma design. Well done.

The main task now is to add proper form validations. Along with that, improve the project structure and UI consistency so the app becomes cleaner, easier to maintain, and closer to the original Figma design.

## Main Task: Add Validations

Add validations to the login and signup forms.

Use `Form` and `TextFormField` instead of plain `TextField` where validation is required.

### Login Screen Validations

Validate:

- Email is required
- Email format should be valid
- Password is required
- Password should have a minimum length

Example:

```dart
validator: (value) {
  if (value == null || value.isEmpty) {
    return 'Email is required';
  }

  if (!value.contains('@')) {
    return 'Enter a valid email';
  }

  return null;
}
```

### Signup Screen Validations

Validate:

- First name is required
- Last name is required
- Email is required
- Email format should be valid
- Date of birth is required
- Phone number is required
- Phone number should have a valid length
- Password is required
- Password should have a minimum length

### Expected Validation Behavior

- When the user taps `Log In` or `Register`, invalid fields should show error messages.
- The form should not submit if any field is invalid.
- If all fields are valid, show a simple success message using `SnackBar`.

Example:

```dart
if (_formKey.currentState!.validate()) {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text('Form submitted successfully')),
  );
}
```

## Improvement 1: Create Reusable Widgets

The login and signup screens currently repeat similar UI parts like text fields, buttons, and social login icons.

Create reusable widgets to avoid duplicate code.

Recommended structure:

```text
lib/
  main.dart
  screens/
    login_screen.dart
    signup_screen.dart
  widgets/
    auth_text_field.dart
    primary_button.dart
    social_login_button.dart
    auth_header.dart
```

### Example: Reusable Text Field

```dart
class AuthTextField extends StatelessWidget {
  final String label;
  final String hint;
  final bool obscureText;
  final IconData? suffixIcon;
  final String? Function(String?)? validator;

  const AuthTextField({
    super.key,
    required this.label,
    required this.hint,
    this.obscureText = false,
    this.suffixIcon,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        const SizedBox(height: 8),
        TextFormField(
          obscureText: obscureText,
          validator: validator,
          decoration: InputDecoration(
            hintText: hint,
            suffixIcon: suffixIcon == null ? null : Icon(suffixIcon),
          ),
        ),
      ],
    );
  }
}
```

### Example: Reusable Button

```dart
class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const PrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(text),
      ),
    );
  }
}
```

## Improvement 2: Create A Constants File

Colors, spacing, border radius, font sizes, and asset paths should not be repeated in many places.

Create constants files:

```text
lib/
  constants/
    app_colors.dart
    app_sizes.dart
    app_assets.dart
```

### Example: `app_colors.dart`

```dart
import 'package:flutter/material.dart';

class AppColors {
  static const primaryBlue = Color(0xFF3366FF);
  static const loginBlue = Color(0xFF2563EB);
  static const purple = Color(0xFFB49EF4);
  static const lightCream = Color(0xFFF9EFE3);
  static const lightPurple = Color(0xFFEFEBFD);
  static const darkText = Color(0xFF111827);
}
```

### Example: `app_sizes.dart`

```dart
class AppSizes {
  static const screenPadding = 20.0;
  static const cardPadding = 22.0;
  static const borderRadius = 12.0;
  static const buttonHeight = 55.0;
  static const logoSize = 40.0;
}
```

### Example: `app_assets.dart`

```dart
class AppAssets {
  static const logo = 'assets/icons/logo.png';
  static const companyName = 'assets/icons/company_name.png';
  static const google = 'assets/icons/google.png';
  static const facebook = 'assets/icons/facebook.png';
  static const ios = 'assets/icons/ios.png';
  static const phone = 'assets/icons/phone.png';
}
```

Usage example:

```dart
Image.asset(
  AppAssets.logo,
  height: AppSizes.logoSize,
  width: AppSizes.logoSize,
)
```

## Improvement 3: Use High Quality Assets

The images and icons should look sharp and close to the Figma design.

Check:

- Logo should not look blurry
- Social login icons should be properly sized
- Icons should have transparent backgrounds if required
- Images should match the Figma design
- Asset sizes should not be stretched too much

If the asset looks pixelated, export a better version from Figma.

Recommended export options:

- Use PNG for raster icons/images
- Use SVG if the design uses vector icons and the project supports SVG
- Export at `2x` or `3x` for better quality

## Improvement 4: Compare More Closely With Figma

After adding validations, compare the app again with the Figma design.

Check these details:

- Background gradient colors
- Card width and height
- Border radius
- Button color
- Button height
- Text size
- Text weight
- Text alignment
- Field spacing
- Logo size
- Social icon size
- Overall screen spacing

The goal is not only to make the screen functional, but also to match the Figma design as closely as possible.

## Improvement 5: Text Fields Should Be Same In Both Screens

The login and signup screens should use the same text field design.

Make sure both screens have consistent:

- Border radius
- Border color
- Hint text style
- Label text style
- Padding
- Error text style
- Focused border style
- Filled background color

This should be achieved by using the same reusable `AuthTextField` widget in both screens.

## Suggested Implementation Order

1. Create constants files.
2. Create reusable widgets.
3. Replace repeated text fields with `AuthTextField`.
4. Replace repeated buttons with `PrimaryButton`.
5. Convert `TextField` widgets to `TextFormField`.
6. Add validation logic.
7. Show `SnackBar` when form is valid.
8. Improve asset quality and sizing.
9. Compare both screens with Figma.
10. Run formatting and testing.

## Submission Checklist

- Login form has validations
- Signup form has validations
- Empty fields show error messages
- Invalid email shows an error
- Invalid phone number shows an error
- Short password shows an error
- Success `SnackBar` appears when form is valid
- Reusable text field widget created
- Reusable button widget created
- Constants files created
- High quality assets checked
- Login and signup text fields look consistent
- UI compared with Figma
- `dart format` completed
- App runs without errors

## Review Focus

This task will be reviewed mainly for:

- Correct validation behavior
- Clean reusable widget structure
- Consistent design between login and signup screens
- Use of constants instead of repeated hardcoded values
- Visual closeness to the Figma design
- Code readability
