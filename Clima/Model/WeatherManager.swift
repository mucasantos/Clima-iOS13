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

protocol WeatherManagerDelegate {
    func didUpdateWeather(weather: WeatherModel)
}

struct WeatherManager {
    let apiURL = "https://api.openweathermap.org/data/2.5/weather?appid={API_KEY}&units=metric"
    
    var delegate: WeatherManagerDelegate?
    
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
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                
                if let safeData = data {
                    if let weather =   self.parseJSON(weatherData: safeData) {
                        self.delegate?.didUpdateWeather(weather: weather)
                    }
                }
            }
            
            //Start the task
            task.resume()
        }
    }
    
    func parseJSON(weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let iconURL = "https://openweathermap.org/img/wn/\(decodedData.weather[0].icon)@2x.png"
            
            let temp = decodedData.main.temp
            let pressure = decodedData.main.pressure
            let feelsLike = decodedData.main.feels_like
            let humidity = decodedData.main.humidity
            let description = decodedData.weather[0].description
            let city = decodedData.name
            
            let weather = WeatherModel(temp: temp, pressure: pressure, feels_like: feelsLike, humidity: humidity, description: description, icon: iconURL, city: city)
            
            return weather
            
        } catch {
            print(error)
            return nil
        }
    }
    
    
}
