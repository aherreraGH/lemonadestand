//
//  WeatherForecastFactory.swift
//  Lemonade Stand
//
//  Created by ADRIAN HERRERA on 12/27/14.
//  Copyright (c) 2014 After Works Projects. All rights reserved.
//

import Foundation
import UIKit

class WeatherForecastFactory {
    // class function, will not create the Factory object, just straight use of the method
    // much like a java static method call.
    class func createInitialForecasts() -> [WeatherForecastSlot] {
        let kNumberOfSlots = 5; // this is a 5-Day forecast
        
        var slots:[WeatherForecastSlot] = [];
        
        for (var count = 0; count < kNumberOfSlots; count++) {
            slots.append(createWeatherForecastSlot());
        }
        
        return slots;
    }
    
    class func createWeatherForecastSlot() -> WeatherForecastSlot {
        var slot:WeatherForecastSlot;
        
        var randomNumber = Int(arc4random_uniform(UInt32(21)));
        var randomChance:Float = (Float(arc4random_uniform(UInt32(99))))/100;
        
        switch randomNumber {
        case 0:
            // sunny
            slot = WeatherForecastSlot(value: randomNumber, image: UIImage(named: "001.png"), description: "Sunny", chance: randomChance);
        case 1:
            // Very cloudy
            slot = WeatherForecastSlot(value: randomNumber, image: UIImage(named: "002.png"), description: "Very cloudy",chance: randomChance);
        case 2:
            // sunny light clouds
            slot = WeatherForecastSlot(value: randomNumber, image: UIImage(named: "003.png"), description: "Light clouds",chance: randomChance);
        case 3:
            // mostly cloudy
            slot = WeatherForecastSlot(value: randomNumber, image: UIImage(named: "004.png"), description: "Mostly cloudy",chance: randomChance);
        case 4:
            // sunny with some rain
            slot = WeatherForecastSlot(value: randomNumber, image: UIImage(named: "005.png"), description: "Partly sunny and drizzle",chance: randomChance);
        case 5:
            // light rain
            slot = WeatherForecastSlot(value: randomNumber, image: UIImage(named: "012.png"), description: "Light rain",chance: randomChance);
        case 6:
            // rain
            slot = WeatherForecastSlot(value: randomNumber, image: UIImage(named: "013.png"), description: "Raining",chance: randomChance);
        case 7:
            // heavy rain
            slot = WeatherForecastSlot(value: randomNumber, image: UIImage(named: "014.png"), description: "Heavy rain",chance: randomChance);
        case 8:
            // rain and lightning
            slot = WeatherForecastSlot(value: randomNumber, image: UIImage(named: "015.png"), description: "Thunderstorms",chance: randomChance);
        case 9:
            // lightning
            slot = WeatherForecastSlot(value: randomNumber, image: UIImage(named: "016.png"), description: "Lightning",chance: randomChance);
        case 10:
            // light hail
            slot = WeatherForecastSlot(value: randomNumber, image: UIImage(named: "017.png"), description: "Light hail",chance: randomChance);
        case 11:
            // hail
            slot = WeatherForecastSlot(value: randomNumber, image: UIImage(named: "018.png"), description: "Hail",chance: randomChance);
        case 12:
            // heavy hail
            slot = WeatherForecastSlot(value: randomNumber, image: UIImage(named: "019.png"), description: "Heavy hail",chance: randomChance);
        case 13:
            // light snow
            slot = WeatherForecastSlot(value: randomNumber, image: UIImage(named: "020.png"), description: "Light snow",chance: randomChance);
        case 14:
            // snow
            slot = WeatherForecastSlot(value: randomNumber, image: UIImage(named: "021.png"), description: "Snow",chance: randomChance);
        case 15:
            // heavy snow
            slot = WeatherForecastSlot(value: randomNumber, image: UIImage(named: "022.png"), description: "Heavy snow",chance: randomChance);
        case 16:
            // rain and snow
            slot = WeatherForecastSlot(value: randomNumber, image: UIImage(named: "023.png"), description: "Rain and snow",chance: randomChance);
        case 17:
            // heavy clouds
            slot = WeatherForecastSlot(value: randomNumber, image: UIImage(named: "032.png"), description: "Heavy clouds",chance: randomChance);
        case 18:
            // sunny
            slot = WeatherForecastSlot(value: randomNumber, image: UIImage(named: "001.png"), description: "Sunny",chance: randomChance);
        case 19:
            // sunny
            slot = WeatherForecastSlot(value: randomNumber, image: UIImage(named: "001.png"), description: "Sunny",chance: randomChance);
        case 20:
            // sunny
            slot = WeatherForecastSlot(value: randomNumber, image: UIImage(named: "001.png"), description: "Sunny",chance: randomChance);
        default:
            // sunny
            slot = WeatherForecastSlot(value: randomNumber, image: UIImage(named: "001.png"), description: "Sunny",chance: randomChance);
        }
        //println(slot.chance);
        return slot;
    }
    
    class func alterWeather(slot:WeatherForecastSlot) -> String {
        var currentWeather = "";
        println("current weather chance: \(slot.chance)");
        if (slot.chance > 0.60) {
            // retain the defaulted weather.
            currentWeather = slot.description;
        } else if (slot.chance < 0.20) {
            currentWeather = "Sunny";
        } else {
            // alter it a little.
            println("altering weather...");
            switch slot.value {
            case 0:
                // sunny
                currentWeather = "Light clouds";
            case 1:
                // Very cloudy
                currentWeather = "Cloudy";
            case 2:
                // sunny light clouds
                currentWeather = "Mostly cloudy"
            case 3:
                // mostly cloudy
                currentWeather = "Light clouds";
            case 4:
                // sunny with some rain
                currentWeather = "Heavy rain";
            case 5:
                // light rain
                currentWeather = "Sunny";
            case 6:
                // rain
                currentWeather = "Heavy rain";
            case 7:
                // heavy rain
                currentWeather = "Light rain";
            case 8:
                // rain and lightning
                currentWeather = "Rain";
            case 9:
                // lightning
                currentWeather = "Rain";
            case 10:
                // light hail
                currentWeather = "Sunny";
            case 11:
                // hail
                currentWeather = "Heavy hail";
            case 12:
                // heavy hail
                currentWeather = "Hail";
            case 13:
                // light snow
                currentWeather = "Cold";
            case 14:
                // snow
                currentWeather = "Light snow";
            case 15:
                // heavy snow
                currentWeather = "Blizzard";
            case 16:
                // rain and snow
                currentWeather = "Sunny";
            case 17:
                // heavy clouds
                currentWeather = "Cloudy";
            case 18:
                // sunny
                currentWeather = "Partly cloudy";
            case 19:
                // sunny
                currentWeather = "Rain";
            case 20:
                // sunny
                currentWeather = "Windy";
            default:
                currentWeather = slot.description;
            }
        }
        println("weather is now: \(currentWeather)");
        return currentWeather;
    }
}