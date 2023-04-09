//
//  API.swift
//  chatGPT_API
//
//  Created by Ai Hawok on 14/03/2023.
//
// API Request and Response structure based on official documentation of Chat GPT
import Foundation

struct Request: Encodable{
    let model: String = "gpt-3.5-turbo"
    let messages: [Messages]
    
}

struct Response: Decodable{
    let choices: [Choices]
}
