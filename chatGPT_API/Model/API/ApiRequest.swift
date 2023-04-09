//
//  Messages.swift
//  chatGPT_API
//
//  Created by Ai Hawok on 14/03/2023.
// API Request and Response structure based on official documentation of Chat GPT

import Foundation

struct Messages: Encodable{
    private let role: String = "user"
    private let content: String
    
    init(content: String){
        self.content = content
    }
}
