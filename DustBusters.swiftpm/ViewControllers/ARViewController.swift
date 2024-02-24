//
//  ARViewController 2.swift
//
//
//  Created by user on 2/14/24.
//

import ARKit
import CoreML
import RealityKit
import UIKit

class ARViewController: UIViewController {
    let crosshairImageName: String = "Crosshair"
    let fingerHeartSilhouetteName: String = "fingerHeartFixed"
    let heartModelPath: String = "Resource/3dAssets/Effects.scn"
    let targetModelPath: String = "Resource/3dAssets/dustTarget.usdz"
    let initialScoreLabelText: String = "Score: 0"
    let pointLight = Lighting().light
    let timeLimit: Double = 20
    let handPosePredictionInterval: Int = 5
    let customDistance: Float = 20
    let targetNodeAmount: Int = 10
    
    private var arSceneView: ARSCNView!
    private var frameCounter: Int = 0
    private var model: MyHandPoseClassifier?
    private var viewWidth: Int = 0
    private var viewHeight: Int = 0
    private var currentHandPoseObservation: VNHumanHandPoseObservation?
    private var heartNode: SCNNode?
    private var starNodes: [SCNNode] = []
    private var targetNodes: [SCNNode] = []
    private var isEffectAppearing: Bool = false
    private var currentCameraDirection: simd_float4x4?
    private var instructionLabel: UILabel!
    private var scoreLabel: UILabel!
    private var timer: Timer?
    private var resultView: UIView!
    private var resultLabel: UILabel!
    private var resetButton: UIButton!
    private var nextButton: UIButton!
    private var fingerHeartSilhouetteView: UIImageView!
    
    private var score: Int = 0 {
        didSet {
            if score == 10 {
                showResult()
            }
        }
    }
    private var seconds: Double = 0 {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.scoreLabel.text = String(
                    format: "Target: %d/10, Time: %.1f",
                    self?.score ?? -1,
                    abs((self?.timeLimit ?? -100) -  (self?.seconds ?? -100))
                )
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        arSceneView = ARSCNView(frame: view.bounds)
        arSceneView.session.delegate = self
        arSceneView.delegate = self
        
        arSceneView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(arSceneView)
        
        arSceneView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        arSceneView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        arSceneView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        arSceneView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        
        // setup game
        setUpGame()
    }
    
    func update() {
        for targetNode in targetNodes {
            // for heartNode
            if let heartNode = heartNode {
                let heartPosition = heartNode.position
                let targetPosition = targetNode.position
                
                let distance = sqrt(pow(
                    heartPosition.x - targetPosition.x,
                    2
                ) + pow(
                    heartPosition.y - targetPosition.y,
                    2
                ) + pow(
                    heartPosition.z - targetPosition.z,
                    2
                ))
                
                if distance < 1 { // Assume 0.5 as the threshold
                    score += 1
                    // Optionally, remove the targetNode from targetNodes and the scene
                    if let index = targetNodes.firstIndex(of: targetNode) {
                        targetNodes.remove(at: index)
                        targetNode.removeFromParentNode()
//                        HapticManager.shared.createHaptic(.medium)
                        
                        //MARK: Fix haptic manager
                        HapticManager.shared?.playHaptic(duration: [], powers: [])
                        AudioManager.shared.playSound(.samplesound)
                    }
                }
            }
        }
        
        if seconds > timeLimit {
            self.stopTimer()
            self.stopModel()
            self.showResult()
        }
    }
    
    func showResult() {
        DispatchQueue.main.async { [ weak self ] in
            let alertController = UIAlertController(
                title: "Time's UP!",
                message: String(
                    format: "Your score is \n %d / %d",
                    self?.score ?? -1,
                    self?.targetNodeAmount ?? -1
                ),
                preferredStyle: .alert
            )
            alertController.addAction(
                UIAlertAction(
                    title: "Replay",
                    style: .cancel
                ) { _ in
                    self?.resetGame()
            })
            alertController.addAction(
                UIAlertAction(
                    title: "Next",
                    style: .default
                ) { _ in
                    self?.dismiss(animated: true)
                    NotificationCenter.default.post(
                        name: Notification.Name("ARViewEndNotification"),
                        object: nil
                    )
                })
            
            self?.present(alertController, animated: true)
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
        self.seconds = timeLimit
    }
    
    func setupScoreLabel() {
        scoreLabel = UILabel(frame: CGRect(
            x: 0,
            y: 0,
            width: 200,
            height: 30
        ))
        scoreLabel.center = CGPoint(
            x: viewWidth/2,
            y: 50
        )
        scoreLabel.textAlignment = .center
        scoreLabel.text = initialScoreLabelText
        
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(scoreLabel)
        
        scoreLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 20).isActive = true
        scoreLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    }
    
    func setLayout() {
        setupCrosshair()
    }
    
    func setupCrosshair() {
        let crosshairImage = UIImage(named: crosshairImageName)
        let crosshairView = UIImageView(image: crosshairImage)
        crosshairView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(crosshairView)
        
        let widthConstraint = crosshairView.widthAnchor.constraint(equalToConstant: 50)
        let heightConstraint = crosshairView.heightAnchor.constraint(equalToConstant: 50)
        
        let centerXConstraint = crosshairView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        let centerYConstraint = crosshairView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        
        NSLayoutConstraint.activate(
            [
                widthConstraint,
                heightConstraint,
                centerXConstraint,
                centerYConstraint
            ])
    }
    
    func setUpInstructionLabel() {
        instructionLabel = UILabel()
        instructionLabel.text = "Do finger heart with your hand to shoot hearts!🫰"
        
        instructionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(instructionLabel)
        
        instructionLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        instructionLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
    }
    
    func showInstructionLabel() {
        self.instructionLabel.alpha = 1
    }
    
    func hideInstructionLabel() {
        self.instructionLabel.alpha = 0
    }
    
    func createFingerHeartSilhouette() {
        let fingerHeartSilhouetteImage = UIImage(named: fingerHeartSilhouetteName)
        
        guard let fingerHeartSilhouetteImage = fingerHeartSilhouetteImage else { return }
        
        fingerHeartSilhouetteView = UIImageView(image: fingerHeartSilhouetteImage)
        
        fingerHeartSilhouetteView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(fingerHeartSilhouetteView)
        
        fingerHeartSilhouetteView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        fingerHeartSilhouetteView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 20).isActive = true
        
    }
    
    func createTarget() -> SCNNode? {
        guard let targetScene = SCNScene(named: targetModelPath) else {
            fatalError("Failed to load \(targetModelPath).")
        }
        guard let targetNode = targetScene.rootNode.childNodes.first else { return nil }
        targetNode.scale = SCNVector3(
            0.002,
            0.002,
            0.002
        )
        let lookAtConstraint = SCNLookAtConstraint(target: arSceneView.pointOfView)
        lookAtConstraint.isGimbalLockEnabled = true
        targetNode.constraints = [lookAtConstraint]
        
        return targetNode
    }
    
    func createTargetNodes() {
        for _ in targetNodes.count..<targetNodeAmount {
            if let targetNode = self.createTarget() {
                targetNodes.append(targetNode)
            }
        }
    }
    
    func distributeTargetNode() {
        for targetNode in targetNodes {
            targetNode.position = SCNVector3(
                Float.random(in: -10...10),
                Float.random(in: -5...5),
                -10 // aprox 2 meters away
            )
            
            arSceneView.scene.rootNode.addChildNode(targetNode)
        }
        

    }
    
    func setModel() {
        self.model = try? MyHandPoseClassifier(configuration: MLModelConfiguration())
    }
    
    func stopModel() {
        self.model = nil
    }
    
    
    func makePrediction(handPoseObservation: VNHumanHandPoseObservation) {
        guard let model = self.model else { return }
        // key information about hand pose
        guard let keypointsMultiArray = try? handPoseObservation.keypointsMultiArray() else { fatalError() }
        do {
            // input keypointsMultiArray and do prediction using model
            DispatchQueue.main.async {
                self.hideInstructionLabel()
            }
            
            let prediction = try model.prediction(poses: keypointsMultiArray)
            let label = prediction.label
            
            guard let confidence = prediction.labelProbabilities[label] else { return }
//            print("label:\(prediction.label)\nconfidence:\(confidence)")
            
            // do this if prediction > 70%
            if confidence > 0.7 {
                DispatchQueue.main.async { [weak self] in
                    switch label {
                    case "heart":
                        if self?.timer == nil { self?.startTimer() }
                        self?.displayFingerHeartEffect()
                    default : break
                    }
                }
            }
        } catch {
//            print("Prediction error")
        }
    }
    
    
    func displayFingerHeartEffect(){
        
        guard !isEffectAppearing else { return }
        isEffectAppearing = true
        
        // get hand pose, then get finger position using getHandPosition
        guard let cameraDirection = currentCameraDirection,
              let handPoseObservation = currentHandPoseObservation,
              let indexFingerPosition = getHandPosition(handPoseObservation: handPoseObservation)
        else { return }
        
        if let heartNode = heartNode {
            heartNode.position = indexFingerPosition
            
            let fadeIn = SCNAction.fadeIn(duration: 0.2)
            
            let cameraPosition = SCNVector3(
                cameraDirection[3][0],
                cameraDirection[3][1],
                cameraDirection[3][2]
            )
            let cameraDirectionVector = SCNVector3(
                -cameraDirection[2][0],
                 -cameraDirection[2][1],
                 -cameraDirection[2][2]
            )
            
            let desiredDirection = cameraDirectionVector
            let distanceToMove: Float = customDistance
            
            let targetPosition = SCNVector3(
                cameraPosition.x + desiredDirection.x * distanceToMove,
                cameraPosition.y + desiredDirection.y * distanceToMove,
                cameraPosition.z + desiredDirection.z * distanceToMove
            )
            
            
            let move = SCNAction.move(
                to: targetPosition,
                duration: 0.7
            )
            
            let switchEffectAppearing = SCNAction.run { node in
                self.isEffectAppearing = false
            }
            let fadeOut = SCNAction.fadeOut(duration: 0.5)
//            print("trying to shoot heartnode")
            heartNode.runAction(.sequence(
                [
                    fadeIn,
                    move,
                    fadeOut,
                    switchEffectAppearing
                ]))
        } else {
            print("no heart node")
            prepareEffects()
            self.isEffectAppearing = false
        }
        
    }
    
    //MARK: Not currently using this functionality
    
    func getHandPosition(handPoseObservation: VNHumanHandPoseObservation) -> SCNVector3? {
        // fetch indexFingertip position detected by handPoseObservation and do confidence test
        // get indexFingerTip position only if confidence > 30%
        guard let indexFingerTip = try? handPoseObservation.recognizedPoints(.all)[.indexPIP],
              indexFingerTip.confidence > 0.3
        else { return nil }
        
        // return denormalized points as image points
        let deNormalizedIndexPoint = VNImagePointForNormalizedPoint(
            CGPoint(
                x: indexFingerTip.location.x,
                y:1-indexFingerTip.location.y
            ),
            viewWidth,
            viewHeight
        )
        
        let infrontOfCamera = SCNVector3(
            x: 0,
            y: 0,
            z: -0.1
        )
        
        // get camera node
        guard let cameraNode = arSceneView.pointOfView
        else { return nil}
        
        // translate camera position to world position
        let pointInWorld = cameraNode.convertPosition(
            infrontOfCamera,
            to: nil
        )
        
        // calculate screen position
        var screenPos = arSceneView.projectPoint(pointInWorld)
        screenPos.x = Float(deNormalizedIndexPoint.x)
        screenPos.y = Float(deNormalizedIndexPoint.y)
        
        // translate screen position to world position
        let finalPosition = arSceneView.unprojectPoint(screenPos)
        return finalPosition
    }
    
    func prepareEffects() {
        guard let scene = SCNScene(named: heartModelPath) else { return }
        
        // add Effect.heart to arSceneView
        guard let heart = scene.rootNode.childNode(
            withName: "heart",
            recursively: true
        ) else {
//            print("cannot find childnode of heartScene")
            return
        }
        
        heart.scale = SCNVector3(
            x: 0.05,
            y: 0.05,
            z: 0.05
        )
        heartNode = heart
        arSceneView.scene.rootNode.addChildNode(heart)
        heart.opacity = 0
    }
    
    func removeTargetFromScreen() {
        for node in self.targetNodes {
            node.removeFromParentNode()
        }
        
//        targetNodes = []
    }
}

// extension for detecting and tracking hand pose
extension ARViewController: ARSessionDelegate {
    func session(
        _ session: ARSession,
        didUpdate frame: ARFrame
    ) {
        // save the pixel buffer of current frame
        let pixelBuffer = frame.capturedImage
        currentCameraDirection = frame.camera.transform
        
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            
            // request for detecting handpose
            let handPoseRequest = VNDetectHumanHandPoseRequest()
            
            handPoseRequest.maximumHandCount = 2
            handPoseRequest.revision = VNDetectHumanHandPoseRequestRevision1
            
            // process image
            let handler = VNImageRequestHandler(
                cvPixelBuffer: pixelBuffer,
                orientation: .right ,
                options: [:]
            )
            do {
                try handler.perform([handPoseRequest])
            } catch {
                assertionFailure("HandPoseRequest failed: \(error)")
            }
            
            guard let handPoses = handPoseRequest.results, !handPoses.isEmpty else { return }
            
            //if handPose detected, save to observation
            guard let observation = handPoses.first else { return }
            
            self?.currentHandPoseObservation = observation
            self?.frameCounter += 1
            
            
            // for predicting every 10 frames
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
        setARViewConfiguration()
        
        setUpInstructionLabel()
        createFingerHeartSilhouette()
        createTargetNodes()
        distributeTargetNode()

        setModel()
        setupScoreLabel()
        
        //create Effect
        prepareEffects()
    }
    
    func setARViewConfiguration() {
        let config = ARWorldTrackingConfiguration()
        // Person Occlusion not working in iPad...
//        config.frameSemantics.insert(.personSegmentationWithDepth)
        removeTargetFromScreen()
        arSceneView.session.run(config, options: [.removeExistingAnchors, .resetSceneReconstruction])
    }
    
    func resetGame() {
        self.scoreLabel.text = initialScoreLabelText
        self.frameCounter = 0
        self.seconds = 0
        self.score = 0
        self.setARViewConfiguration()
        self.createTargetNodes()
        self.distributeTargetNode()
        self.showInstructionLabel()
        self.setModel()
        self.prepareEffects()
    }
    
    func stopGame() {
        stopTimer()
        stopModel()
        self.arSceneView.session.pause()
    }
}

extension ARViewController: ARSCNViewDelegate {
    func renderer(
        _ renderer: SCNSceneRenderer,
        updateAtTime time: TimeInterval
    ) {
        if seconds <= timeLimit {
            update()
        } else {
            stopGame()
            showResult()
        }
    }
}

class Lighting: Entity, HasPointLight {
    required init() {
        super.init()
        
        self.light = PointLightComponent(
            color: .white,
            intensity: 10000,
            attenuationRadius: 20
        )
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
