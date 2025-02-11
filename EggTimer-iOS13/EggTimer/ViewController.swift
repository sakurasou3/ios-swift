//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var barProgress: UIProgressView!
    @IBOutlet weak var titleLabel: UILabel!

    let eggTimes = ["Soft": 5, "Medium": 7 * 60, "Hard": 12 * 60]
    var timer = Timer()
    var player: AVAudioPlayer?

    @IBAction func hardnessSelected(_ sender: UIButton) {
        let hardness = sender.currentTitle!
        let allTime = eggTimes[hardness]
        var count = allTime

        self.barProgress.progress = 0.0
        self.titleLabel.text = hardness
        timer.invalidate()
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { Timer in
            if count != nil && count! > 0 {
                print("\(count!) secounds")
                count! -= 1
                self.barProgress.progress = Float(allTime! - count!) / Float(allTime!)
            } else {
                self.timer.invalidate()
                self.titleLabel.text = "Done!"
                self.barProgress.progress = 1.0
                
                guard let path = Bundle.main.path(forResource: "alarm_sound", ofType: "mp3") else { return }
                let url = URL(fileURLWithPath: path)
                do {
                    self.player = try AVAudioPlayer(contentsOf: url)
                    self.player?.play()
                } catch let error {
                    print(error.localizedDescription)
                }
            }
        }
    }
}
