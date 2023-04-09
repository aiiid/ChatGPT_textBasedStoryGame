//
//  StartViewController.swift
//  chatGPT_API
//
//  Created by Ai Hawok on 15/03/2023.
//
//  Starting page
import UIKit

class StartViewController: UIViewController {

    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var startButton: UIButton!
    
    private let gifPlayer = GIFPlayer()
    private let gifList = ["Burrito","Cat","dragonborn","elegante","Kitty_Perry", "party"]
    var currentGifIndex = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        displayNextGif()
    }
    

    @IBAction func startPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "goToStory", sender: self)
    }
    


}
//MARK: - Setup

extension StartViewController{
    func setup(){
        self.view.backgroundColor = UIColor(hex: "#fcf0e3")
        startButton.layer.cornerRadius = 0.25 * startButton.bounds.size.height
    }
}
//MARK: - gifPlayer
extension StartViewController{
    func displayNextGif() {
        let gifName = gifList[currentGifIndex]
        gifPlayer.playGIF(named: gifName, in: mainImage)
            // Animate the fade in effect
            UIView.animate(withDuration: 0.5, animations: {
                self.mainImage.alpha = 1.0
            }, completion: { _ in
                // Animate the fade out effect
                UIView.animate(withDuration: 0.5, delay: 2.0, animations: {
                    self.mainImage.alpha = 0.0
                }, completion: { _ in
                    // Increment the index and display the next GIF
                    self.currentGifIndex = (self.currentGifIndex + 1) % self.gifList.count
                    self.displayNextGif()
                })
            })
        }
    
}

//MARK: - UIColor hex
extension UIColor {
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var cString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if cString.hasPrefix("#") {
            cString.remove(at: cString.startIndex)
        }
        if (cString.count) != 6 {
            self.init(red: 0.5, green: 0.5, blue: 0.5, alpha: alpha)
            return
        }
        var rgbValue: UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                  blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                  alpha: alpha)
    }
}
