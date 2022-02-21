//
//  BaseVC.swift
//  Organizer
//
//  Created by Petimezas, Chris, Vodafone on 21/2/22.
//

import UIKit
import AVFoundation

class BaseVC: UIViewController {

    var audioPlayer: AVAudioPlayer?

    func soundEffect(resourceName name: String, type: String = "wav") {
        guard let pathSound = Bundle.main.path(forResource: name, ofType: type)
        else {
            return
        }
        let url = URL(fileURLWithPath: pathSound)

        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
        } catch {
            print("Can't play the audio file failed with an error \(error.localizedDescription)")
        }
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
        audioPlayer?.stop()
        print("\(String(describing: type(of: self))) deinitialized")
    }
    
}
