//
//  WaveformView.swift
//  WaveFormDemo
//
//  Created by Mahmudul Hassan on 10/20/16.
//  Copyright © 2016 SHUVO. All rights reserved.
//


import  UIKit
import AVFoundation

class WaveformView: UIImageView {
    
    
     func initWithUrl(url: NSURL) {
      //  super.init()
        
        let urlA = AVAsset(url : url as URL)
       // self.image = UIImage(data: self.renderPNGAudioPictogramLog(forAssett: urlA as! AVURLAsset))!
        
    }
    
    func audioImageLogGraph(samples: Float32, normalizeMax: Float32, sampleCount: Int, channelCount: Int, imageHeight: Float) -> UIImage {
        var sample:Float32 = samples
        let imageSize = CGSize(width: sampleCount, height: Int(imageHeight))
        UIGraphicsBeginImageContext(imageSize)
        let context = UIGraphicsGetCurrentContext()!
        context.setFillColor(UIColor.black.cgColor)
        context.setAlpha(1.0)
        var rect: CGRect = CGRect(x: 0, y: 0, width: 0, height: 0)
        rect.size = imageSize
        rect.origin.x = 0
        rect.origin.y = 0
        let leftcolor = UIColor.white.cgColor
        let rightcolor = UIColor.red.cgColor
        context.fill(rect)
        context.setLineWidth(1.0)
        let halfGraphHeight: Float = (imageHeight / 2) / Float(channelCount)
        let centerLeft: Float = halfGraphHeight
        let centerRight: Float = (halfGraphHeight * 3)
        let sampleAdjustmentFactor: Float = (imageHeight / Float(channelCount)) / (normalizeMax - noiseFloor) / 2
        for intSample in 0..<sampleCount {
            sample += 1
            let left = sample
            let pixels: Float = (left - noiseFloor) * sampleAdjustmentFactor
            context.move(to: CGPoint(x: intSample, y: Int(centerLeft - pixels)))
            context.addLine(to: CGPoint(x: intSample, y: Int(centerLeft + pixels)))
            context.setStrokeColor(leftcolor)
            context.strokePath()
            if channelCount == 2 {
                 sample += 1
                let right = sample
                let pixels: Float = (right - noiseFloor) * sampleAdjustmentFactor
                context.move(to: CGPoint(x: intSample, y: Int(centerRight - pixels)))
                context.addLine(to: CGPoint(x: intSample, y: Int(centerRight + pixels)))
                context.setStrokeColor(rightcolor)
                context.strokePath()
            }
        }
        // Create new image
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        // Tidy up
        UIGraphicsEndImageContext()
        return newImage!
    }

    
    func absX(x: Float32) -> Float32 {
        if (x<0) {
            return (0-x)
        }
        else {
            return x
        }
    }
    
    func minMaxX(x: Float32, mn: Float32, mx: Float32) -> Float32 {
        if (x <= mn) {
            return mn
        }
        
        else {
            if (x >= mn) {
                return mx
            }
            else {
                return x
            }
        }
    }
    
    let noiseFloor: Float = -50.0
    
    func decibel(amplitude: Float32) -> Float32 {
        
        return (20.0 * log10(absX(x: amplitude)/32767.0))
    }
    
    let imgExt: String = "png"
    
    func imageToData(x: UIImage) -> Data {
        
        return UIImagePNGRepresentation(x)!

    }
    
}
