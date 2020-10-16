# mongKit
Library for creating iOS ui programmatically

## Motivation

Creating user interface code on Apple platforms are tedious to say at the least; on one hand you have interface builder and on the other you have code written in Swift/Objective-C.

Creating UI on interface builder is the easiest entry into iOS/macOS development. It offers a user-friendly way to build UI by dragging and dropping views into your canvas and shows you what items you can modify on that view. But its downside is it does not scale well with complex applications and cannot be reconciled on source-control software when there are merge conflicts. Not to mention xcode has to build every time the backing code change and it has poor support for integrating third party dependencies added through cocoapods/carthage.

Writing Swift or Objective-C code is the way for professional iOS engineers as it provides the most flexibility and affordance when creating interface code. But the way the API works is it builds the UI imperatively: it does not describe what that piece of code is doing at a glance.

`mongKit` is inspired by the declarative nature of how `React` components are created in Javascript. Instead of having a separate HTML template file for the component to modify, the code is written declaratively and is processed the same time as javascript code. Clearing up time for the engineer to understand the code and can maintain the code even if the code written is old.

## Definition

`mongKit` operates on a simple paradigm, to **construct** compoents and **define** that component's `Style`, `Layout`, and `sub-views`. To exemplify:

```[swift]
class Widget: View {
  @ComponentBuilder override var body: Component {
    UIView {
      Style(for: UIView.self) {
        \.backgroundColor ==> .blue }
      AutoLayout {
        Size(100)
        Center() }

      UILabel {
        Style(for: UILabel.self) {
          \.text ==> "Hello world!" }
        AutoLayout {
          Center() }
      }
    }
  }
}
```

_This creates a `UIView` with a blue background and is centered on the screen with a size of 100dp with a "Hello world!" `UILabel` inside also centered._

Constructing a component has three parts. First is the list of `Style` properties the component will take. Next is the `Layout` the component will perform. Last is the `subviews` the component will house.

### Style

`Style` is an open class type that defines the properties a component will have upon addition to its superview.

Defining a style key-value pair is done as follows:

```
\.<view property> ==> <property value>
```

So setting a `UIView` background can be done by doing:

```
\.backgroundColor ==> .blue
```

We can go further by setting the label of a `UIButton`:

```
\.title.font ==> UIFont.system(ofSize: 16)
```

As this uses Swift's keypath system.

`Style` can also be subclassed if there is a common distinct property operation for a component:

```
class ButtonStyle: Style {
  init<View: UIButton>(for type: View.Type) {
    super.init(for: type) {
      \.title.font ==> UIFont.systemFont(ofSize: 14)
      \.title.textColor ==> .grey
    }
  }
}
```

And to consume, just refer `ButtonStyle` directly:

```
UIButton {
  ButtonStyle(for: UIButton.self)
}
```

_Take note that the View constraint is **required**. There are limitations in Swift's generic type system._

~ more todo, coming soon ~