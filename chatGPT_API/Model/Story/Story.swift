//
//  Story.swift
//  chatGPT_API
//
//  Created by Ai Hawok on 19/03/2023.
//
// Custom Story structure, to sort the response from chatGPT
import Foundation

struct Story{
    var title: String
    var choice1: String
    var choice2: String
    var choice3: String
    
    init(title: String, choice1: String, choice2: String, choice3: String){
        self.title = title
        self.choice1 = choice1
        self.choice2 = choice2
        self.choice3 = choice3
    }
}
