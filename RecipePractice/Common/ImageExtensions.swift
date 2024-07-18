//
//  Image.swift
//  RecipePractice
//
//  Created by Sofia Krakova on 04.07.2024.
//

import Foundation
import SwiftUI
import Combine

extension UIImage {
    static func fromPath(imagePath: String) -> UIImage? {
        let fileURL = URL(fileURLWithPath: imagePath)
        print("Attempting to load image from path: \(fileURL.path)")

        if FileManager.default.fileExists(atPath: fileURL.path) {
            print("File exists at path")
            do {
                let imageData = try Data(contentsOf: fileURL)
                if let uiImage = UIImage(data: imageData) {
                    print("Image loaded successfully")
                    return uiImage
                } else {
                    print("Failed to create UIImage from data.")
                }
            } catch {
                print("Error loading image data: \(error.localizedDescription)")
            }
        } else {
            print("File does not exist at path")
        }

        return nil
    }
    
    static func fromURL(urlString: String) -> AnyPublisher<UIImage?, Never> {
        guard let url = URL(string: urlString) else {
            return Just(nil).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .map { UIImage(data: $0) }
            .replaceError(with: nil)
            .eraseToAnyPublisher()
    }
}

extension Image {
    static func fromPath(imagePath: String) -> Image {
        if let uiImage = UIImage.fromPath(imagePath: imagePath) {
            return Image(uiImage: uiImage)
        } else {
            return Image(systemName: "photo")
        }
    }
    
    static func fromURL(urlString: String) -> AnyPublisher<Image, Never> {
        return UIImage.fromURL(urlString: urlString)
            .map { uiImage in
                if let uiImage = uiImage {
                    return Image(uiImage: uiImage)
                } else {
                    return Image(systemName: "photo")
                }
            }
            .eraseToAnyPublisher()
    }
}
