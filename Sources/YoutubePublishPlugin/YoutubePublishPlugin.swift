//
//  YoutubePublishPlugin.swift
//
//
//  Created by tanabe.nobuyuki on 2020/12/07.
//

import Foundation
import Publish
import Ink


public extension Plugin {
    static func youtube(renderer: VideoRenderer = DefaultVideoRenderer(config: .default)) -> Self {
        Plugin(name: "Youtube") { context in
            context.markdownParser.addModifier(.youtubeBlockQuote(using: renderer, configuration: renderer.config))
        }
    }
}

public extension Modifier {
    static func youtubeBlockQuote(using renderer: VideoRenderer, configuration: VideoEmbedConfiguration) -> Self {
        return Modifier(target: .blockquotes) { html, markdown in
            let prefix = "youtube "
            var markdown = markdown.dropFirst().trimmingCharacters(in: .whitespaces)
            guard markdown.hasPrefix(prefix) else {
                return html
            }
            
            markdown = markdown.dropFirst(prefix.count).trimmingCharacters(in: .newlines)
            
            guard let url = URL(string: markdown) else {
                fatalError("Invalid video URL \(markdown)")
            }
            
            let generator = YoutubeEmbedGenerator(url: url, configuration: configuration)
            let youtube = try! generator.generate().get()
            return try! renderer.render(video: youtube)
        }
    }
}

