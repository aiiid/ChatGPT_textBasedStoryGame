//
//  DomainModel.swift
//  chatGPT_API
//
//  Created by Ai Hawok on 14/03/2023.
//
// API request is implemented here
import Foundation

protocol StoryManagerDelegate{
    func didUpdateStory(story: String)
}

final class DomainModel{
    var content = ""
    var delegate : StoryManagerDelegate?
    
    private let apiKey = ConfigManager.shared.getAPIKey()
    let url = "https://api.openai.com/v1/chat/completions"
    
    func fetch(with query: String){
        let session = URLSession.shared
        var request = URLRequest(url: URL(string: url)!)
        //sending curl header?
        request.httpMethod = "POST"
        request.setValue("Bearer \(String(describing: apiKey))", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        //
        let body = Request(messages: [.init(content: query)])
        let encodedBody = try! JSONEncoder().encode(body)
        request.httpBody = encodedBody
        //
        session.dataTask(with: request) { [weak self] data, response, error in
            if let error = error {
                print(":::::::::")
                print(error.localizedDescription)
            }
            guard let data = data else { return }
            do{
                let response = try! JSONDecoder().decode(Response.self, from: data)
                DispatchQueue.main.async {
                    self?.content = response.choices.first?.message.content ?? ""
                    self?.delegate?.didUpdateStory(story: self?.content ?? "")
                }
            }catch let error {
                print("Error decoding JSON: \(error)")
            }

        }
            .resume()
    }
}
