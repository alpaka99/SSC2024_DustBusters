import SwiftUI

@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            MainView(mainViewReducer: MainViewReducer(isStartDisabled: false, isContinueDisabled: false))
        }
    }
}
