//
//  GifLoader.swift
//  chatGPT_API
//
//  Created by Ai Hawok on 25/03/2023.
//
// GifLoader implementation

import UIKit
import ImageIO


class GIFPlayer {
    private var gifURL: URL!
    private var gifDuration: TimeInterval!
    
    func playGIF(named gifName: String, in imageView: UIImageView) {
        guard let gifURL = Bundle.main.url(forResource: gifName, withExtension: "gif") else {
            print("Error: GIF not found")
            return
        }
        
        self.gifURL = gifURL
        self.gifDuration = getGIFDuration(gifURL: gifURL)
        
        guard let gifData = try? Data(contentsOf: gifURL) else {
            print("Error: Could not load GIF data")
            return
        }
        
        guard let gif = UIImage.gifImageWithData(gifData) else {
            print("Error: Could not create GIF image")
            return
        }
        
        imageView.image = gif
        imageView.startAnimating()
    }
    
    func stop() {
        self.gifURL = nil
        self.gifDuration = nil
    }
    
    
    private func getGIFDuration(gifURL: URL) -> TimeInterval {
        guard let gifSource = CGImageSourceCreateWithURL(gifURL as CFURL, nil) else {
            return 0
        }
        
        let gifDuration = CGImageSourceGetGifDuration(gifSource)
        
        return gifDuration
    }

    private func CGImageSourceGetGifDuration(_ gifSource: CGImageSource) -> TimeInterval {
        let frameCount = CGImageSourceGetCount(gifSource)
        var duration: TimeInterval = 0
        
        for i in 0..<frameCount {
            guard let properties = CGImageSourceCopyPropertiesAtIndex(gifSource, i, nil) as? [String: Any],
                let gifInfo = properties[kCGImagePropertyGIFDictionary as String] as? [String: Any] else {
                    return 0
            }
            
            let frameDuration = gifInfo[kCGImagePropertyGIFDelayTime as String] as? Double ?? 0
            duration += frameDuration
        }
        
        return duration
    }
}

extension UIImage {
    class func gifImageWithData(_ data: Data) -> UIImage? {
        guard let source = CGImageSourceCreateWithData(data as CFData, nil) else {
            print("Error: Could not create image source from GIF data")
            return nil
        }
        
        let totalCount = CGImageSourceGetCount(source)
        var images = [UIImage]()
        var gifDuration = 0.0
        
        for i in 0..<totalCount {
            guard let cgImage = CGImageSourceCreateImageAtIndex(source, i, nil) else {
                print("Error: Could not create image from GIF data")
                return nil
            }
            
            let image = UIImage(cgImage: cgImage)
            
            guard let properties = CGImageSourceCopyPropertiesAtIndex(source, i, nil) as? [String: Any],
                let gifInfo = properties[kCGImagePropertyGIFDictionary as String] as? [String: Any] else {
                    print("Error: Could not get GIF properties")
                    return nil
            }
            
            let frameDuration = gifInfo[kCGImagePropertyGIFDelayTime as String] as? Double ?? 0
            gifDuration += frameDuration
            
            images.append(image)
        }
        
        let gifImage = UIImage.animatedImage(with: images, duration: gifDuration)
        
        return gifImage
    }
}
