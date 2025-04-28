//
//  Recording.swift
//  Voice Notes 2
//
//  Created by Sathyanarayana on 4/20/25.
//


import Foundation

struct Recording {
    let url: URL
    let date: Date
    var customName: String
    var isPlaying: Bool = false
    var isPaused: Bool = false
    var isFavorite: Bool = false
}
