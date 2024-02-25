import SwiftUI

@main
struct MyApp: App {
    @State var path: NavigationPath = NavigationPath()
    
    var body: some Scene {
        WindowGroup {
//            NavigationStack(path: $path) {
//                HomeView(path: $path)
//                    .navigationDestination(for: Constants.NavigationValue.self) { value in
//                        switch value {
//                        case .homeView:
//                            HomeView(path: $path)
//                                .ignoresSafeArea()
//                            
//                        case .sizeCompareView:
//                            SizeCompareView(path: $path)
//                                .ignoresSafeArea()
//                            
//                        case .arView:
//                            ARView(path: $path)
//                                .ignoresSafeArea()
//                            
//                        case .microDustEffectView:
//                            MicroDustEffectView(path: $path)
//                                .ignoresSafeArea()
//                            
//                        case .swipeView:
//                            SwipeView(path: $path)
//                                .ignoresSafeArea()
//                            
//                        case .endingView:
//                            EndingView(path: $path)
//                                .ignoresSafeArea()
//                        }
//                    }
//                    .background {
//                        CityLineView(
//                            neighborhoodColor: .blue,
//                            middleLineColor: .indigo,
//                            skylineColor: .black
//                        )
//                    }
//            }
//            ModalTestView()
//            .ignoresSafeArea()
//            HomeView(path: $path)
//            NavigationStack {
//                SizeCompareView(path: $path)
//            }
            NavigationStack {
//                ARView(path: $path)
                MicroDustEffectView(path: $path)
            }
        }
    }
}
