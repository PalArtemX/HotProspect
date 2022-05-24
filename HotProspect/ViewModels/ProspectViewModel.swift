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
    
    
    init() {
        people = []
    }
    
    // MARK: - Functions
    
    
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
            
            var person = Prospect()
            person.name = details[0]
            person.emailAddress = details[1]
            people.append(person)
            
        case .failure(let error):
            print("Scanning failed: \(error.localizedDescription)")
        }
    }
}
