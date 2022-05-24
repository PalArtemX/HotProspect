//
//  ProspectViewModel.swift
//  HotProspect
//
//  Created by Artem Paliutin on 24/05/2022.
//

import Foundation


@MainActor class ProspectViewModel: ObservableObject {
    @Published var people: [Prospect]
    
    init() {
        people = []
    }
    
    
    func addProspect() {
        var prospect = Prospect()
        prospect.name = "Artem"
        prospect.emailAddress = "qq@ff.ru"
        people.append(prospect)
    }
}
