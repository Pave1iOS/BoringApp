//
//  Boring.swift
//  BoringApp
//
//  Created by Pavel Gribachev on 30.01.2024.
//

import Foundation

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
    
    init(activity: String, type: String, participants: Int, accessibility: Double) {
        self.activity = activity
        self.type = type
        self.participants = participants
        self.accessibility = accessibility
    }
    
    init(boring: [String: Any]) {
        activity = boring["activity"] as? String ?? ""
        type = boring["type"] as? String ?? ""
        participants = boring["participants"] as? Int ?? 0
        accessibility = boring["accessibility"] as? Double ?? 0
    }
    
    static func getBoring(from value: Any) -> Boring {
        guard let boringActivity = value as? [String: Any] else {
            return Boring(
                activity: "NoDATA",
                type: "NoData",
                participants: 100,
                accessibility: 100
            )
        }
        return Boring(boring: boringActivity)
    }
}
