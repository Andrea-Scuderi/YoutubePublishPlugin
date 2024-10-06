//
//  YoutubeEmbedConfiguration.swift
//  
//
//  Created by tanabe.nobuyuki on 2020/12/07.
//

import Foundation
public struct VideoEmbedConfiguration  {
    var width: Int?
    var height: Int?
    var className: String = "embeddedVideo"
    
    init(width: Int = 560, height: Int = 315) {
        self.width = width
        self.height = height
    }
    
    public static var `default`: VideoEmbedConfiguration { VideoEmbedConfiguration() }
}
