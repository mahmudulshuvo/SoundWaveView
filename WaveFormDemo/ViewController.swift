//
//  ViewController.swift
//  WaveFormDemo
//
//  Created by SHUVO on 10/19/16.
//  Copyright © 2016 SHUVO. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var player:AVAudioPlayer = AVAudioPlayer()
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var playPauseBtn: UIButton!
    @IBOutlet weak var sliderControl: UISlider!
    var remaining: Double = 0.0
    @IBOutlet weak var waveView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let audioPath = Bundle.main.path(forResource:"Test", ofType: "mp3")
        do {
            player = try AVAudioPlayer.init(contentsOf: NSURL(fileURLWithPath: audioPath!) as URL)
        }
        catch {
            print("Something bad happened. Try catching specific errors to narrow things down")
        }
        
        player.prepareToPlay()
        sliderControl.maximumValue = Float(player.duration)
        sliderControl.value = 0.0
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.updateTime), userInfo: nil, repeats: true)

    }
    
    
    @IBAction func playPauseBtnAction(_ sender: AnyObject) {
        
        if playPauseBtn.titleLabel?.text == "Play" {
            playPauseBtn.setTitle("Pause", for: UIControlState.normal)
            player.play()
        }
        
        else {
            playPauseBtn.setTitle("Play", for: UIControlState.normal)
            player.pause()
        }
        
    }
    
    
    func updateTime(_ timer: Timer) {
        sliderControl.value = Float(player.currentTime)
        remaining = Double(player.duration) - Double(player.currentTime)
        timerLabel.text =  String(format: "%02d:%02d", ((lround(remaining) / 60) % 60), lround(remaining) % 60)
    }
    
    @IBAction func sliderBtnAction(_ sender: AnyObject) {
        player.currentTime = TimeInterval(sliderControl.value)

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

