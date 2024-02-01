//
//  Boring.swift
//  BoringApp
//
//  Created by Pavel Gribachev on 30.01.2024.
//

struct Boring: Decodable {
    let activity: String
    let type: String
    let participants: Int
    let accessibility: Double
    
    var description: String {
        """
        type: \(type)
        participants: \(participants)
        accessibility: \(String(format: "%.02f", accessibility))
        """
    }
}
