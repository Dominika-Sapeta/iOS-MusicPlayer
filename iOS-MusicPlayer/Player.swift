//
//  Player.swift
//  iOS-MusicPlayer
//
//  Created by Dominika on 7/11/17.
//  Copyright © 2017 Dominika. All rights reserved.
//

import UIKit
import AVFoundation

class Player: UIViewController, AVAudioPlayerDelegate {

    @IBOutlet var image: UIImageView!
    @IBOutlet var songTitle: UILabel!
    @IBOutlet var songArtist: UILabel!
    @IBOutlet var playPause: UIButton!
    @IBOutlet var stop: UIButton!
    @IBOutlet var volumeLabe: UILabel!
    @IBOutlet var volume: UISlider!
    @IBOutlet var time: UISlider!
    @IBOutlet var timeElapsed: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var imageName = ""
        var titleName = ""
        var artistName = ""
        var index = 0
        var delegate = UIApplication.shared.delegate as! AppDelegate
        var player:AVAudioPlayer!
        
        override func viewDidLoad() {
            super.viewDidLoad()
            player = delegate.audioPlayer
            image.image = UIImage(named:imageName)
            songTitle.text = titleName
            songArtist.text = artistName
            playPause.setImage(UIImage(named: "pause"), for: UIControlState.normal)
            
            Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(trackAudioTime), userInfo: nil, repeats: true)
            time.value = 0
            time.minimumValue = 0
            
            volume.minimumValue = 0
            volume.maximumValue = 1

            
        }
        
        func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
        
       @IBAction func goBackAction(sender:UIButton){
            player = delegate.audioPlayer
            player.stop()
            self.performSegue(withIdentifier: "return", sender: self)
        }
        
        
        @IBAction func stop(sender: UIButton) {
            player = delegate.audioPlayer
            if(player.isPlaying){
                player.stop()
                player.currentTime = 0
                stop.isEnabled = false
              //  playPause.setImage(UIImage(named: "play"), for: UIControlState.normal)
            }
            else{
                player.currentTime = 0
                stop.isEnabled = false
            }
        }
        
        
        @IBAction func playPause(sender: UIButton) {
            player = delegate.audioPlayer
            if(player.isPlaying){
                player.pause()
             //   playPause.setImage(UIImage(named: "play"), for: UIControlState.normal)
            }
            else{
              //  playPause.setImage(UIImage(named: "pause"), for: UIControlState.normal)
                player.play()
                stop.isEnabled = true
            }
        }
        
        func slideTime(slider: UISlider) {
            player = delegate.audioPlayer
            player.currentTime = TimeInterval(slider.value)
        }
        
        func changeVolume(slider: UISlider) {
            player = delegate.audioPlayer
            player.volume = volume.value
            volumeLabe.text = "Volume " + String(Int(player.volume*100))
        }
        
        
        func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag:Bool) {
            playPause.isSelected = false
            let alertMessage = UIAlertController(title: "Finish Playing", message:"Finish playing the recording!", preferredStyle: .alert)
            alertMessage.addAction(UIAlertAction(title: "OK", style: .default, handler:nil))
            present(alertMessage, animated: true, completion: nil)
        }
        
        func trackAudioTime() {
            player = delegate.audioPlayer
            time.maximumValue = Float(player.duration)
            time.value=Float(player.currentTime)
            
            let seconds = Int(player.currentTime)
            let minutes = Int(seconds/60)
            let del = minutes*60
            
            if(seconds-del<10){
                timeElapsed.text = String(minutes) + ":0" + String(seconds-del)
            }
            else{
                timeElapsed.text = String(minutes) + ":" + String(seconds-del)
            }
            
        }
        
}
