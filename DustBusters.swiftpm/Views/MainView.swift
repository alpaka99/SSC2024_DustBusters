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
                
//                NavigationLink(mainViewReducer.startButtonTitle, value: MainViewReducer())
//                    .navigationDestination(for: MainViewReducer.self) { value in
//                        TestView(testViewReducer: value)
//                    }
//                .font(.title)
//                .foregroundStyle(Color.white)
//                .padding(16)
//                .background {
//                    RoundedRectangle(cornerRadius: 20)
//                        .fill(mainViewReducer.isStartDisabled ? .gray : .green)
//                }
//                .disabled(mainViewReducer.isStartDisabled)
                
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
