# Task: Add Rich Text Notes Feature

## Task Summary

The app already has login, profile, local storage, and improved structure. The next task is to add a notes feature inside the same app.

The user should be able to create, view, edit, delete, search, and format notes.

This should feel like a simple notes app feature inside the existing project, not a separate app.

## Goal

Create a notes feature where the logged-in user can manage personal rich text notes locally.

The notes should be saved on the device using local storage so they remain available after app restart.

## Main Features

User should be able to:

- View all notes
- Create a new note
- Edit an existing note
- Delete a note
- Search notes
- Apply formatting to selected words or selected parts of the note
- Save notes locally

## Formatting Features

The note should support different formatting in different parts of the same note.

Example:

```text
This word is bold, this word is italic, and this line is a bullet item.
```

Do not apply one style to the entire note. A long note can have multiple styles across different words, lines, or sections.

Add rich text formatting options:

- Bold
- Italic
- Underline
- Bullet list
- Numbered list
- Heading
- Text color selection

## Package To Use

Use `flutter_quill` for rich text editing.

Pub.dev: https://pub.dev/packages/flutter_quill

As of the current pub.dev listing, the latest version shown is:

```yaml
dependencies:
  flutter_quill: ^11.5.1
```

Then run:

```sh
flutter pub get
```

`flutter_quill` is a WYSIWYG rich text editor for Flutter. Use it instead of manually building a rich text editor from scratch.

## Files To Create

Create these files:

```text
lib/
  models/
    note.dart
  screens/
    notes_list_screen.dart
    note_editor_screen.dart
  services/
    notes_storage_service.dart
  widgets/
    note_card.dart
```

If the project is already using a provider/state folder, create:

```text
lib/
  provider/
    notes_provider.dart
```

## Suggested Folder Structure

```text
lib/
  models/
    note.dart
  provider/
    notes_provider.dart
  screens/
    notes_list_screen.dart
    note_editor_screen.dart
  services/
    notes_storage_service.dart
  widgets/
    note_card.dart
```

## Step 1: Create `Note` Model

Create:

```text
lib/models/note.dart
```

The note model should include:

- `id`
- `title`
- `plainTextPreview`
- `deltaJson`
- `createdAt`
- `updatedAt`

The model should include:

```dart
toJson()
fromJson()
copyWith()
```

Use `id` to identify each note when editing or deleting.

### Important Storage Rule

Store the note body as Quill Delta JSON, not as one plain string with one style.

Suggested fields:

```text
plainTextPreview -> used for search and list preview
deltaJson        -> used to rebuild the rich text editor content
```

This allows different words and sections to keep different formatting.

## Step 2: Create Notes Storage Service

Create:

```text
lib/services/notes_storage_service.dart
```

This service should handle saving and reading notes from local storage.

Suggested methods:

```dart
getNotes()
saveNotes(...)
addNote(...)
updateNote(...)
deleteNote(...)
```

Keep local storage logic inside this service.

Do not use `SharedPreferences` directly inside UI screens.

## Step 3: Create Notes Provider

If the app is using provider/state management, create:

```text
lib/provider/notes_provider.dart
```

The provider should handle:

- Loading notes
- Adding notes
- Updating notes
- Deleting notes
- Searching notes
- Current filtered notes list

If provider is not yet used for this feature, use clean `StatefulWidget` state, but provider is preferred if the app already uses it.

## Step 4: Create Notes List Screen

Create:

```text
lib/screens/notes_list_screen.dart
```

This screen should show:

- AppBar title: `My Notes`
- Search field
- List of notes
- Empty state
- Floating action button to add note

Each note should show:

- Title
- Short content preview
- Last updated date
- Delete option

## Step 5: Create Full Screen Note Editor

Create:

```text
lib/screens/note_editor_screen.dart
```

This screen should support both:

- Add new note
- Edit existing note

The editor screen should feel like a real notes app:

- The whole screen should be typable
- The note body should take most of the screen
- Toolbar should be available for formatting
- User should be able to select text and apply formatting only to that selected text

Fields:

- Title field at the top
- Rich text editor below it

Validation:

- Title is required
- Content is required

Use `flutter_quill` editor and toolbar for this screen.

Suggested editor responsibilities:

- Create a Quill controller for new notes
- Load existing Delta JSON for editing notes
- Save Delta JSON when note is saved
- Generate plain text preview for search/list display

## Step 6: Add Rich Text Toolbar

Use the toolbar provided by `flutter_quill`.

The toolbar should allow:

- Bold
- Italic
- Underline
- Bullet list
- Numbered list
- Heading
- Text color

Expected behavior:

- Formatting should apply to selected text only.
- Different words can have different styles.
- Formatting should remain after saving and reopening the note.

## Step 7: Create Reusable Note Card

Create:

```text
lib/widgets/note_card.dart
```

This widget should display one note in the notes list.

It should handle:

- Showing note title
- Showing plain text preview
- Showing updated date
- Opening edit screen on tap
- Delete action

## Step 8: Add Notes Navigation

Add a way to open the notes feature from the existing app.

Good options:

- Add Notes button on Home screen
- Add Notes option on Profile screen
- Add Notes option in Settings screen

Recommended:

```text
ProfileScreen -> NotesListScreen
```

## Step 9: Search Notes

Add search on `NotesListScreen`.

Search should work by:

- Title
- Content

Expected behavior:

- Empty search shows all notes
- Matching search shows filtered notes
- No match shows empty state text

Empty state text:

```text
No notes found
```

## Step 10: Delete Confirmation

Before deleting a note, show a confirmation dialog.

Example message:

```text
Are you sure you want to delete this note?
```

If user confirms, delete the note from local storage.

## Expected Behavior

### No Notes

- Notes list screen shows empty state.
- User can tap add button to create first note.

### Create Note

- User enters title.
- User types rich text content.
- User applies formatting to selected words or lines.
- User saves note.
- Note appears in notes list.
- Note remains after app restart.

### Edit Note

- User taps a note.
- Note editor screen opens with existing rich text data.
- User updates text or formatting.
- Updated note appears in notes list.
- Formatting remains after save and reopen.

### Delete Note

- User taps delete.
- Confirmation dialog appears.
- Note is deleted only after confirmation.

### Search Notes

- User types in search field.
- List updates dynamically.
- If no result, show `No notes found`.

## What Not To Do

- Do not use API for notes.
- Do not store notes directly inside UI widgets.
- Do not put all note logic in one screen.
- Do not skip validation.
- Do not delete a note without confirmation.
- Do not build rich text editing manually from scratch.
- Do not store one style for the entire note.
- Do not store notes only in memory.

## Submission Checklist

- `Note` model created
- Notes storage service created
- Notes list screen created
- Full screen note editor screen created
- Note card widget created
- User can create notes
- User can edit notes
- User can delete notes
- Delete confirmation added
- User can search notes
- Empty state added
- Notes persist after app restart
- Rich text formatting works for selected words/sections
- Formatting remains after reopening a note
- Notes feature is accessible from existing app
- `flutter analyze` passes
- `flutter test` passes

## Review Focus

This task will be reviewed for:

- Correct note CRUD behavior
- Local persistence
- Clean file separation
- Rich text Delta storage and loading
- Search behavior
- Good empty states
- Existing login/profile flow still working
