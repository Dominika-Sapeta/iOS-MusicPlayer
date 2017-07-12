//
//  pageSwiper.swift
//  iOS-MusicPlayer
//
//  Created by Dominika on 7/12/17.
//  Copyright © 2017 Dominika. All rights reserved.
//

import UIKit
import AVFoundation


class pageSwiper: UIPageViewController,UIPageViewControllerDelegate, UIPageViewControllerDataSource, AVAudioPlayerDelegate  {
    
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

        // Do any additional setup after loading the view.
        
        dataSource = self
        delegate = self
        self.automaticallyAdjustsScrollViewInsets=false
        
        //INITIATE DETAIL VIEW - MUSIC PLAYER
        if let startingViewController = musicView(at:index){
            setViewControllers([startingViewController], direction: .forward, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
