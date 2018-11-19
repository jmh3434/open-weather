//
//  ViewController.swift
//  weather
//
//  Created by James Hunt on 11/18/18.
//  Copyright © 2018 James Hunt. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var weatherLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getLocation()
        // Do any additional setup after loading the view, typically from a nib.
    }
    func getLocation() {
        
        Weather.forecast(withID: "4460162") { (data:[String:Any]) in
            
                
                DispatchQueue.main.async {
//                    let temp = result.temp
//                    print("the temperature is", temp)
                    
//                    let humidity = data["humidity"]!
//                    print("the humidity from here is is", humidity)
//                    let description = data["description"]!
//                    print("the description from here is is", description)
//                    let main = data["main"]!
//                    print("the main from here is is", main)
//                    let temp = data["temp"]!
//
//                    print("temp is:", temp)
//                    let temp_max = data["temp_max"]
//                    print("temp_max",temp_max ?? 0)
//                    let temp_min = data["temp_min"]
//                    print("temp_min",temp_min ?? 0)
//                    let windspeed = data["windspeed"]!
//                    print("windspeed",windspeed)
                }
            
            
        }
        Forecast.forecast(withID: "4460162") { (forecastDict:[[String:Any]]) in
            
            
            DispatchQueue.main.async {
                for day in forecastDict {
                    //print("day",day)
                }
            }
            
            
        }
        Summary.getWeather(withLocation: "35.9467,-79.0612") { (currentWeather:[String : Any]) in
            DispatchQueue.main.async {
                let temp = currentWeather["temp"] as! Double
                let humidity = currentWeather["humidity"] as! Double
                let time = currentWeather["time"] as! Int
                let cloudCover = currentWeather["cloudCover"] as! Double
                let windSpeed = currentWeather["windSpeed"] as! Double
                let precipProbability = currentWeather["precipProbability"] as! Double
                let nearestStormDistance = currentWeather["nearestStormDistance"] as! Int
                let summary = currentWeather["summary"] as! String
                let tempLow = currentWeather["tempLow"] as! Double
                let tempHigh = currentWeather["tempHigh"] as! Double

                
                print(currentWeather["temp"] as! Double)
                print(currentWeather["humidity"] as! Double)
                print(currentWeather["time"] as! Int)
                print(currentWeather["cloudCover"] as! Double)
                print(currentWeather["windSpeed"] as! Double)
                print(currentWeather["precipProbability"] as! Double)
                print(currentWeather["nearestStormDistance"] as! Int)
                print(currentWeather["summary"] as! String)
                print(currentWeather["tempLow"] as! Double)
                print(currentWeather["tempHigh"] as! Double)
                
                let unixTimestamp = time
                let date = Date(timeIntervalSince1970: TimeInterval(unixTimestamp))
                
                let dateFormatter = DateFormatter()
                dateFormatter.timeZone = TimeZone(abbreviation: "EDT") //Set timezone that you want
                dateFormatter.locale = NSLocale.current
                dateFormatter.dateFormat = "MM-dd h:mm" //Specify your format that you want
                let strDate = dateFormatter.string(from: date)
                
                
                
                
                self.weatherLabel.text = "time: \(strDate)\nwindspeed: \(windSpeed) MPH\nhumidity: \(Int(humidity))%\nnearest storm: \(nearestStormDistance) miles\ncloud cover: \(cloudCover)%\nprecipitation probability: \(precipProbability)%"
                
            }
        }
        
        
    }
    
        
    
    

}


