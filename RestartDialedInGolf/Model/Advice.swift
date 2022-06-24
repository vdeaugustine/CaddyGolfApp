//
//  Advice.swift
//  RestartDialedInGolf
//
//  Created by Vincent DeAugustine on 6/23/22.
//

import Foundation

struct Advice: Codable {
    var closestClub: Club
    var secondClosestClub: Club
    var typeOfShot: TypeOfShot
    var targetDistance: Int?
    var realDistance: Int?

    static func getAdvice(details: DetailsForAdvice, modelData: ModelData) -> Advice? {
        let targetDistance: Int
        guard let distanceToPin = Int(details.distanceToPin) else { return nil }
        switch details.flagColorChosen {
        case .red:
            targetDistance = distanceToPin + 5
        case .white:
            targetDistance = distanceToPin
        case .blue:
            targetDistance = distanceToPin - 5
        }

        let sortedClubs = modelData.bag.clubsArray
        guard sortedClubs.isEmpty == false else { return nil }
        var closestClub = sortedClubs[0]
        var secondClosestClub = sortedClubs[0]

        for thisClub in sortedClubs {
            let newClubGap = abs(thisClub.getDistance() - targetDistance)
            let closestClubGap = abs(closestClub.getDistance() - targetDistance)
            let secondClosestClubGap = abs(secondClosestClub.getDistance() - targetDistance)

            if newClubGap < closestClubGap {
                secondClosestClub = closestClub
                closestClub = thisClub
            } else if newClubGap < secondClosestClubGap {
                secondClosestClub = thisClub
            }
        }
        return Advice(closestClub: closestClub, secondClosestClub: secondClosestClub, typeOfShot: details.typeOfShot, targetDistance: targetDistance, realDistance: Int(distanceToPin))
    }
}


class DetailsForAdvice: ObservableObject {
    @Published var distanceToPin: String = ""
    @Published var typeOfShot: TypeOfShot = .teeshot
    @Published var ballPosition: BallPositions = .flat
    @Published var distanceFocused: Bool = false
    @Published var flagColorChosen: FlagColors = .white
}
