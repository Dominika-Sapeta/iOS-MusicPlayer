//
//  PlayerViewController.swift
//  iOS-MusicPlayer
//
//  Created by Dominika on 7/12/17.
//  Copyright © 2017 Dominika. All rights reserved.
//

import UIKit
import AVFoundation

class PlayerViewController: UIViewController, AVAudioPlayerDelegate {
    
    
    @IBOutlet var image: UIImageView!
    @IBOutlet var songTitle: UILabel!
    @IBOutlet var songArtist: UILabel!
    @IBOutlet var eTime: UILabel!
    @IBOutlet var time: UISlider!
    @IBOutlet var stop: UIButton!
    @IBOutlet var play: UIButton!
    @IBOutlet var volumeLabel: UILabel!
    @IBOutlet var volume: UISlider!
    @IBOutlet var back: UIButton!
    
    var imageName = ""
    var titleName = ""
    var artistName = ""
    var index = 0
    var delegate = UIApplication.shared.delegate as! AppDelegate
    var player:AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        player = delegate.audioPlayer
        image.image = UIImage(named:imageName)
        songTitle.text = titleName
        songArtist.text = artistName
        
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(trackAudioTime), userInfo: nil, repeats: true)
        time.value = 0
        time.minimumValue = 0
        
        volume.minimumValue = 0
        volume.maximumValue = 1
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backToCol(_ sender: UIButton) {
        player = delegate.audioPlayer
        player.stop()
        self.performSegue(withIdentifier: "return", sender: self)
    }
    
    
    @IBAction func stop(_ sender: UIButton) {
        player = delegate.audioPlayer
        if(player.isPlaying){
            player.stop()
            player.currentTime = 0
            stop.isEnabled = false
        }
        else{
            player.currentTime = 0
            stop.isEnabled = false
        }
    }
    
    
    
    @IBAction func play(_ sender: UIButton) {
        player = delegate.audioPlayer
        if(player.isPlaying){
            player.pause()
        }
        else{
            player.play()
            stop.isEnabled = true
        }
    }
    
    @IBAction func volumeChange(_ slider: UISlider) {
        player = delegate.audioPlayer
        player.volume = volume.value
        volumeLabel.text = "Volume: " + String(Int(player.volume*100))
    }
    

    
    @IBAction func timeProgress(_ slider: UISlider) {
        player = delegate.audioPlayer
        player.currentTime = TimeInterval(slider.value)
    }
    
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag:Bool) {
        play.isSelected = false
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
            eTime.text = String(minutes) + ":0" + String(seconds-del)
        }
        else{
            eTime.text = String(minutes) + ":" + String(seconds-del)
        }
        
    }

}
