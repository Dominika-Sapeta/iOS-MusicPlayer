//
//  Song.swift
//  iOS-MusicPlayer
//
//  Created by Dominika on 7/11/17.
//  Copyright © 2017 Dominika. All rights reserved.
//

import Foundation


struct Song {
    
    var title: String = ""
    var artist: String = ""
    var image: String = ""
    var song: String = ""
    
    init(title:String, artist:String, image:String, song:String){
        self.title = title
        self.artist = artist
        self.image = image
        self.song = song
    }
    
}
