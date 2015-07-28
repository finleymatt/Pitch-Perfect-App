import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!
    
    var audioPlayer:AVAudioPlayer!
    var audioPlayer_echo:AVAudioPlayer!
    var receivedAudio: RecordedAudio!

    @IBOutlet weak var stopAudio: UIButton!
    @IBOutlet weak var echoLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
        audioPlayer.enableRate = true
        
        audioPlayer_echo = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)

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
    
    @IBAction func playEchoAudio(sender: UIButton) {
        echoLabel.hidden = false
        audioPlayer.stop()
        audioPlayer.currentTime = 0;
        audioPlayer.play()
        
        let delay:NSTimeInterval = 0.1//100ms
        var playtime:NSTimeInterval
        playtime = audioPlayer_echo.deviceCurrentTime + delay
        
        audioPlayer_echo.stop()
        audioPlayer_echo.currentTime = 0
        audioPlayer_echo.volume = 0.8;
        audioPlayer_echo.playAtTime(playtime)
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
}
