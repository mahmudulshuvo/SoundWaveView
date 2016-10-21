//
//  ViewController.swift
//  WaveFormDemo
//
//  Created by SHUVO on 10/19/16.
//  Copyright © 2016 SHUVO. All rights reserved.
//

import UIKit
import AVFoundation
import Foundation

class ViewController: UIViewController {
    
    var player:AVAudioPlayer = AVAudioPlayer()
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var playPauseBtn: UIButton!
    @IBOutlet weak var sliderControl: UISlider!
    var remaining: Double = 0.0
    
    fileprivate var startRendering = Date()
    fileprivate var endRendering = Date()
    fileprivate var startLoading = Date()
    fileprivate var endLoading = Date()
    fileprivate var profileResult = ""

    @IBOutlet weak var loadBtn: UIButton!
    @IBOutlet weak var wavefom: FDWaveformView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        super.viewDidLoad()
        let thisBundle = Bundle(for: type(of: self))
        let url = thisBundle.url(forResource: "Submarine", withExtension: "aiff")
        // Animate the waveforme view in when it is rendered
        self.wavefom.delegate = self
        self.wavefom.alpha = 0.0
        self.wavefom.audioURL = url
        print("audio url \(self.wavefom.audioURL)")
        self.wavefom.progressSamples = 0
    }
    
    @IBAction func loadMP3(_ sender: AnyObject) {
        
        loadBtn.setTitle("Loading", for: UIControlState.normal)
        let thisBundle = Bundle(for: type(of: self))
        let url = thisBundle.url(forResource: "whistle", withExtension: "mp3")
        self.wavefom.audioURL = url
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


extension ViewController: FDWaveformViewDelegate {
    func waveformViewWillRender(_ waveformView: FDWaveformView) {
        self.startRendering = Date()
    }
    
    func waveformViewDidRender(_ waveformView: FDWaveformView) {
        self.endRendering = Date()
        NSLog("FDWaveformView rendering done, took %f seconds", self.endRendering.timeIntervalSince(self.startRendering))
        loadBtn.setTitle("Done!", for: UIControlState.normal)
        UIButton.animate(withDuration: 2.0, animations: {() -> Void in
            self.loadBtn.setTitle("Load MP3", for: UIControlState.normal)
        })
        self.profileResult.append(" render \(self.endRendering.timeIntervalSince(self.startRendering))")
        UIView.animate(withDuration: 0.25, animations: {() -> Void in
            waveformView.alpha = 1.0
        })
    }
    
    func waveformViewWillLoad(_ waveformView: FDWaveformView) {
        self.startLoading = Date()
    }
    
    func waveformViewDidLoad(_ waveformView: FDWaveformView) {
        self.endLoading = Date()
        NSLog("FDWaveformView loading done, took %f seconds", self.endLoading.timeIntervalSince(self.startLoading))
        self.profileResult.append(" load \(self.endLoading.timeIntervalSince(self.startLoading))")
    }
}

