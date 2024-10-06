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
    var className: String
    
    public init(width: Int? = 560, height: Int? = 315, className: String = "embeddedVideo") {
        self.width = width
        self.height = height
        self.className = className
    }
    
    public static var `default`: VideoEmbedConfiguration { VideoEmbedConfiguration() }
}
