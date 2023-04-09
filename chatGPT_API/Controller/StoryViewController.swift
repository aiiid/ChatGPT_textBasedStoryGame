//
//  ViewController.swift
//  chatGPT_API
//
//  Created by Ai Hawok on 14/03/2023.
//

import UIKit


class StoryViewController: UIViewController {
    var model = DomainModel()
    var queryManager = QueryManager()
    var storyBrain = StoryBrain()
    private let gifPlayer = GIFPlayer()
    let history = HistoryModel.shared.data
    
    @IBOutlet weak var loadingText: UILabel!
    @IBOutlet weak var player: UIImageView!
    @IBOutlet weak var option1: UIButton!
    @IBOutlet weak var option2: UIButton!
    @IBOutlet weak var option3: UIButton!
    @IBOutlet weak var storyTitle: UILabel!
    @IBOutlet weak var historyBTN: UIButton!
    
    var currentTitle = ""
    var currentOption = ""
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        model.delegate = self
        model.fetch(with: queryManager.queryOpening)
        
    }
//triggered when any of the option is chosen
    @IBAction func choiceMade(_ sender: UIButton) {
        currentOption = sender.currentTitle!
        UIView.animate(withDuration: 0.5, animations:{
            self.historyBTN.alpha = 100
        })
        HistoryModel.shared.addData(title: storyTitle.text!, option: currentOption)
        print(HistoryModel.shared.data)
        hideLabel()
        hideButton()
        gifPlayer.stop()
        loadingText.text = "Continuing your story"
        gifPlayer.playGIF(named: "pusheen_continue", in: player)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            // Call second function
            self.showPlayer()
        }
        
        model.fetch(with: queryManager.continueQuery(story: currentTitle, option: currentOption))
    }
    
    @IBAction func choiceButtonPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "historyPopUp", sender: self)
    }
    
}

//MARK: - Story Delegate
//delegate to update the story once response came to DomainModel
extension StoryViewController: StoryManagerDelegate{
    func didUpdateStory(story: String) {
        let modeledStory = storyBrain.modelAStory(input: model.content)
        if modeledStory?.title == "" || (modeledStory?.title.count)! < 15{
            print("Title is empty. It's wrong and I'm trying not to change it")
            model.fetch(with: queryManager.continueQuery(story: currentTitle, option: currentOption))
        }else{
            self.option1.setTitle(modeledStory?.choice1, for: .normal)
            self.option1.sizeToFit()
            self.option2.setTitle(modeledStory?.choice2, for: .normal)
            self.option2.sizeToFit()
            self.option3.setTitle(modeledStory?.choice3, for: .normal)
            self.option3.sizeToFit()
            storyAnimate(storyLabel: self.storyTitle, storyTitle: modeledStory!.title)
        }
    }
}
    
//MARK: - Animate
//Letter by letter animated text
extension UILabel {
    func animate(newText: String, characterDelay: TimeInterval, completion: (() -> Void)? = nil) {
        DispatchQueue.main.async() {
            self.text = ""
            for (index, character) in newText.enumerated() {
                DispatchQueue.main.asyncAfter(deadline: .now() + characterDelay * Double(index)) {
                    self.text?.append(character)
                    if index == newText.count - 1 { // check if this is the last character to be animated
                    completion?() // call the completion handler if it's not nil
                }
                }
            }
        }
    }
}
//MARK: - Animations
extension StoryViewController{
    func hideLabel(){
        UIView.animate(withDuration: 0.5, animations: {
            self.storyTitle.alpha = 0
        })
    }
    
    func showLabel(){
        UIView.animate(withDuration: 0.5, animations:{
            self.storyTitle.alpha = 100
        })
    }
    func hideButton() {
        
        UIView.animate(withDuration: 0.5, delay: 0.5, animations: {
            self.option1.alpha = 0.0
            self.option2.alpha = 0.0
            self.option3.alpha = 0.0
        })
    }
    
    // When the function is triggered again, animate the alpha back to 1.0
    func showButton() {
        UIView.animate(withDuration: 0.5, animations: {
            self.option1.alpha = 1.0
        })
        UIView.animate(withDuration: 0.5, delay: 0.35, animations: {
            self.option2.alpha = 1.0
        })
        UIView.animate(withDuration: 0.5, delay: 0.7, animations: {
            self.option3.alpha = 1.0
        })
    }
    func showPlayer(){
        UIView.animate(withDuration: 0.5, delay:0.5, animations: {
            self.loadingText.alpha = 1.0
            self.player.alpha = 1.0
        })
    }
    func hidePlayer(){
        UIView.animate(withDuration: 0.5, animations: {
            self.loadingText.alpha = 0.0
            self.player.alpha = 0.0
        })
    }
    
    func storyAnimate(storyLabel: UILabel, storyTitle: String){
        hidePlayer()
        showLabel()
        storyLabel.animate(newText: storyTitle, characterDelay: 0.019){
            self.showButton()
        }
    }
}

//setup > Settings to set in the beginning
extension StoryViewController{
    func setup(){
        option1.layer.cornerRadius = 0.25 * option1.bounds.size.height
        option2.layer.cornerRadius = 0.25 * option2.bounds.size.height
        option3.layer.cornerRadius = 0.25 * option3.bounds.size.height
        
        gifPlayer.playGIF(named: "pusheen_generate", in: player)
        showPlayer()
        hideLabel()
        hideButton()
        historyBTN.alpha = 0
        
    }
}
