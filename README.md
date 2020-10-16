# mongKit
Library for creating iOS ui programmatically

Basic usage:

```
import UIKit
import mongKit

class SampleView: View {
  @ComponentBuilder override var body: Component {
    UILabel {
      Style(for: UILabel.self) {
        \.text ==> "Hello world!"
      }
      AutoLayout {
        Center()
      }
    }
  }
}
```

More elaborate readme soon~
