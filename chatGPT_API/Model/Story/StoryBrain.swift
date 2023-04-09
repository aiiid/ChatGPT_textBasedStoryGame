//
//  StoryBrain.swift
//  chatGPT_API
//
//  Created by Ai Hawok on 19/03/2023.
//
//StoryBrain structure gets the response from chatGPT and models the story from it

import Foundation

struct StoryBrain{
    func modelAStory(input: String) -> Story?{
        var story = Story(title: "", choice1: "", choice2: "", choice3: "")
        print("INPUT:",input)
        
        let sliceStr = (input.slice(from: "{", to: "}") ?? "")
        
        //print(sliceStr)
        let jsonString = sliceStr
        let jsonData = jsonString.data(using: .utf8)
        let json = try! JSONSerialization.jsonObject(with: jsonData!, options: []) as! [String: Any]
        let title = json["story"] as! String
        let options = json["options"] as! [String]
        
        story.title = title
        story.choice1 = options[0]
        story.choice2 = options[1]
        story.choice3 = options[2]
        
        return story
    }
}

//MARK: - Extensions
extension StringProtocol {
    var lines: [SubSequence] { split(whereSeparator: \.isNewline) }
}
extension String {
    func slice(from: String, to: String) -> String? {
        guard let rangeFrom = range(of: from)?.lowerBound else { return nil }
        guard let rangeTo = self.range(of: to, range: rangeFrom..<endIndex)?.upperBound else { return nil }
        return String(self[rangeFrom..<rangeTo])
    }
}
