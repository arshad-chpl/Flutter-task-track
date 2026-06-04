# Task: Organize Notes With Tags, Pinning, Archive, And Filters

## Task Summary

The rich text notes feature is completed. The next task is to improve the notes experience by helping users organize and find their notes more easily.

Add note organization features such as tags, pinning, archive, filters, and sorting.

This task should extend the existing notes feature. Do not create a separate notes app.

## Goal

Improve the notes feature so users can:

- Add tags to notes
- Pin important notes
- Archive notes
- Filter notes
- Sort notes
- Search notes together with filters

## Features To Add

Add these features:

- Tags
- Pinned notes
- Archived notes
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
- `isPinned`
- `isArchived`

Suggested field types:

```text
tags       -> List<String>
isPinned   -> bool
isArchived -> bool
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

## Step 3: Add Pin Note Feature

User should be able to pin or unpin a note.

Requirements:

- Add pin icon on each note card.
- Pinned notes should appear at the top of the list.
- Pinned state should be saved locally.
- Pinned notes should still support edit, delete, archive, and search.

Expected behavior:

```text
Pinned notes first
Then normal notes
```

## Step 4: Add Archive Feature

User should be able to archive a note instead of deleting it.

Requirements:

- Add archive action on note card.
- Archived notes should not appear in the default notes list.
- Add filter to view archived notes.
- User should be able to unarchive a note.
- Archived state should be saved locally.

Do not delete archived notes from storage.

## Step 5: Add Filter Bar

Create a filter section on the notes list screen.

Filters:

- All
- Pinned
- Archived
- Tags

Suggested UI:

```text
All | Pinned | Archived | Tag: work | Tag: personal
```

Use chips or segmented buttons.

Requirements:

- Selecting `All` shows non-archived notes.
- Selecting `Pinned` shows pinned non-archived notes.
- Selecting `Archived` shows archived notes.
- Selecting a tag shows notes with that tag.

## Step 6: Add Sort Options

Add sorting options on the notes list screen.

Sort by:

- Last updated
- Created date
- Title A-Z

Requirements:

- User can choose sort option.
- Sort option should apply with current filter and search.
- Pinned notes should still stay above normal notes unless viewing archived notes.

## Step 7: Search Should Work With Filters

Search should still work after filters are added.

Examples:

```text
Search: meeting
Filter: work
Result: notes that match "meeting" and have "work" tag
```

```text
Search: idea
Filter: pinned
Result: pinned notes that match "idea"
```

## Step 8: Improve Empty States

Show different empty messages based on current filter.

Examples:

```text
No notes yet
No pinned notes
No archived notes
No notes found for this tag
No search results
```

## Expected Behavior

### Tags

- User adds tags while creating/editing a note.
- Tags appear on note card.
- User can filter notes by tag.

### Pinning

- User pins a note.
- Note moves to top.
- Pin state remains after app restart.

### Archive

- User archives a note.
- Note disappears from default list.
- Note appears in archived filter.
- User can unarchive it.

### Sort

- User changes sort option.
- Notes list updates.
- Sort works with search and filters.

### Persistence

- Tags, pinned state, archived state, and sort/filter behavior should work after app restart.

## What Not To Do

- Do not use API for notes.
- Do not delete notes when archiving.
- Do not make the UI too complex.
- Do not put filtering logic directly inside widgets if provider is being used.
- Do not break existing rich text note editing.
- Do not lose existing notes after updating the model.

## Submission Checklist

- `Note` model updated
- Tags added to note editor
- Tags saved locally
- Tags shown on note card
- Pin/unpin feature added
- Pinned notes appear first
- Archive/unarchive feature added
- Archived notes hidden from default list
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
- Clear UI for tags, filters, pinning, and archive
- No regression in rich text note editing
- Existing login/profile flow still working
