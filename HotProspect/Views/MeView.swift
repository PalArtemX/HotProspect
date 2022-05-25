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
                
                Image(uiImage: vm.qrCode)
                    .resizable()
                    .interpolation(.none)
                    .scaledToFit()
                    .contextMenu {
                        Button {
                            vm.imageSaver(name: name, emailAddress: emailAddress)
                        } label: {
                            Label("Save to Photos", systemImage: "square.and.arrow")
                        }

                    }
            }
            .navigationTitle("Your code")
            .onAppear {
                vm.updateCode(name: name, emailAddress: emailAddress)
            }
            .onChange(of: name) { _ in
                vm.updateCode(name: name, emailAddress: emailAddress)
            }
            .onChange(of: emailAddress) { _ in
                vm.updateCode(name: name, emailAddress: emailAddress)
            }
        }
    }
}










struct MeView_Previews: PreviewProvider {
    static var previews: some View {
        MeView()
            .environmentObject(ProspectViewModel())
    }
}
