import SwiftUI

@main
struct MyApp: App {
    @State var path: NavigationPath = NavigationPath()
    @State private var color: Color = Color.appColor()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $path) {
                HomeView(path: $path)
                    .navigationDestination(for: Constants.NavigationValue.self) { value in
                        switch value {
                        case .homeView:
                            HomeView(path: $path)
                                .ignoresSafeArea()
                            
                        case .sizeCompareView:
                            SizeCompareView(path: $path)
                                .ignoresSafeArea()
                            
                        case .arView:
                            ARView(path: $path)
                                .ignoresSafeArea()
                            
                        case .microDustEffectView:
                            MicroDustEffectView(path: $path)
                                .ignoresSafeArea()
                            
                        case .swipeView:
                            SwipeView(path: $path)
                                .ignoresSafeArea()
                            
                        case .endingView:
                            EndingView(path: $path)
                                .ignoresSafeArea()
                        }
                    }
                    .onAppear {
                        color = Color.appColor()
                        print(color)
                    }
            }
        }
    }
}
