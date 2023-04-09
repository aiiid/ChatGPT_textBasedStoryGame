//
//  QueryManager.swift
//  chatGPT_API
//
//  Created by Ai Hawok on 19/03/2023.
//
// QueryManager consists of two queries. Opening and Continue.
// queryOpening: set's up chatGPT to play text based story game;
// queryContinue: continues the story based on the choice user made
import Foundation

class QueryManager{

    var queryOpening =
    """
    Lets play text based story game, Generate me a short story and three short options to choose from. You should return me json with following structure. For now create only beginning of the story and don't continue until I choose an option
    {
        "story" : "String",
        "options" : ["Option 1", "Option 2", "Option 3"]
     }
    """
    
    var queryContinue = "Continue the story"

    func continueQuery(story: String, option: String) -> String{
        return  ("""
            Continue the story \(story) considering I'm gonna do this \(option). Provide me three options to do. Keep a story and options short. You should return me json with following structure. For now create only beginning of the story and don't continue until I choose an option
    {
        "story" : "String",
        "options" : ["Option 1", "Option 2", "Option 3"]
     }
""")
    }
}
