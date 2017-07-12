//
//  PageController.swift
//  iOS-MusicPlayer
//
//  Created by Dominika on 7/12/17.
//  Copyright © 2017 Dominika. All rights reserved.
//

import UIKit
import AVFoundation


class PageController: UIPageViewController, UIPageViewControllerDelegate, AVAudioPlayerDelegate {
    
    var index = 0
    var songSet:[Song] = []
    var songName:String!
    var path:String!
    var audioFileURL:URL!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var currentIndex = 0
    var nextIndex = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        dataSource = self as? UIPageViewControllerDataSource
        delegate = self
        self.automaticallyAdjustsScrollViewInsets=false
        
        if let startingViewController = playerView(at:index){
            setViewControllers([startingViewController], direction: .forward, animated: true, completion: nil)
        }
        
        print(index)
        songName = songSet[index].song
        path = Bundle.main.path(forResource: songName, ofType: nil)!
        audioFileURL = URL(fileURLWithPath: path)
        
        do {
            appDelegate.audioPlayer = try AVAudioPlayer(contentsOf: audioFileURL)
            appDelegate.audioPlayer.prepareToPlay()
            appDelegate.audioPlayer.play()
        }
        catch {
            print(error)
        }
    }
    
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers:[UIViewController], transitionCompleted completed: Bool) {
        
        if finished && completed{
            appDelegate.audioPlayer.stop()
            songName = songSet[nextIndex].song
            path = Bundle.main.path(forResource: songName, ofType:nil)!
            audioFileURL = URL(fileURLWithPath: path)
            
            do {
                appDelegate.audioPlayer = try AVAudioPlayer(contentsOf: audioFileURL)
                appDelegate.audioPlayer.prepareToPlay()
                appDelegate.audioPlayer.setVolume(0.1, fadeDuration: 0)
                appDelegate.audioPlayer.play()
            }
            catch {
                print(error)
            }
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        
        if let itemController = pendingViewControllers[0] as? PlayerViewController {
            nextIndex = itemController.index
            print("Page index = \(nextIndex)")
        }
    }

    func playerView(at index:Int) -> PlayerViewController?{
        if index<0||index>=12{
            return nil
        }
        
        if let mPlayer = storyboard?.instantiateViewController(withIdentifier: "Player") as? PlayerViewController{
            mPlayer.imageName = songSet[index].image
            mPlayer.titleName = songSet[index].title
            mPlayer.artistName = songSet[index].artist
            mPlayer.index=index
            return mPlayer
        }
        return nil
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
