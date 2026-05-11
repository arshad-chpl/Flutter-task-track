# Flutter Intern Project Tracker

This repository is for keeping a clean record of Flutter intern projects, weekly progress, reviews, blockers, and final outcomes.

Use it as a lightweight project management space: every project should have its own folder, a clear status, weekly updates, and review notes.

## Folder Structure

Create one folder for each intern project:

```text
projects/
  project-name/
    README.md
    weekly-updates.md
    review-notes.md
    resources.md
```

Example:

```text
projects/
  expense-tracker-app/
    README.md
    weekly-updates.md
    review-notes.md
    resources.md
```

## Project Status

Use one of these statuses in each project README:

| Status | Meaning |
| --- | --- |
| Not Started | Project is planned but work has not begun |
| In Progress | Intern is actively working on it |
| Blocked | Work is paused due to a dependency, bug, unclear requirement, or review delay |
| In Review | Submitted and waiting for feedback |
| Completed | Final version has been reviewed and accepted |
| Archived | Project is no longer active |

## Project README Template

Each project folder should include a `README.md` using this structure:

```markdown
# Project Name

## Intern Details

- Intern name:
- Mentor:
- Start date:
- Target completion date:
- Status:

## Project Goal

Write a short description of what the Flutter app or feature should achieve.

## Requirements

- Requirement 1
- Requirement 2
- Requirement 3

## Milestones

| Milestone | Target Date | Status | Notes |
| --- | --- | --- | --- |
| Setup project | YYYY-MM-DD | Not Started | |
| UI implementation | YYYY-MM-DD | Not Started | |
| State management | YYYY-MM-DD | Not Started | |
| API/local storage integration | YYYY-MM-DD | Not Started | |
| Testing and cleanup | YYYY-MM-DD | Not Started | |
| Final review | YYYY-MM-DD | Not Started | |

## Technical Details

- Flutter version:
- Dart version:
- State management:
- Backend/API:
- Local storage:
- Important packages:

## Links

- GitHub repository:
- Figma/design:
- Demo video:
- APK/build:
```

## Weekly Updates Template

Each project should have a `weekly-updates.md` file.

```markdown
# Weekly Updates

## Week 1: YYYY-MM-DD to YYYY-MM-DD

### Completed

- 

### In Progress

- 

### Blockers

- 

### Mentor Feedback

- 

### Next Week Plan

- 
```

Add a new section every week. Keep updates short, factual, and easy to scan.

## Review Notes Template

Each project should have a `review-notes.md` file.

```markdown
# Review Notes

## Review Date: YYYY-MM-DD

### What Was Reviewed

- UI
- Navigation
- State management
- API integration
- Code structure
- Error handling
- Testing

### Feedback

- 

### Required Changes

- 

### Approval Status

- Pending / Approved / Needs Changes
```

## What To Track

For each Flutter intern project, track:

- Project goal and scope
- Intern and mentor details
- Start date and expected completion date
- Weekly progress
- Blockers and decisions
- Code review feedback
- App screenshots or demo links
- Final outcome and learning notes

## Suggested Review Checklist

Use this checklist when reviewing intern work:

- App runs without errors
- Folder structure is clean
- Code is readable and consistently formatted
- Widgets are broken into reusable components where useful
- State management is understandable
- Navigation works correctly
- Loading, empty, error, and success states are handled
- Forms include validation where needed
- API or local storage logic is separated from UI where possible
- Basic tests are added for important logic
- README includes setup and run instructions

## Naming Guidelines

Use lowercase folder names with hyphens:

```text
todo-app
weather-app
expense-tracker
chat-ui
firebase-auth-demo
```

Avoid spaces in folder names.

## Tracking Routine

Follow this routine to keep the tracker useful:

1. Create a project folder when a new intern project starts.
2. Add the project README with goals, requirements, dates, and status.
3. Update `weekly-updates.md` at the end of each week.
4. Add mentor feedback in `review-notes.md` after every review.
5. Change project status whenever the project moves forward or gets blocked.
6. Add final notes when the project is completed.

## Final Completion Notes

When a project is completed, add a final section to the project README:

```markdown
## Final Outcome

- Completion date:
- Final status:
- What was delivered:
- What the intern learned:
- What can be improved later:
```

This makes it easy to look back and understand what was built, how the intern progressed, and what feedback was given during the project.



