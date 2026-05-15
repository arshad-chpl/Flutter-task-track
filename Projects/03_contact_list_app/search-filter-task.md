# Task: Add Search And Filter To Contact List App

## Task Summary

You have done a good job completing and refactoring the contact list app. Well done.

Your next task is to add a search feature to the contact list app. This will help users find contacts quickly by typing a name in the search field.

## Goal

Allow the user to search contacts by name and update the contact list dynamically while typing.

## Requirements

- Add a search input at the top of the contact list screen.
- User should be able to search contacts by name.
- Contact list should update as the user types.
- Search should be case-insensitive.
- If no contact matches the search, show:

```text
No contacts found
```

- Keep the code properly separated.
- Do not put all logic back into `main.dart`.
- Existing contact detail navigation should continue working.
- Run formatting after completing the task.

## Suggested Files

Use the existing refactored structure:

```text
lib/
  main.dart
  models/
    contact.dart
  data/
    contact_data.dart
  screens/
    contact_list_screen.dart
    contact_detail_screen.dart
  widgets/
    contact_tile.dart
```

Most of the changes should be inside:

```text
lib/screens/contact_list_screen.dart
```

## Implementation Hint

You can use either `TextEditingController` or `onChanged`.

Example filtering logic:

```dart
final filteredContacts = contacts.where((contact) {
  return contact.name.toLowerCase().contains(searchText.toLowerCase());
}).toList();
```

## Expected Output

- When search is empty, all contacts should be visible.
- When user types `aarav`, only matching contacts should appear.
- When user types something that does not match, show `No contacts found`.
- Tapping a filtered contact should still open the correct detail screen.

## Submission Checklist

- Search bar added
- Case-insensitive search working
- Empty state added
- Detail navigation still working
- Code remains separated
- `dart format` completed
- App runs without errors

## Review Focus

This task will be reviewed for:

- Correct search functionality
- Clean state handling
- Proper code separation
- Good UI placement of the search field
- Empty state handling
- No regression in contact detail navigation
