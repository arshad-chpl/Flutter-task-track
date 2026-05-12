# Layout System

Flutter layout widgets help arrange UI elements on the screen. These widgets decide where child widgets appear, how much space they take, and how they respond to different screen sizes.

## Row

`Row` places widgets horizontally from left to right.

Use `Row` when you want items side by side.

```dart
Row(
  children: const [
    Icon(Icons.person),
    SizedBox(width: 8),
    Text('Profile'),
  ],
)
```

## Column

`Column` places widgets vertically from top to bottom.

Use `Column` when you want items stacked one below another.

```dart
Column(
  children: const [
    Text('Name'),
    Text('Email'),
    Text('Phone'),
  ],
)
```

## Expanded

`Expanded` makes a child widget take the available remaining space inside a `Row`, `Column`, or `Flex`.

Use `Expanded` when one widget should grow to fill free space.

```dart
Row(
  children: const [
    Icon(Icons.search),
    Expanded(
      child: TextField(),
    ),
  ],
)
```

## Flexible

`Flexible` allows a child widget to take available space, but it does not force the widget to fill all remaining space like `Expanded`.

Use `Flexible` when a widget should resize only if needed.

```dart
Row(
  children: const [
    Flexible(
      child: Text('This text can wrap or shrink based on available space.'),
    ),
  ],
)
```

## Padding

`Padding` adds empty space around a widget.

Use `Padding` when content needs breathing room from its edges.

```dart
Padding(
  padding: const EdgeInsets.all(16),
  child: Text('Hello Flutter'),
)
```

## SizedBox

`SizedBox` creates fixed width, fixed height, or empty spacing.

Use `SizedBox` for spacing or for giving a widget a specific size.

```dart
const SizedBox(height: 20)
```

```dart
SizedBox(
  width: 200,
  height: 50,
  child: ElevatedButton(
    onPressed: () {},
    child: const Text('Submit'),
  ),
)
```

## Center

`Center` places its child in the middle of the available space.

Use `Center` when a widget should appear exactly centered.

```dart
Center(
  child: Text('Centered Text'),
)
```

## Align

`Align` places a child at a specific position inside its parent.

Use `Align` when you want more control than `Center`.

```dart
Align(
  alignment: Alignment.topRight,
  child: Icon(Icons.settings),
)
```

## Stack

`Stack` places widgets on top of each other.

Use `Stack` when you want overlapping UI, such as badges, profile image overlays, or background layers.

```dart
Stack(
  children: const [
    CircleAvatar(
      radius: 40,
      child: Icon(Icons.person),
    ),
    Positioned(
      right: 0,
      bottom: 0,
      child: Icon(Icons.check_circle),
    ),
  ],
)
```

## Quick Comparison

| Widget | Main Use |
| --- | --- |
| `Row` | Arrange widgets horizontally |
| `Column` | Arrange widgets vertically |
| `Expanded` | Fill remaining available space |
| `Flexible` | Resize based on available space |
| `Padding` | Add space around a widget |
| `SizedBox` | Add fixed space or size |
| `Center` | Center a child widget |
| `Align` | Position a child inside its parent |
| `Stack` | Overlap widgets |

# Lists And Dynamic Rendering

Lists are used when you have multiple similar items, such as names, products, tasks, skills, projects, or messages.

Instead of writing every widget manually, Flutter lets you create widgets dynamically from data.

## List

A `List` stores multiple values in one variable.

Use a `List` when you have many related items.

```dart
final skills = [
  'Flutter',
  'Dart',
  'Firebase',
  'UI Design',
];
```

You can access items by index:

```dart
Text(skills[0]) // Flutter
```

## ListView.builder

`ListView.builder` creates a scrollable list dynamically.

Use `ListView.builder` when:

- The list has many items
- The data comes from a `List`
- You want better performance
- You do not want to manually write each widget

```dart
final skills = [
  'Flutter',
  'Dart',
  'Firebase',
  'UI Design',
];

ListView.builder(
  itemCount: skills.length,
  itemBuilder: (context, index) {
    return ListTile(
      title: Text(skills[index]),
    );
  },
)
```

### Important Parts

| Part | Meaning |
| --- | --- |
| `itemCount` | Total number of items in the list |
| `itemBuilder` | Function that builds each widget |
| `index` | Current item position |
| `skills[index]` | Current item value |

## map()

`map()` converts each item in a list into something else.

In Flutter, `map()` is often used to convert data into widgets.

```dart
final skills = [
  'Flutter',
  'Dart',
  'Firebase',
];

Column(
  children: skills.map((skill) {
    return Text(skill);
  }).toList(),
)
```

Here, each skill becomes a `Text` widget.

### Why `.toList()` Is Needed

`map()` returns an iterable, but `children` needs a list of widgets.

That is why we write:

```dart
.toList()
```

## Dynamic Rendering

Dynamic rendering means creating UI from data instead of writing each widget manually.

Without dynamic rendering:

```dart
Column(
  children: const [
    Text('Flutter'),
    Text('Dart'),
    Text('Firebase'),
  ],
)
```

With dynamic rendering:

```dart
final skills = [
  'Flutter',
  'Dart',
  'Firebase',
];

Column(
  children: skills.map((skill) => Text(skill)).toList(),
)
```

Dynamic rendering is useful because:

- Code becomes shorter
- Data is easier to update
- UI can change based on API data
- Repeated widgets are easier to manage
- It avoids copying and pasting the same widget many times

## ListView.builder vs map()

| Feature | `ListView.builder` | `map()` |
| --- | --- | --- |
| Best for | Long scrollable lists | Small lists inside `Column` or `Row` |
| Performance | Better for large lists | Good for small lists |
| Scrolling | Built in | Needs parent scroll widget if content is large |
| Builds items | Only as needed | Builds all items at once |

## Example: Dynamic Project List

```dart
final projects = [
  'Portfolio App',
  'Todo App',
  'Weather App',
  'Expense Tracker',
];

ListView.builder(
  itemCount: projects.length,
  itemBuilder: (context, index) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.folder),
        title: Text(projects[index]),
      ),
    );
  },
)
```

## Example: Dynamic Skill Chips

```dart
final skills = [
  'Flutter',
  'Dart',
  'Firebase',
  'REST API',
];

Wrap(
  spacing: 8,
  children: skills.map((skill) {
    return Chip(
      label: Text(skill),
    );
  }).toList(),
)
```
