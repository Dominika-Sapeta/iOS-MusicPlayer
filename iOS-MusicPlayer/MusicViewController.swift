//
//  MusicViewController.swift
//  iOS-MusicPlayer
//
//  Created by Dominika on 7/12/17.
//  Copyright © 2017 Dominika. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

private var songSet:[Song] = [Song(title: "Rhapsody In Blue", artist: "Gershwin", image: "song_image_1.jpg", song: "song_1.mp3"),
                              Song(title: "The birth of soul", artist: "Ray Charles", image: "song_image_2.jpg", song: "song_4.mp3"),
                              Song(title: "Afro Blue Impressions", artist: "John Coltrane", image: "song_image_3.jpg", song: "song_7.mp3"),
                              Song(title: "Jazz Mood", artist: "Chet Baker", image: "song_image_4.jpg", song: "song_5.mp3"),
                              Song(title: "I put spell on you", artist: "Nina Simone", image: "song_image_5.jpg", song: "song_10.mp3"),
                              Song(title: "Motions & Emotions", artist: "Oscar Peterson", image: "song_image_6.jpg", song: "song_2.mp3"),
                              Song(title: "Emotions", artist: "Ariana Grande", image: "song_image_7.jpg", song: "song_0.mp3"),
                              Song(title: "Take five", artist: "Dave Burbeck", image: "song_image_8.jpg", song: "song_8.mp3"),
                              Song(title: "Total Eclipse", artist: "Bonnie Tyler", image: "song_image_9.jpg", song: "song_11.mp3"),
                              Song(title: "True Colors", artist: "Cindy Lauper", image: "song_image_10.jpg", song: "song_6.mp3"),
                              Song(title: "Booty Swing", artist: "Parov Stelar", image: "song_image_11.jpg", song: "song_9.mp3"),
                              Song(title: "I'll survive", artist: "Gloria Gaynor", image: "song_image_12.jpg", song: "song_3.mp3"),]

class MusicViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout{
    
    @IBAction func gridUnwind(segue :UIStoryboardSegue) {
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return songSet.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! Cell
        let song = songSet[indexPath.row]
        cell.imageView?.image = UIImage(named: song.image)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        var collectionViewSize = collectionView.frame.size
        collectionViewSize.width = collectionViewSize.width/2.0
        let topBarSize = UIApplication.shared.statusBarFrame.height
        collectionViewSize.height = (collectionViewSize.height-topBarSize)/4.0
        return collectionViewSize
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier=="playMusic"{
            
            if let indexPaths=collectionView?.indexPathsForSelectedItems{
                let destinationController = segue.destination as! PageController
                destinationController.index = indexPaths[0].row
                destinationController.songSet = songSet
                collectionView?.deselectItem(at: indexPaths[0], animated: false)
            }
        }
    }
}

