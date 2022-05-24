//
//  MeView.swift
//  HotProspect
//
//  Created by Artem Paliutin on 24/05/2022.
//


import SwiftUI

struct MeView: View {
    @State private var name = "Anonymous"
    @State private var emailAddress = "you@yoursite.com"
    @EnvironmentObject var vm: ProspectViewModel
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                    .textContentType(.name)
                    .font(.title2)
                
                TextField("Email address", text: $emailAddress)
                    .textContentType(.emailAddress)
                    .font(.title2)
                
                Image(uiImage: vm.generateQRCode(from: "\(name)\n\(emailAddress)"))
                    .resizable()
                    .interpolation(.none)
                    .scaledToFit()
            }
            .navigationTitle("Your code")
        }
    }
}










struct MeView_Previews: PreviewProvider {
    static var previews: some View {
        MeView()
            .environmentObject(ProspectViewModel())
    }
}
