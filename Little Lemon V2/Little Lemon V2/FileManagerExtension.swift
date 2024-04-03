//
//  FileManagerExtension.swift
//  Little Lemon V2
//
//  Created by Renee Lo on 2/4/2024.
//

import Foundation
import UIKit

extension FileManager {
    
    func retrieveImage(fileName: String) -> UIImage? {
        let url = URL.documentsDirectory.appendingPathComponent("\(fileName).jpg")
        do {
            let imageData = try Data(contentsOf: url)
            return UIImage(data: imageData)
        } catch {
//            print(error.localizedDescription)
            return nil
        }
    }
    
    
    func saveImage(fileName: String, image: UIImage) {
        if let data = image.jpegData(compressionQuality: 0.6) {
            do {
                let url = URL.documentsDirectory.appendingPathComponent("\(fileName).jpg")
                try data.write(to: url)
            } catch {
//                print(error.localizedDescription)
            }
        } else {
//            print("Could not save image.")
        }
    }
    
    func deleteImage(fileName: String) {
        let url = URL.documentsDirectory.appendingPathComponent("\(fileName).jpg")
        if fileExists(atPath: url.path) {
            do {
                try removeItem(at: url)
            } catch  {
//                print(error.localizedDescription )
            }
        } else {
//            print("Image does not exist.")
        }
    }
    
    
}
