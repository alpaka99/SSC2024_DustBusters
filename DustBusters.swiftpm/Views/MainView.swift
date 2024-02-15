import SwiftUI

struct MainView: View {
    let mainViewReducer: MainViewReducer
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                Rectangle()
                    .fill(
                        AngularGradient(gradient: Gradient(colors: [.red, .yellow, .green, .blue, .purple, .red]), center: .center)
                    )
                
                    .padding(20)
                    .mask {
                        Text("DustBusters!")
                            .font(.system(size: 100))
                    }
                
                
                Spacer()
                    .frame(maxHeight: 400)
                
                NavigationLink(mainViewReducer.startButtonTitle, value: ARViewReducer(reducerId: "ARViewReducer"))
                    .navigationDestination(for: ARViewReducer.self) { value in
                        ARView(arviewReducer: value)
                    }
//                Button("Find Path") {
//                    findPath()
//                }
                .font(.title)
                .foregroundStyle(Color.white)
                .padding(16)
                .background {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(mainViewReducer.isStartDisabled ? .gray : .green)
                }
                .disabled(mainViewReducer.isStartDisabled)
                
                NavigationLink(mainViewReducer.continueButtonTitle) {
                    
                }
                .font(.title)
                .foregroundStyle(Color.white)
                .padding(16)
                .background {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(mainViewReducer.isContinueDisabled ? .gray : .green)
                }
                .disabled(mainViewReducer.isContinueDisabled)
                
                Spacer()
            }
            .padding(100)
        }
    }
}

extension MainView {
    func findPath() {
        let bundle = Bundle.main
//        let url = bundle.url(forResource: "Effects", withExtension: "scn") //. ?? 이거 찾음
//        let url = bundle.url(forResource: "Target", withExtension: "usdz") //. ?? 이거도 찾음
        print(Bundle.main)
//        let url = bundle.url(forResource: "Resource/Classifiers/screenshot", withExtension: "png") // 됨
//        let url = bundle.url(forResource: "musicsample", withExtension: "mp3")
//        let url = bundle.url(forResource: "MyHandPoseClassifier", withExtension: "mlmodelc") //. 이건 왜 못찾음 또라이임? -> 검색을 해보니 mlmodelc도 파일 형태로 올라가서 못 찾는다는데,.. 흠
//        let url = bundle.url(forResource: "model", withExtension: "espresso.net") // 올라가긴 제대로 올라가네. 패키지 안에 있는걸 발견함
        let url = bundle.url(forResource: "Resource/Classifier/MyHandPoseClassifier", withExtension: "mlmodelc")
        print(url)
    }
}
