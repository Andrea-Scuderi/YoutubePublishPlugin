//
//  TedPublishPlugin.swift
//  
//
//  Created by Klaus Kneupner on 02/08/2023.
//

import Foundation
import Publish
import Ink


public extension Plugin {
    static func tedTalks(renderer: VideoRenderer = DefaultVideoRenderer(config: .default)) -> Self {
        Plugin(name: "Ted Video Plugin") { context in
            context.markdownParser.addModifier(.tedTalksBlockQuote(using: renderer, configuration: renderer.config))
        }
    }
}

public extension Modifier {
    static func tedTalksBlockQuote(using renderer: VideoRenderer, configuration: VideoEmbedConfiguration) -> Self {
        return Modifier(target: .blockquotes) { html, markdown in
            let prefix = "tedtalk "
            var markdown = markdown.dropFirst().trimmingCharacters(in: .whitespaces)
            guard markdown.hasPrefix(prefix) else {
                return html
            }
            
            markdown = markdown.dropFirst(prefix.count).trimmingCharacters(in: .newlines)
            
            guard let url = URL(string: markdown) else {
                fatalError("Invalid video URL \(markdown)")
            }
            
            let generator = TedTalkEmbedGenerator(url: url, configuration: configuration)
            let video = try! generator.generate().get()
            return try! renderer.render(video: video)
        }
    }
}

