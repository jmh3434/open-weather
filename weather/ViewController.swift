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
    
    let label = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
    let container = UIView()
    let redSquare = UIView()
    let blueSquare = UIView()
    
    
    var labeld = UILabel()
    var labelSum = UILabel()
    var labelHigh = UILabel()
    var labelLow = UILabel()
    
    ////
    
    //
    
    
    
    var refreshButton = UIButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        // label for CH
        let labelch = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 150))
        labelch.numberOfLines = 5
        labelch.text = "Chapel Hill Weather"
        labelch.center = CGPoint(x: 130, y: 118)
        labelch.textAlignment = .justified
        labelch.textColor = UIColor.black
        labelch.font = UIFont(name: "Dosis-Bold", size: 35)
        self.view.addSubview(labelch)
        
        //label for time, windspeed, and humidity
        
        label.numberOfLines = 112
        label.center = CGPoint(x: 180, y: 280)
        label.textAlignment = .natural
        label.textColor = UIColor.black
        label.font = UIFont(name: "Dosis-Light", size: 26)
        self.view.addSubview(label)
        
        getLocation()
        // Do any additional setup after loading the view, typically from a nib.
        
        view.backgroundColor = UIColor(white: 0.9, alpha: 1)
        
        
        self.container.frame = CGRect(x: 60, y: 60, width: 200, height: 200)
        self.view.addSubview(container)
        
        
        self.redSquare.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        
        
        let weatherIcon = UIImageView()
        weatherIcon.image = UIImage(named: "icon_weather.png")
        weatherIcon.frame = CGRect(x: 180, y: 160, width: 100, height: 100)
        self.redSquare.addSubview(weatherIcon)
        
        
        
        
        self.container.addSubview(self.redSquare)
        UIView.animate(withDuration: 1.5, animations: {
            self.redSquare.frame.origin.y -= 160
        }, completion: nil)
        
        
        
        
        
        // label for low temp
        labelLow = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
        labelLow.numberOfLines = 112
        labelLow.center = CGPoint(x: 180, y: 450)
        labelLow.textAlignment = .center
        labelLow.textColor = UIColor.blue
        labelLow.font = UIFont(name: "Dosis-Light", size: 30)
        self.view.addSubview(labelLow)
        
        
        //label for current temp
        labeld = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
        labeld.numberOfLines = 112
        labeld.center = CGPoint(x: 180, y: 480)
        labeld.textAlignment = .center
        labeld.textColor = UIColor.black
        labeld.font = UIFont(name: "Dosis-Light", size: 30)
        self.view.addSubview(labeld)
        
        // label for max temp
        labelHigh = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
        labelHigh.numberOfLines = 112
        labelHigh.center = CGPoint(x: 180, y: 510)
        labelHigh.textAlignment = .center
        labelHigh.textColor = UIColor.red
        labelHigh.font = UIFont(name: "Dosis-Light", size: 30)
        self.view.addSubview(labelHigh)
        
        
        
        // label for weather summary this week
        
        labelSum = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
        labelSum.numberOfLines = 112
        labelSum.center = CGPoint(x: 180, y: 650)
        labelSum.textAlignment = .center
        labelSum.textColor = UIColor.black
        labelSum.font = UIFont(name: "Dosis-Light", size: 30)
        self.view.addSubview(labelSum)
        
        // buttton
        
        let button = UIButton(frame: CGRect(x: 150, y: 740, width: 80, height: 30))
        button.backgroundColor = .black
        button.setTitle("refresh", for: UIControl.State.normal)
        button.addTarget(self, action: #selector(buttonAction), for: UIControl.Event.touchUpInside)
        
        self.view.addSubview(button)
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
                dateFormatter.dateFormat = "MM-dd h:mm:ss" //Specify your format that you want
                let strDate = dateFormatter.string(from: date)
                
                
                
                
                self.label.text = "time: \(strDate)\nwindspeed: \(windSpeed) MPH\nhumidity: \(Int(humidity*100))%\nnearest storm: \(nearestStormDistance) miles\ncloud cover: \(cloudCover)%\nprecipitation probability: \(precipProbability)%"
                
                
                self.labelHigh.text = "\(tempHigh) ˚F"
                self.labeld.text = "\(temp) ˚F"
                self.labelLow.text = "\(tempLow) ˚F"
                self.labelSum.text = summary

                
            }
        }
        
        
    }
    
    @objc func buttonAction(sender: UIButton!) {
        getLocation()
    }
    
    

}


