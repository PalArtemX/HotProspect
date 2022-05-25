//
//  Prospect.swift
//  HotProspect
//
//  Created by Artem Paliutin on 24/05/2022.
//

import Foundation


class Prospect: Identifiable, Codable {
    var id = UUID()
    var name = "Anonymus"
    var emailAddress = ""
    var isContacted = false
}
