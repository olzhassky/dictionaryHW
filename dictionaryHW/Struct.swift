//
//  Struct.swift
//  dictionaryHW
//
//  Created by Olzhas Zhakan on 18.08.2023.
//

import Foundation

// MARK: - Welcome
struct Welcome: Codable {
    let head: Head
    let def: [Def]
}

// MARK: - Def
struct Def: Codable {
    let text, pos: String
    let ts: String?
    
    let tr: [Tr]
}

// MARK: - Tr
struct Tr: Codable {
    let text, pos: String
    let gen: String?
    let fr: Int
    let syn: [Syn]?
    let mean: [Mean]?
    let asp: String?
}

// MARK: - Mean
struct Mean: Codable {
    let text: String
}

// MARK: - Syn
struct Syn: Codable {
    let text, pos: String
    let gen: String?
    let fr: Int
    let asp: String?
}

// MARK: - Head
struct Head: Codable {
}
