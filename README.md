# Chips Custom View

Add chips on custom class view

# Preview

![Chips view](/Preview/Preview.png?raw=true)

## Installation

Add UIView on storyboard or xib view, and set custom class to "ChipsView"

![Set custom class](/Preview/Installation.png?raw=true)



## Usage

### Setup chips style 

![Set chips style](/Preview/Style.png?raw=true)

### Add Chips programmatically
```swift

@IBOutlet weak var chipsView: ChipsView!
    
override func viewDidAppear(_ animated: Bool) {
    chipsView.addChip(chip: "Chip insert on View Controller")       
}
```

You can retrieve deleted values with "Delegate"

```swift

@IBOutlet weak var chipsView: ChipsView!

override func viewDidLoad() {
    super.viewDidLoad()
    chipsView.delegate = self
}
    
override func viewDidAppear(_ animated: Bool) {
    chipsView.addChip(chip: "Chip insert on View Controller")       
}

extension ViewController: ChipsViewDelegate {
    func removeChip(value: String) {
        print("Remove : \(value)")
    }
}

```

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.

