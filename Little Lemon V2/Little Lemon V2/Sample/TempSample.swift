//
//  TempSample.swift
//  Little Lemon V2
//
//  Created by Renee Lo on 13/3/2024.
//

import SwiftUI
import PhotosUI

struct TempSample: View {
    @State private var avatarItem: PhotosPickerItem?
    @State private var avatarImage: Image?
    
    private var fileManager: FileManager = FileManager()
    
    var body: some View {
        
        VStack {
            PhotosPicker("Select avatar", selection: $avatarItem, matching: .images)

            avatarImage?
                .resizable()
                .scaledToFit()
                .frame(width: 300, height: 300)
        }
        .onChange(of: avatarItem) {
            Task {
                if let loaded = try? await avatarItem?.loadTransferable(type: Data.self) {
                    if let uiImage = UIImage(data: loaded) {
                        self.avatarImage = Image(uiImage: uiImage)
                        self.fileManager.saveImage(fileName: "profile", image: uiImage)
                    }
                } else {
                    print("Failed")
                }
            }
        }
        .onAppear {
            avatarImage = Image(uiImage: fileManager.retrieveImage(fileName: "profile") ?? UIImage(systemName: "pencil.circle.fill")!)
        }
    }
}


#Preview {
    TempSample()
}

