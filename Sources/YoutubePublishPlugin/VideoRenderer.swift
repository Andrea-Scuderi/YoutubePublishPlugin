//
//  YoutubeRenderer.swift
//  
//
//  Created by tanabe.nobuyuki on 2020/12/07.
//

public protocol VideoRenderer {
    var config: VideoEmbedConfiguration { get }
    func render(video: EmbeddedVideo) throws -> String
}

public final class DefaultVideoRenderer: VideoRenderer{
    public var config: VideoEmbedConfiguration
    public init(config: VideoEmbedConfiguration) {
        self.config = config
    }
    public func render(video: EmbeddedVideo) throws -> String { video.html }
}


public enum VideoPortal {
    case youtube
    case ted
    
    var baseURL : String {
        switch self{
            case .ted: return "https://embed.ted.com"
            case .youtube: return "https://www.youtube.com/embed/"
        }
    }
}

func html(portal: VideoPortal, from address: String, width: Int?, height: Int?, className: String) -> String {
    if let width, let height {
        return "<div class=\"\(className)\"><iframe width=\"\(width)\" height=\"\(height)\" src=\"\(portal.baseURL)\(address)\" frameborder=\"0\" allow=\"accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture\" allowfullscreen></iframe></div>"

    }
    return "<div class=\"\(className)\"><iframe class=\"\(className)\" src=\"\(portal.baseURL)\(address)\" frameborder=\"0\" allow=\"accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture\" allowfullscreen></iframe></div>"
}
