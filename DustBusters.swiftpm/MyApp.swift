import SwiftUI

@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                    MainView(mainViewReducer: MainViewReducer(isStartDisabled: false, isContinueDisabled: true))
                    .background {
                        CityLineView(
                            neighborhoodColor: .green,
                            middleLineColor: .orange,
                            skylineColor: .blue
                        )
                    }
                }
//            .onAppear {
//                AudioManager.shared.playSound(.samplesound)
//            }
        }
    }
}
