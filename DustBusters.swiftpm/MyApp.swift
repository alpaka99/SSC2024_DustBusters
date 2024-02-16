import SwiftUI

@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            Color.blue
                .overlay {
                    MainView(mainViewReducer: MainViewReducer(isStartDisabled: false, isContinueDisabled: false))
                }
        }
    }
}
