//
//  RecordedAudio.swift
//  Pitch Perfect Portfolio
//
//  Created by Matt Finley on 7/18/15.
//  Copyright (c) 2015 Matt Finley. All rights reserved.
//

import Foundation




class RecordedAudio: NSObject{
    
    var filePathUrl: NSURL!
    var title: String!
    
    init (filePathUrl: NSURL!, title: String!){
        
        self.filePathUrl = filePathUrl
        self.title = title
        
    }
    
    
    
}
