# Task: Organize Notes With Tags, Filters, And Sorting

## Task Summary

The rich text notes feature is completed. The next task is to improve the notes experience by helping users organize and find their notes more easily.

Add note organization features such as tags, filters, and sorting.

This task should extend the existing notes feature. Do not create a separate notes app.

## Goal

Improve the notes feature so users can:

- Add tags to notes
- Filter notes
- Sort notes
- Search notes together with filters

## Features To Add

Add these features:

- Tags
- Filter chips
- Sort options
- Better empty states

## Files To Update

Update these files:

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

Create new widgets if needed:

```text
lib/
  widgets/
    notes_filter_bar.dart
    tag_chip_input.dart
```

## Step 1: Update `Note` Model

Add these fields to the existing `Note` model:

- `tags`

Suggested field types:

```text
tags -> List<String>
```

Make sure these fields are included in:

```dart
toJson()
fromJson()
copyWith()
```

## Step 2: Add Tags While Creating Or Editing Notes

In the note editor screen, allow user to add tags.

Example tags:

```text
work
personal
ideas
study
important
```

Requirements:

- User can add one or more tags.
- User can remove a tag before saving.
- Tags should be saved with the note.
- Tags should appear on the note card.

Keep tag input simple. A text field with an add button is enough.

## Step 3: Add Filter Bar

Create a filter section on the notes list screen.

Filters:

- All
- Tags

Suggested UI:

```text
All | Tag: work | Tag: personal | Tag: ideas
```

Use chips or segmented buttons.

Requirements:

- Selecting `All` shows all notes.
- Selecting a tag shows notes with that tag.

## Step 4: Add Sort Options

Add sorting options on the notes list screen.

Sort by:

- Last updated
- Created date
- Title A-Z

Requirements:

- User can choose sort option.
- Sort option should apply with current filter and search.

## Step 5: Search Should Work With Filters

Search should still work after filters are added.

Examples:

```text
Search: meeting
Filter: work
Result: notes that match "meeting" and have "work" tag
```

## Step 6: Improve Empty States

Show different empty messages based on current filter.

Examples:

```text
No notes yet
No notes found for this tag
No search results
```

## Expected Behavior

### Tags

- User adds tags while creating/editing a note.
- Tags appear on note card.
- User can filter notes by tag.

### Sort

- User changes sort option.
- Notes list updates.
- Sort works with search and filters.

### Persistence

- Tags and sort/filter behavior should work after app restart.

## What Not To Do

- Do not use API for notes.
- Do not make the UI too complex.
- Do not put filtering logic directly inside widgets if provider is being used.
- Do not break existing rich text note editing.
- Do not lose existing notes after updating the model.

## Submission Checklist

- `Note` model updated
- Tags added to note editor
- Tags saved locally
- Tags shown on note card
- Filter bar added
- Tag filter added
- Sort options added
- Search works with filters
- Empty states improved
- Existing rich text note content still works
- Existing notes remain after app restart
- `flutter analyze` passes
- `flutter test` passes

## Review Focus

This task will be reviewed for:

- Correct note organization behavior
- Clean filtering and sorting logic
- Good local persistence
- Clear UI for tags, filters, and sorting
- No regression in rich text note editing
- Existing login/profile flow still working
