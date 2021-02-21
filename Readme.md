## Rocketpedia
##### Features:
- Display list of rockets from SpaceX API. 
- Each cell displays the image, name, first launch and color formatted success rate
- On cell tap, display the rocket details screen and link to wikipedia
- Use autolayout, dynamic font size, dark mode support

## Architecture
MVVM + Coordinator (

## Libraries used
- RxSwift: used for binding data from viewModel to viewController and react to user inputs
- Alamofire: used to perform simple get request and decode into Rocket model
- Nuke: used to perform image download/cache


## How to run
- Install cocoapods: `brew install cocoapods`
- Run `pod install`
- Open `*.xcworkspace`

##### What I would have improved given more time:
- Extract network request from viewModel and add unit tests
- Add splitview for bigger screen sizes

