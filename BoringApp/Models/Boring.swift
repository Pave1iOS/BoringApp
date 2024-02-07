//
//  Boring.swift
//  BoringApp
//
//  Created by Pavel Gribachev on 30.01.2024.
//

import Foundation

enum BackgraundColors: String, CaseIterable {
    case blue = "blue"
    case green = "green"
    case mate = "mate"
    case orange = "orange"
    case purple = "purple"
    case red = "red"
    case white = "white"
    case yellow = "yellow"
    
    var hex: String {
        switch self {
        case .blue:
            "3E85C7"
        case .green:
            "56B55F"
        case .mate:
            "00CFC3"
        case .orange:
            "FC9143"
        case .purple:
            "7C47BE"
        case .red:
            "DB3838"
        case .white:
            "FFFFFF"
        case .yellow:
            "EBD937"
        }
    }
}

enum Link {
    case boredURL
    case activityTypeURL
    
    var url: String {
        switch self {
        case .boredURL:
            return "https://www.boredapi.com/api/activity/"
        case .activityTypeURL:
            return "https://www.boredapi.com/api/activity?type="
        }
    }
}

enum TypeActivity: String, CaseIterable {
    case allTypes = "allTypes"
    case education = "education"
    case recreational = "recreational"
    case social = "social"
    case diy = "diy"
    case charity = "charity"
    case cooking = "cooking"
    case relaxation = "relaxation"
    case music = "music"
    case busywork = "busywork"
}

struct Boring: Decodable {
    let activity: String
    let type: String
    let participants: Int
    let accessibility: Double
    
    var description: String {
        """
        participants: \(participants)
        accessibility: \(accessibility)
        """
    }
    
    var descriptionTranscript: String {
        """
        participants: the number of people you need to complete the task
        
        accessibility: how difficult will it be to complete the task.
        where 0.0 is easy and 1.00 is hard
        """
    }
}
