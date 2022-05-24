//
//  ProspectsView.swift
//  HotProspect
//
//  Created by Artem Paliutin on 24/05/2022.
//

import CodeScanner
import SwiftUI

struct ProspectsView: View {
    @EnvironmentObject var vm: ProspectViewModel
    
    let filter: FilterType
    var title: String {
        switch filter {
        case .none:
            return "Everyone"
        case .contacted:
            return "Contacted people"
        case .unContacted:
            return "Uncontacted people"
        }
    }
    var filteredProspects: [Prospect] {
        switch filter {
        case .none:
            return vm.people
        case .contacted:
            return vm.people.filter { $0.isContacted }
        case .unContacted:
            return vm.people.filter { !$0.isContacted }
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(filteredProspects) { prospect in
                    VStack(alignment: .leading) {
                        Text(prospect.name)
                            .font(.headline)
                        Text(prospect.emailAddress)
                            .foregroundColor(.secondary)
                    }
                }
            }
            
            
            .navigationTitle(title)
            .toolbar {
                Button {
                    vm.isShowingScanner = true
                } label: {
                    Label("Scan", systemImage: "qrcode.viewfinder")
                }
                
            }
            .sheet(isPresented: $vm.isShowingScanner) {
                CodeScannerView(codeTypes: [.qr], simulatedData: "Artem\nart@swift.com", completion: vm.handleScan)
            }
        }
    }
}










struct ProspectsView_Previews: PreviewProvider {
    static var previews: some View {
        ProspectsView(filter: .none)
            .environmentObject(ProspectViewModel())
    }
}
