import SwiftUI

struct HomeView: View {
    @Binding var path: NavigationPath
    @State private var isShowingModal: Bool = true
    @State private var trigger: Bool = false
    @State private var appColor: Color = Color.appColor()
    
    var body: some View {
        VStack {
            Spacer()
            Rectangle()
                .fill(
                    AngularGradient(gradient: Gradient(colors: [.red, .yellow, .green, .blue, .purple, .red]), center: .center)
                )
            
                .padding(20)
                .mask {
                    Text("Dust Busters!")
                        .font(.system(size: 100))
                }
            
            Spacer()
                .frame(maxHeight: 300)
            
            Button("Start!") {
                path.append(Constants.NavigationValue.sizeCompareView)
            }
            .font(.title)
            .foregroundStyle(Color.white)
            .padding(16)
            .background {
                RoundedRectangle(cornerRadius: 20)
                    .fill(.green)
            }
            .padding(.bottom, 300)
            
            Spacer()
        }
        .background {
            CityLineView(color: $appColor)
                .overlay {
                    StrokeCityLineView(color: $appColor)
                        .opacity(0.3)
                }
        }
        .modalView(
            isShowingModal: $isShowingModal,
            trigger: $trigger,
            modalColor: .constant(Color.appColor()),
            messages: ["Welcome to Dust Busters!", "In this app we are going to get rid of Micro dusts by following steps.", "Let's Play!"],
            tapBackgroundToDismiss: true
        )
        .onChange(of: trigger) { _ in
            // trigger action
            isShowingModal = false
        }
        .onAppear {
            appColor = Color.appColor()
        }
    }
}
