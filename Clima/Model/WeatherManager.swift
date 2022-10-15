//
//  WeatherManager.swift
//  Clima
//
//  Created by Samuel Santos on 15/10/22.
//  Copyright © 2022 App Brewery. All rights reserved.
//
//OBS: Criar API em nodejs para enviar os dados e as imagens
//

import Foundation

struct WeatherManager {
    let apiURL = "https://api.openweathermap.org/data/2.5/weather?appid=c50478cc02af31ce5eb4ab892f3f0a67&units=metric"
    
    func fetchWeather(cityName: String)  {
        let urlString = "\(apiURL)&q=\(cityName)"
        performRequest(urlString: urlString)
    }
    
    func performRequest(urlString: String) {
        //Create Url
        
        if let url = URL(string: urlString) {
            
            //Create URLSession
            let session = URLSession(configuration: .default)
     
            //Give the session a task
        let task = session.dataTask(with: url, completionHandler: handle(data: response: error: ))
        
            //Start the task
            task.resume()
            
        }
    }
    
    func handle(data: Data?, response: URLResponse?, error: Error?){
        
        if error != nil {
            print(error!)
            return
        }
        
        if let safeData = data {
            let dataString = String(data: safeData, encoding: .utf8)
            print(dataString)
        }
    }
}
