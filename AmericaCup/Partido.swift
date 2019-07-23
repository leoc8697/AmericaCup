//
//  Partido.swift
//  AmericaCup
//
//  Created by Herman on 7/22/19.
//  Copyright © 2019 David Leon. All rights reserved.
//

import Foundation
import UIKit
internal struct estructura {
    static let team1 = "team1"
    static let team2 = "team2"
    static let dateMatch = "dateMatch"
    static let score = "score"
    static let flagTeam1 = "flagTeam1"
    static let flagTeam2 = "flagTeam2"
}

struct Partido{
    var team1:String
    var team2:String
    var score:String
    var dateMatch:String
    var flagTeam1:UIImage
    var flagTeam2:UIImage
    var urlFlagTeam1:String?
    var urlFlagTeam2:String?
    
    
    init(team1:String,team2:String,score:String,
         dateMatch:String,flagTeam1:UIImage?,flagTeam2:UIImage?,
         urlFlagTeam1:String?, urlFlagTeam2:String?) {
        self.team1 = team1
        self.team2 = team2
        self.score = score
        self.dateMatch = dateMatch
        self.flagTeam1 = flagTeam1!
        self.flagTeam2 = flagTeam2!
        self.urlFlagTeam1 = urlFlagTeam1
        self.urlFlagTeam2 = urlFlagTeam2
    }
    
    
    init(json: [String:Any],urlJson:String){
        self.team1 = json["team1"] as? String ?? "Equipo 1"
        self.team2 = json["team2"] as? String ?? "Equipo 2"
        self.score = json["score"] as? String ?? "Resultado"
        self.dateMatch = json["dateMatch"] as? String ?? "Fecha"
        self.flagTeam1 = UIImage(imageLiteralResourceName: "imgDefault")
        self.flagTeam2 = UIImage(imageLiteralResourceName: "imgDefault")
        self.urlFlagTeam1 = json["flagTeam1"] as? String ?? "www"
        self.urlFlagTeam2 = json["flagTeam2"] as? String ?? "www"
}
}
