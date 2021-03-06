//
//  Weather.swift
//  weather
//
//  Created by James Hunt on 11/18/18.
//  Copyright © 2018 James Hunt. All rights reserved.
//

import Foundation


struct Weather {
  
    
    static let basePath = "https://api.openweathermap.org/data/2.5/"
    static let apiKey = "1a030624be57d904c2ea834c553e9c4c"
    static let weatherType = "weather?"
    static let units = "imperial"
    static let unit = "F"
    
    
    static func forecast (withID id:String, completion: @escaping
        
        ([String:Any]) -> ()) {
        

        
        
        // http://api.openweathermap.org/data/2.5/weather?id=4460162&appid=1a030624be57d904c2ea834c553e9c4c
        
        
        let url = "\(basePath)\(weatherType)id=\(id)&&appid=\(apiKey)&units=\(units)"

        print("URL",url)
        let request = URLRequest(url: URL(string: url)!)
        
        let task = URLSession.shared.dataTask(with: request) { (data:Data?, response:URLResponse?, error:Error?) in
            
            
            var weatherDict = [String:Any]()
            
            if let data = data {
                
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] {
                        
                        
                       
                        if let name = json["name"] as? String  {
                            
                            
                        }
                        if let wind = json["wind"] as? [String:Any]  {
                            if let windspeed = wind["speed"]{
                            weatherDict["windspeed"] = windspeed
                            }
                        }
                        if let stats = json["main"] as? [String:Any] {
                            
                            if let humidity = stats["humidity"],let temp = stats["temp"]{
                                weatherDict["humidity"] = humidity
                                weatherDict["temp"] = temp
                            }
                            if let temp_max = stats["temp_max"] as? NSNumber, let temp_min = stats["temp_min"] as? NSNumber {
                                
                                weatherDict["temp_max"] = temp_max
                                weatherDict["temp_min"] = temp_min
                                
                                
                                
                            }
                            
                            
                            
                
                        }
                        if let weather = json["weather"] as? [[String:Any]] {
                            if let main = weather[0]["main"] as? String,let description = weather[0]["description"] as? String {
                                  weatherDict["main"] = main
                                  weatherDict["description"] = description
                            }
                            

                            
                            
                            
                            
                        }
                
                        
                    }
                }catch {
                    print(error.localizedDescription)
                }
                
                completion(weatherDict)
                
            }
            
            
        }
        
        task.resume()
        
        
        
        
        
        
        
        
        
    }
    
    
}

