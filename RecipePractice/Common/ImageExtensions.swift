//
//  Image.swift
//  RecipePractice
//
//  Created by Sofia Krakova on 04.07.2024.
//

import Foundation
import SwiftUI

extension Image {
    static func fromPath(imagePath: String) -> Image {
            let fileURL = URL(fileURLWithPath: imagePath)
            print("Attempting to load image from path: \(fileURL.path)")
            
            if FileManager.default.fileExists(atPath: fileURL.path) {
                print("File exists at path")
                do {
                    let imageData = try Data(contentsOf: fileURL)
                    if let uiImage = UIImage(data: imageData) {
                        print("Image loaded successfully")
                        return Image(uiImage: uiImage)
                    } else {
                        print("Failed to create UIImage from data.")
                    }
                } catch {
                    print("Error loading image data: \(error.localizedDescription)")
                }
            } else {
                print("File does not exist at path")
            }
            
            return Image(systemName: "photo")
        }
}
