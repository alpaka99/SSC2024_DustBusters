//
//  File.swift
//  
//
//  Created by user on 2/14/24.
//

import Foundation
import SwiftUI
import UIKit

struct ARView: View {
    @Binding var path: NavigationPath
    @State private var arViewControllerContainer: ARViewControllerContainer? = ARViewControllerContainer()
    let arViewFinishedPublisher = NotificationCenter.default.publisher(for: Notification.Name("ARViewEndNotification"))
    @State private var viewToShow: ViewToShow = .beforeGame
    
    @State private var isShowingFirstModal: Bool = true
    @State private var firstTrigger: Bool = false
    
    @State private var isShowingSecondModal: Bool = false
    @State private var secondTrigger: Bool = false
    
    enum ViewToShow {
        case beforeGame, arView, gameEnded
    }
    
    var body: some View {
        switch viewToShow {
        case .beforeGame:
            CityLineView(
                color: .constant(.orange)
            )
                .modalView(
                    isShowingModal: $isShowingFirstModal,
                    trigger: $firstTrigger,
                    modalColor: .constant(.orange),
                    messages: ["Using your device's camera,", "and your love for community,", "We are going to catch micro dust...", "With finger heart! 🫰"],
                    tapBackgroundToDismiss: false
                )
                .onChange(of: firstTrigger) { _ in
                    self.viewToShow = .arView
                }
                .toolbar {
                    ToolbarItem {
                        Button {
                            isShowingFirstModal = true
                        } label: {
                            Image(systemName: "questionmark.circle")
                                .font(.largeTitle)
                        }
                    }
                }
        case .arView:
            arViewControllerContainer
                .onDisappear {
                    self.arViewControllerContainer = nil
                }
                .onReceive(arViewFinishedPublisher) { _ in
                    // MARK: endARView
                    self.arViewControllerContainer = nil
                    withAnimation {
                        isShowingSecondModal = true
                    }
                    viewToShow = .gameEnded
                }
                .navigationBarBackButtonHidden(true)
                .toolbar {
                    ToolbarItem {
                        Button {
                            self.viewToShow = .gameEnded
                        } label: {
                            Text("Next")
                        }
                    }
                }
        case .gameEnded:
            CityLineView(color: .constant(.orange))
            .modalView(
                isShowingModal: $isShowingSecondModal,
                trigger: $secondTrigger,
                modalColor: .constant(Color.appColor()),
                messages: ["Great job on catching micro dusts!", "Like you saw, there are many micro dusts around us.", "And over the last 20 years, micro dusts have increased more than 30%.","So what happens to the rest of micro dusts?"],
                tapBackgroundToDismiss: true
            )
            .onChange(of: secondTrigger) { _ in
                path.append(Constants.NavigationValue.microDustEffectView)
            }
            .toolbar {
                ToolbarItem {
                    Button {
                        isShowingSecondModal = true
                    } label: {
                        Image(systemName: "questionmark.circle")
                            .font(.largeTitle)
                    }
                }
            }
                
        }
        
    }
    
    
    var tutorialView: some View {
        VStack {
            EmptyView()
        }
    }
}


