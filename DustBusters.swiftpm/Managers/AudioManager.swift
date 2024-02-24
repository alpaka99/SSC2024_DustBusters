//
//  File.swift
//
//
//  Created by user on 2/24/24.
//

import AVFoundation
import Foundation

final class AudioManager: EffectHelper {
    static var shared: AudioManager = AudioManager()
    
    private var player: AVAudioPlayer?
    
    init(player: AVAudioPlayer? = nil) {
        self.player = player
        
        self.configAVAudioSession()
    }
    
    func configAVAudioSession() {
        print(#function)
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Something went wrong while configuration setup for audioManager")
        }
    }
    
    func playSound(_ soundName: SoundName) {
        guard let soundURL = fetchSoundURL(soundName) else { return }
        
        do {
            self.player?.prepareToPlay()
            player = try AVAudioPlayer(contentsOf: soundURL)
            DispatchQueue.global(qos: .userInteractive).async { [weak self] in
                self?.player?.play()
            }
        } catch {
            print("Something went wrong while playing sound :(")
        }
        
    }
    
    private func fetchSoundURL(_ soundName: SoundName) -> URL? {
        guard let url = Bundle.main.url(forResource: "Resource/Sounds/\(soundName.rawValue)", withExtension: "mp3") else {
            print("Cannot find url")
            return nil
        }
        
        return url
    }
    
    enum SoundName: String {
        case samplesound
    }
}
