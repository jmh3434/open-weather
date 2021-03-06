//
//  Summary.swift
//  weather
//
//  Created by James Hunt on 11/19/18.
//  Copyright © 2018 James Hunt. All rights reserved.
//

import Foundation


struct Summary {
    
    
    static let basePath = "https://api.darksky.net/forecast/efd21cf614c4f0429e807683bbe7b1e4/"
    static let apiKey = "1a030624be57d904c2ea834c553e9c4c"
    static let weatherType = "weather?"
    static let units = "imperial"
    static let unit = "F"
    
    
    static func getWeather (withLocation location:String, completion: @escaping
        
        ([String:Any]) -> ()) {
        
        

        
        
        
        
        let url = basePath + location
        let request = URLRequest(url: URL(string: url)!)
        
        let task = URLSession.shared.dataTask(with: request) { (data:Data?, response:URLResponse?, error:Error?) in
            
            
            var weatherDict = [String:Any]()
            
            if let data = data {
                
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] {
                        
                        
                       if let daily = json["currently"] as? [String:Any] {
                            //print("daily",daily)
                            if let temp = daily["temperature"] as? Double,let humidity = daily["humidity"] as? Double, let time = daily["time"],let precipProbability = daily["precipProbability"],let windSpeed = daily["windSpeed"], let cloudCover = daily["cloudCover"]{
                                //print("temp",temp)
                                weatherDict["temp"] = temp
                                //print("humidity",humidity)
                                weatherDict["humidity"] = humidity
                                weatherDict["time"] = time
                                //print("time",time)
                                weatherDict["cloudCover"] = cloudCover
                                //print("cloudCover",cloudCover)
                                weatherDict["windSpeed"] = windSpeed
                                //print("windSpeed",windSpeed)
                                weatherDict["precipProbability"] = precipProbability
                                //print("precipProbability",precipProbability)
                            }
                            if let nearestStormDistance = daily["nearestStormDistance"] as? Int  {
                               // print("nearestStormDistance",nearestStormDistance)
                                weatherDict["nearestStormDistance"] = nearestStormDistance
                            }
                        
                        
                        
                        
                        }
                        
                        if let dailyOutlook = json["daily"] as? [String:Any] {
                            
                            if let summary = dailyOutlook["summary"] {
                                weatherDict["summary"] = summary
                            }
                            
                            if let dailyOutlook = dailyOutlook["data"] as? [[String:Any]] {
                                
                               // print("dailyOutlook",dailyOutlook[0])
                                if let tempLow = dailyOutlook[0]["temperatureLow"], let tempHigh = dailyOutlook[0]["temperatureHigh"]{
                                     weatherDict["tempLow"] = tempLow
                                     //print("tempLow",tempLow)
                                     weatherDict["tempHigh"] = tempHigh
                                     //print("tempHigh",tempHigh)
                                    
                                    
                                }
                               
                                
                                for dataPoint in dailyOutlook {
                                    
                                    //print("dataPoint",dataPoint)
                                }
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


