//
//  ProspectViewModel.swift
//  HotProspect
//
//  Created by Artem Paliutin on 24/05/2022.
//

import CodeScanner
import CoreImage
import CoreImage.CIFilterBuiltins
import Foundation
import UIKit


class ProspectViewModel: ObservableObject {
    @Published var people: [Prospect]
    @Published var isShowingScanner = false
    
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    let saveKey = "SavedData"
    
    // MARK: - init
    init() {
        if let data = UserDefaults.standard.data(forKey: saveKey) {
            if let decoded = try? JSONDecoder().decode([Prospect].self, from: data) {
                people = decoded
                return
            }
        }
        people = []
    }
    
    // MARK: - Functions
    func add(_ prospect: Prospect) {
        people.append(prospect)
        save()
    }
    
    private func save() {
        if let encoded = try? JSONEncoder().encode(people) {
            UserDefaults.standard.set(encoded, forKey: saveKey)
        }
    }
    
    func toggle(_ prospect: Prospect) {
        objectWillChange.send()
        prospect.isContacted.toggle()
        save()
    }
    
    func generateQRCode(from string: String) -> UIImage {
        filter.message = Data(string.utf8)
        
        if let outputImage = filter.outputImage {
            if let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
                return UIImage(cgImage: cgImage)
            }
        }
        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
    
    func handleScan(result: Result<ScanResult, ScanError>) {
        isShowingScanner = false
        
        switch result {
        case .success(let result):
            let details = result.string.components(separatedBy: "\n")
            guard details.count == 2 else { return }
            
            let person = Prospect()
            person.name = details[0]
            person.emailAddress = details[1]
            add(person)
        case .failure(let error):
            print("Scanning failed: \(error.localizedDescription)")
        }
    }

}
