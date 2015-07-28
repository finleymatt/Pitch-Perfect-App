//
//  PlaySoundsViewController.swift
//  Pitch Perfect Portfolio
//
//  Created by Matt Finley on 7/18/15.
//  Copyright (c) 2015 Matt Finley. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!
    
    var audioPlayer:AVAudioPlayer!
    var receivedAudio: RecordedAudio!

    @IBOutlet weak var stopAudio: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
        audioPlayer.enableRate = true

        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(animated: Bool) {
        stopAudio.hidden = true
    }
    
    func playAudio() {
        stopAudio.hidden = false
        audioPlayer.stop()
        audioPlayer.currentTime = 0.0
        audioPlayer.play()
    }
    
    func stop_reset_audioEngine() {
        audioEngine.stop()
        audioEngine.reset()
    }
    
    @IBAction func playSlowAudio(sender: UIButton) {
        stop_reset_audioEngine()
        audioPlayer.rate = 0.5
        playAudio()
    }
    
    @IBAction func playFastAudio(sender: UIButton) {
        stop_reset_audioEngine()
        audioPlayer.rate = 2.0
        playAudio()
    }
    
    @IBAction func stopAudio(sender: UIButton) {
        audioPlayer.stop()
    }
    

    @IBAction func playChipmunkAudio(sender: UIButton) {
        stopAudio.hidden = false
        playAudioWithVariablePitch(2000)
    }
    
    @IBAction func playDarthVaderAudio(sender: UIButton) {
        stopAudio.hidden = false
        playAudioWithVariablePitch(-1000)
    }
    
    func playAudioWithVariablePitch(pitch: Float){
        audioPlayer.stop()
        stop_reset_audioEngine()
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        
        audioPlayerNode.play()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
