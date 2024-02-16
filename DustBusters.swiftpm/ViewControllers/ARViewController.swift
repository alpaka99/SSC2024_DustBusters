//
//  ARViewController 2.swift
//
//
//  Created by user on 2/14/24.
//

import ARKit
import CoreML
import UIKit

class ARViewController: UIViewController {
    private var arSceneView: ARSCNView!
    private var frameCounter: Int = 0
    private let handPosePredictionInterval: Int = 10
    private var model = try? MyHandPoseClassifier()
    private var viewWidth: Int = 0
    private var viewHeight: Int = 0
    private var currentHandPoseObservation: VNHumanHandPoseObservation?
    private var heartNode: SCNNode?
    private var starNodes: [SCNNode] = []
    private var targetNodes: [SCNNode] = []
    private var isEffectAppearing: Bool = false
    private var currentCameraDirection: simd_float4x4?
    private var customDistance: Float = 20
    private var scoreLabel: UILabel!
    private var timer: Timer?
    private var resultView: UIView!
    private var resultLabel: UILabel!
    private var resetButton: UIButton!
    private var nextButton: UIButton!
    private var score: Int = 0 {
        didSet {
            if score == 10 {
                showResult()
            }
        }
    }
    private var seconds: Float = 0 {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.scoreLabel.text = String(
                    format: "Target: %d/10, Time: %.3f",
                    self?.score ?? -1,
                    self?.seconds ?? -1
                )
            }
        }
    }
    
    //ViewController가 처음 나타날 때 실행되는 코드
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //ARSCNView를 전체 화면 사이즈로 생성 후 view에 추가
        arSceneView = ARSCNView(frame: view.bounds)
        arSceneView.session.delegate = self
        arSceneView.delegate = self
        view.addSubview(arSceneView)
        viewWidth = Int(arSceneView.bounds.width)
        viewHeight = Int(arSceneView.bounds.height)
        
        
        // setup game
        setUpGame()
    }
    
    func update() {
        for targetNode in targetNodes {
            // for heartNode
            if let heartNode = heartNode {
                let heartPosition = heartNode.position
                let targetPosition = targetNode.position
                
                let distance = sqrt(pow(heartPosition.x - targetPosition.x, 2) +
                                    pow(heartPosition.y - targetPosition.y, 2) +
                                    pow(heartPosition.z - targetPosition.z, 2))
                
                if distance < 0.5 { // Assume 0.1 as the threshold
                    score += 1
                    // Optionally, remove the targetNode from targetNodes and the scene
                    if let index = targetNodes.firstIndex(of: targetNode) {
                        targetNodes.remove(at: index)
                        targetNode.removeFromParentNode()
                    }
                }
            }
            
            
        }
//        if score == 10 {
//            stopTimer()
//        }
        
        if seconds > 20 {
            stopTimer()
            showResult()
        }
    }
    
    func showResult() {
        DispatchQueue.main.async { [ weak self ] in
//            guard let seconds = self?.seconds, let timeLabel = self?.resultLabel else { return }
//            self?.resultLabel.text = String(format: "Your score is \n %d", self?.targetNodes.count ?? -1)
//            self?.resultView.alpha = 1 // Make the label visible
//            self?.resultLabel.alpha = 1
            let alertController = UIAlertController(title: "Time's UP", message: String(format: "Your score is \n %d", self?.targetNodes.count ?? -1), preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Replay", style: .cancel) { _ in
                self?.setUpGame()
            })
            
            self?.present(alertController, animated: true)
//            }
        }
    }
    
    
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.001, repeats: true) {[weak self] _ in
            self?.seconds += 0.001
        }
    }
    
    func stopTimer() {
        self.timer?.invalidate()
        self.timer = nil
    }
    
    func setupTimeLabel() {
//        // Create a new label
//        resultLabel = UILabel()
//        resultLabel.font = UIFont.systemFont(ofSize: 30)
//        resultLabel.textColor = .white
//        resultLabel.textAlignment = .center
//        resultLabel.alpha = 0 // Make the label initially transparent
//        resultLabel.numberOfLines = 2
//        resultLabel.translatesAutoresizingMaskIntoConstraints = false
//        
//        
//        
//        // Add the label to the view
//        self.view.addSubview(resultLabel)
//        
//        // Center the label in the view
//        resultLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
//        resultLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        
        // resultView
        resultView = UIView()
        resultView.alpha = 0
        resultView.translatesAutoresizingMaskIntoConstraints = false
        
        resultLabel = UILabel()
        resultLabel.font = UIFont.systemFont(ofSize: 30)
        resultLabel.textColor = .white
        resultLabel.textAlignment = .center
        resultLabel.alpha = 0 // Make the label initially transparent
        resultLabel.numberOfLines = 2
        resultLabel.translatesAutoresizingMaskIntoConstraints = false
        
        resetButton = UIButton()
        resetButton.titleLabel?.text = "Replay"
        resetButton.translatesAutoresizingMaskIntoConstraints = false
        
        nextButton = UIButton()
        nextButton.titleLabel?.text = "Next"
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        
        resultView.addSubview(resultLabel)
        resultView.addSubview(resetButton)
        resultView.addSubview(nextButton)
        
        self.view.addSubview(resultView)
        
    }
    
    func setupScoreLabel() {
        scoreLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 30))
        scoreLabel.center = CGPoint(x: viewWidth/2, y: 50)
        scoreLabel.textAlignment = .center
        scoreLabel.text = "Score: 0"
        self.view.addSubview(scoreLabel)
    }
    
    func setupCrosshair() {
        let crosshairImage = UIImage(named: "Crosshair")
        let crosshairView = UIImageView(image: crosshairImage)
        crosshairView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(crosshairView)
        
        // crosshairView의 너비와 높이를 각각 50으로 설정합니다.
        let widthConstraint = crosshairView.widthAnchor.constraint(equalToConstant: 50)
        let heightConstraint = crosshairView.heightAnchor.constraint(equalToConstant: 50)
        
        // crosshairView를 뷰의 중앙에 위치하도록 제약 조건을 추가합니다.
        let centerXConstraint = crosshairView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        let centerYConstraint = crosshairView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        
        // 제약 조건을 활성화합니다.
        NSLayoutConstraint.activate([widthConstraint, heightConstraint, centerXConstraint, centerYConstraint])
    }
    
    func createTargets() {
        for _ in 0..<10 {
            guard let targetScene = SCNScene(named: "Resource/3dAssets/Target.usdz") else {
                fatalError("Failed to load Target.usdz.")
            }
            guard let targetNode = targetScene.rootNode.childNodes.first?.clone() else {return}
            targetNode.scale = SCNVector3(0.002, 0.002, 0.002)
            targetNode.position = SCNVector3(
                Float.random(in: -10...10),
                Float.random(in: -5...5),
                -10 // 2 meters away
            )
            
            let lookAtConstraint = SCNLookAtConstraint(target: arSceneView.pointOfView)
            lookAtConstraint.isGimbalLockEnabled = true
            targetNode.constraints = [lookAtConstraint]
            
            arSceneView.scene.rootNode.addChildNode(targetNode)
            targetNodes.append(targetNode)
        }
    }
    
    
    func makePrediction(handPoseObservation: VNHumanHandPoseObservation) {
        guard let model = self.model else { return }
        //손 모습의 키포인트 정보
        guard let keypointsMultiArray = try? handPoseObservation.keypointsMultiArray() else { fatalError() }
        do {
            //모델을 사용하여 keypointsMultiArray를 입력으로 하여 예측 수행
            let prediction = try model.prediction(poses: keypointsMultiArray)
            let label = prediction.label
            
            guard let confidence = prediction.labelProbabilities[label] else { return }
            print("label:\(prediction.label)\nconfidence:\(confidence)")
            
            //예측의 신뢰도가 80% 이상이면 아래의 동작을 수행
            if confidence > 0.8 {
                DispatchQueue.main.async { [weak self] in
                    switch label {
                    case "heart":
                        if self?.timer == nil { self?.startTimer() }
                        self?.displayFingerHeartEffect()
                        //                    case "peace":
                        //                        if timer == nil { startTimer() }
                        //                        displayPeaceEffect()
                    default : break
                    }
                }
            }
        } catch {
            print("Prediction error")
        }
    }
    
    
    func displayFingerHeartEffect(){
        //이미 effect가 표시 중일 때는 다시 표시하지 않음
        guard !isEffectAppearing else { return }
        isEffectAppearing = true
        
        //손 모습을 가져온 후, getHandPosition 함수를 사용하여 손가락 위치를 가져옴
        guard let cameraDirection = currentCameraDirection,
              let handPoseObservation = currentHandPoseObservation,
              let indexFingerPosition = getHandPosition(handPoseObservation: handPoseObservation)
        else { return }
        
        if let heartNode = heartNode {
            heartNode.position = indexFingerPosition
            
            let fadeIn = SCNAction.fadeIn(duration: 0.2)
            
            let cameraPosition = SCNVector3(cameraDirection[3][0], cameraDirection[3][1], cameraDirection[3][2])
            let cameraDirectionVector = SCNVector3(-cameraDirection[2][0], -cameraDirection[2][1], -cameraDirection[2][2])
            
            let desiredDirection = cameraDirectionVector
            let distanceToMove: Float = customDistance
            
            let targetPosition = SCNVector3(
                cameraPosition.x + desiredDirection.x * distanceToMove,
                cameraPosition.y + desiredDirection.y * distanceToMove,
                cameraPosition.z + desiredDirection.z * distanceToMove
            )
            
            
            let move = SCNAction.move(to: targetPosition, duration: 0.6)
            
            let shakeHalfRight = SCNAction.rotate(by: -0.3, around: SCNVector3(x: 0, y: 0, z: 1), duration: 0.025)
            let shakeLeft = SCNAction.rotate(by: 0.6, around: SCNVector3(x: 0, y: 0, z: 1), duration: 0.02)
            let shakeRight = SCNAction.rotate(by: -0.6, around: SCNVector3(x: 0, y: 0, z: 1), duration: 0.02)
            let shakeHalfLeft = SCNAction.rotate(by: 0.3, around: SCNVector3(x: 0, y: 0, z: 1), duration: 0.025)
            let shake = SCNAction.sequence([shakeLeft,shakeRight])
            let switchEffectAppearing = SCNAction.run { node in
                self.isEffectAppearing = false
            }
            let fadeOut = SCNAction.fadeOut(duration: 0.5)
//            let shakeRepeat = SCNAction.sequence([shakeHalfRight,shake,shake,shake,shake,shakeHalfLeft])
            heartNode.runAction(.sequence([fadeIn,move,fadeOut,switchEffectAppearing]))
        } else {
            prepareEffects()
            self.isEffectAppearing = false
        }
        
    }
    
    
    func displayPeaceEffect(){
        //이미 effect가 표시 중일 때는 다시 표시하지 않음
        guard !isEffectAppearing else { return }
        
        //손 모습을 가져온 후, getHandPosition 함수를 사용하여 손가락 위치를 가져옴
        isEffectAppearing = true
        guard let handPoseObservation = currentHandPoseObservation,
              let cameraDirection = currentCameraDirection,
              let indexFingerPosition = getHandPosition(handPoseObservation: handPoseObservation)
        else { return }
        
        // starNode에 담겨있는 8개의 별에 대해서 다음의 동작 수행
        starNodes.forEach { star in
            //투명도 초기화, 위치를 손가락 위치로 설정
            star.opacity = 1
            star.position = indexFingerPosition
            
            //random한 좌표값을 생성해서 randomX, randomY, randomZ에 저장
            let randomX = Float.random(in: -0.05...0.05)
            let randomY = Float.random(in: 0...0.05)
            let randomZ = Float.random(in: -0.05...0.05)
            let fadeIn = SCNAction.fadeIn(duration: 0.1)
            
            let cameraPosition = SCNVector3(cameraDirection[3][0], cameraDirection[3][1], cameraDirection[3][2])
            let cameraDirectionVector = SCNVector3(-cameraDirection[2][0], -cameraDirection[2][1], -cameraDirection[2][2])
            
            let desiredDirection = cameraDirectionVector
            let distanceToMove: Float = customDistance
            
            let targetPosition = SCNVector3(
                cameraPosition.x + desiredDirection.x * distanceToMove,
                cameraPosition.y + desiredDirection.y * distanceToMove,
                cameraPosition.z + desiredDirection.z * distanceToMove
            )
            
            
            let moveForward = SCNAction.move(to: targetPosition, duration: 1.0)
            let move = SCNAction.move(by: SCNVector3(x: randomX, y: randomY, z: randomZ), duration: 0.5)
            move.timingMode = .easeInEaseOut
            let fadeOut = SCNAction.fadeOut(duration: 1)
            let switchEffectAppearing = SCNAction.run { node in
                self.isEffectAppearing = false
            }
            star.runAction(.sequence([fadeIn, move, moveForward, fadeOut, switchEffectAppearing]))
        }
        
        //2초 후에 isEffectAppearing 상태를 다시 false로 변경하여 효과 표시를 가능하게 함
        Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { timer in
            self.isEffectAppearing = false
        }
    }
    
    func getHandPosition(handPoseObservation: VNHumanHandPoseObservation) -> SCNVector3? {
        //handPoseObservation에서 인식된 손가락 끝 위치(.indexPIP)를 가져오고, 해당 위치의 신뢰도를 검사
        //신뢰도가 0.3보다 작으면 위치를 가져올 수 없으므로 nil을 반환
        guard let indexFingerTip = try? handPoseObservation.recognizedPoints(.all)[.indexPIP],
              indexFingerTip.confidence > 0.3
        else {return nil}
        
        // 정규화되지 않은 포인트를 이미지 좌표로 변환
        let deNormalizedIndexPoint = VNImagePointForNormalizedPoint(
            CGPoint(x: indexFingerTip.location.x, y:1-indexFingerTip.location.y),
            viewWidth,
            viewHeight
        )
        
        // 카메라 앞의 위치
        let infrontOfCamera = SCNVector3(x: 0, y: 0, z: -0.1)
        
        // 카메라 노드 가져오기
        guard let cameraNode = arSceneView.pointOfView
        else { return nil}
        
        // 카메라 좌표계에서의 위치를 월드 좌표계로 변환
        let pointInWorld = cameraNode.convertPosition(infrontOfCamera, to: nil)
        
        // 화면 위치 계산
        var screenPos = arSceneView.projectPoint(pointInWorld)
        screenPos.x = Float(deNormalizedIndexPoint.x)
        screenPos.y = Float(deNormalizedIndexPoint.y)
        
        // 화면 위치를 월드 좌표계로 변환하여 반환
        let finalPosition = arSceneView.unprojectPoint(screenPos)
        print(finalPosition)
        return finalPosition
    }
    
    func prepareEffects() {
        guard let scene = SCNScene(named: "Resource/3dAssets/Effects.scn") else { return }
        
        //        print(scene.rootNode.childNodes)
        //Effects.scn에서 node 이름이 heart인 node를 arScnView에 추가
        guard let heart = scene.rootNode.childNode(withName: "heart", recursively: true) else {
            print("cannot find childnode of heartScene")
            return
        }
        
        heart.scale = SCNVector3(x: 0.005, y: 0.005, z: 0.005)
        heartNode = heart
        arSceneView.scene.rootNode.addChildNode(heart)
        heart.opacity = 0
        
        //8개의 별을 나타내기 위해 starNode에 8개의 별을 추가후 arScnView에 starNode 추가
//        for _ in 0...7 {
//            guard let star = scene.rootNode.childNode(withName: "star", recursively: true)?.clone() else {return}
//            star.scale = SCNVector3(x: 0.002, y: 0.002, z: 0.002)
//            starNodes.append(star)
//            arSceneView.scene.rootNode.addChildNode(star)
//            star.opacity = 0
//        }
    }
}

//AR 세션이 프레임 업데이트를 받을 때 호출
//해당 프레임에서 추출한 이미지를 사용하여 사용자의 손 모습을 감지하고 추적하는 작업을 수행
extension ARViewController: ARSessionDelegate {
    func session(_ session: ARSession, didUpdate frame: ARFrame) {
        //현재 프레임에서 캡처한 이미지의 픽셀 버퍼가 저장
        let pixelBuffer = frame.capturedImage
        
        currentCameraDirection = frame.camera.transform
        //백그라운드 스레드에서 다음 로직이 실행되도록 처리
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            //손 모습을 감지하기 위한 Vision 프레임워크의 요청
            let handPoseRequest = VNDetectHumanHandPoseRequest()
            //최대 손 개수를 1개
            handPoseRequest.maximumHandCount = 2
            handPoseRequest.revision = VNDetectHumanHandPoseRequestRevision1
            
            // 이미지 처리를 수행
            let handler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer,orientation: .right , options: [:])
            do {
                try handler.perform([handPoseRequest])
            } catch {
                assertionFailure("HandPoseRequest failed: \(error)")
            }
            
            //손모습이 감지되었다면 이후 코드 실행
            guard let handPoses = handPoseRequest.results, !handPoses.isEmpty else { return }
            
            //첫 번째 손 모습 감지 결과를 observation에 저장
            guard let observation = handPoses.first else { return }
            
            self?.currentHandPoseObservation = observation
            self?.frameCounter += 1
            
            //만약 frameCounter가 handPosePredictionInterval로 나누어 떨어진다면, 손 모습 예측을 수행하는 makePrediction 함수를 호출
            //매 프레임 마다 수행하는게 아닌, 30프레임마다 예측 수행
            if let frameCounter = self?.frameCounter,
               let handPosePredictionInterval = self?.handPosePredictionInterval {
                if frameCounter % handPosePredictionInterval == 0 {
                    self?.frameCounter = 0
                    self?.makePrediction(handPoseObservation: observation)
                }
            }
        }
    }
    
    func setUpGame() {
        //arScnView는 사용자의 얼굴을 추적하기 위해 ARFaceTrackingConfiguration로 생성
        //기존의 앵커들을 제거하고 새로운 추적 작업을 시작
        let config = ARWorldTrackingConfiguration()
        config.frameSemantics.insert(.personSegmentationWithDepth)
        
        arSceneView.session.run(config, options: [.removeExistingAnchors])
        
        setupCrosshair()
        createTargets()
        setupTimeLabel()
        
        setupScoreLabel()
        //effets 생성
        prepareEffects()
    }
}

extension ARViewController: ARSCNViewDelegate {
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        if seconds < 20 {
            update()
        } else {
//            self.model = nil
            stopTimer()
            showResult()
        }
    }
}


/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destination.
 // Pass the selected object to the new view controller.
 }
 */
