# DustBusters

`나쁜 미세먼지를 퇴치해볼까?` 😷

> 미세먼지 퇴치 게임을 통해 미세먼지 정보 전달을 하는 앱
> 

## 프로젝트 주요 기능
- Animation과 Transition을 이용하여 사용자와 상호작용하는 뷰로 미세먼지 정보전달
- CoreML의 GestureRecognition 및 ARKit을 이용하여 미세먼지 제거 AR 게임 구현

## 프로젝트 개발 환경


- **개발 인원**
    - iOS 개발자 1명
- **개발 기간**
    - 8일(24.07.22~24.07.29)

## 프로젝트 기술 스택


- **활용 기술 및 키워드**
    - **iOS:** SwiftUI, UIKit, iOS 16.0+, swift 5.10, xcode 15.3
    - **Architecture:** MVC
    - **Library**: CoreML, ARKit
- **라이브러리**

| **라이브러리** | **사용 목적** | **Version** |
| --- | --- | --- |
| CoreML | GestureRecognition을 이용한 손모양 인식 |  |
| ARKit | AR 객체를 이용한 미세먼지 게임 구현 |  |

## 폴더 구조


```
DustBusters.swiftpm
 ┣ Assets.xcassets
 ┣ Extensions
 ┣ Protocols
 ┣ Resource
 ┃ ┣ 3dAssets
 ┃ ┣ Classifiers
 ┃ ┃ ┗ MyHandPoseClassifier.mlmodelc
 ┃ ┗ Sounds
 ┣ Sources
 ┣ ViewControllers
 ┣ Views
 ┃ ┣ ARViews
 ┃ ┣ BackgroundViews
 ┃ ┣ MainViews
 ┃ ┣ MicroDustEffectViews
 ┃ ┣ ModalViews
 ┃ ┣ SizeCompareViews
 ┃ ┗ SwipeViews
 ┣ Constants.swift
 ┣ MyApp.swift
 ┗ Package.swift
```

## Swift Student Challenge 2024 Winner
<img width="500" alt="스크린샷 2024-09-18 오후 7 37 10" src="https://github.com/user-attachments/assets/f88b8fb6-f517-407c-84fa-317de8bd33c3">


- Apple에서 주최하는 Apple Swift Student Challenge 2024에 입상
