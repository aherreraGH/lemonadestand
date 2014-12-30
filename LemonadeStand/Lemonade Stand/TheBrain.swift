//
//  TheBrain.swift
//  Lemonade Stand
//
//  Created by ADRIAN HERRERA on 12/30/14.
//  Copyright (c) 2014 After Works Projects. All rights reserved.
//

import Foundation

class TheBrain {

    class func processDay(gameStats:GameStatistics) -> GameStatistics {
        gameStats.currentCustomerCount = 0;
        gameStats.currentCustomerPuchasedCount = 0;
        // adjust the weather to have an actual weather
        gameStats.slots[0].description = WeatherForecastFactory.alterWeather(gameStats.slots[0]);
        
        /*
        * When we hit “Start Day” Button, it should create a lemonade ratio that will affect sales,
        * (lemons over ice cubes), i.e. more acidic, equal parts, or less acidic lemonade.
        * For example, if you add 1 lemon and 3 ice cubes the ratio will be .333.
        */
        var ratio:Double = Double(gameStats.lemons) / Double(gameStats.ice);
        println("ratio is: \(ratio)");
        
        /*
        * Still under the start day button, create a random number of customers (between 1 and 10)
        * that will visit your stand for the day.
        */
        var customers:[Customer] = CustomerFactory.generateCustomers();
        gameStats.currentCustomerCount = customers.count;
        /*
        * Change customer count if weather is crappy.
        */
        if (gameStats.slots[0].description.lowercaseString.rangeOfString("snow") != nil ||
            gameStats.slots[0].description.lowercaseString.rangeOfString("blizzard") != nil ||
            gameStats.slots[0].description.lowercaseString.rangeOfString("heavy") != nil ||
            gameStats.slots[0].description.lowercaseString.rangeOfString("hail") != nil) {
                gameStats.currentCustomerCount = 0;
        } else if (gameStats.slots[0].description.lowercaseString.rangeOfString("rain") != nil) {
            println("reducing the count by 20%");
            print("\(gameStats.currentCustomerCount)");
            gameStats.currentCustomerCount = Int(Float(gameStats.currentCustomerCount) * 0.80);
            println(" is now \(gameStats.currentCustomerCount)");
        } else if (gameStats.slots[0].description.lowercaseString.rangeOfString("cold") != nil) {
            println("reducing the count by 40%");
            print("\(gameStats.currentCustomerCount)");
            gameStats.currentCustomerCount = Int(Float(gameStats.currentCustomerCount) * 0.60);
            println(" is now \(gameStats.currentCustomerCount)");
        } else if (gameStats.slots[0].description.lowercaseString.rangeOfString("windy") != nil) {
            println("reducing the count by 10%");
            print("\(gameStats.currentCustomerCount)");
            gameStats.currentCustomerCount = Int(Float(gameStats.currentCustomerCount) * 0.90);
            println(" is now \(gameStats.currentCustomerCount)");
        } else {
            println("No change in customer count today: \(gameStats.slots[0].description)");
        }
        
        if (gameStats.currentCustomerCount == 0) {
            println("no customers showed up today.");
        } else {
            
            /*
            * Then, create a random taste preference(between 0 and 1) for each customer (hint, this
            * should be a constant and you may want to use a type of loop to generate each preference).
            * For example, you might generate 5 customers for the day with preferences as such: 0.5,
            * 0.7, 0.3, 0.4, 0.1
            */
            println(customers[0].customerNumber);
            println(customers[0].favoredRatio);
            /*
            * Then, you should compare your preferences to a range of values, as well as the current
            * lemonade ratio to a separate range of values. Then see if they match. We are not
            * comparing the ratios directly to each other!
            */
            /*
            * You should be comparing your lemonade ratio to a different set of
            * ranges.
            *     Greater than 1 (Acidic Lemonade)
            *     Equal to 1 (Equal Portioned Lemonade)
            *     Less than 1 (Diluted Lemonade)
            */
            var lemonadeRatio:Float = Float(gameStats.ice) / Float(gameStats.lemons);
            println("lemonade has a ratio of: \(lemonadeRatio)");
            if (lemonadeRatio > 1) {
                println("lemonade is acidic");
            } else if (lemonadeRatio == 1) {
                println("lemonade is equally portioned");
            } else {
                println("lemonade is diluted");
            }
            /*
            * You should compare your randomly-generated customer's preferences to 3 different ranges
            * from 0 to 1.
            * The three ranges are:
            *     0 to 0.4 – favors acidic lemonade
            *     0.4 to 0.6 – favors equal parts lemonade
            *     0.6 to 1 – favors diluted lemonade
            */
            for (var c = 0; c < gameStats.currentCustomerCount; c++) {
                if (customers[c].favoredRatio < 0.4) {
                    println("customer [\(customers[c].customerNumber) : \(customers[c].favoredRatio)] favors acidic lemonade");
                    if (lemonadeRatio > 1.00) {
                        println("customer purchased lemonade.");
                        gameStats.cash += gameStats.salePrice;
                        gameStats.currentCustomerPuchasedCount += 1;
                    } else {
                        println("No match, no revenue.");
                    }
                } else if (customers[c].favoredRatio >= 0.4 && customers[c].favoredRatio <= 0.6) {
                    println("customer [\(customers[c].customerNumber) : \(customers[c].favoredRatio)] favors equal parts lemonade");
                    if (lemonadeRatio == 1.00) {
                        println("customer purchased lemonade.");
                        gameStats.cash += gameStats.salePrice;
                        gameStats.currentCustomerPuchasedCount += 1;
                    } else {
                        println("No match, no revenue.");
                    }
                } else {
                    println("customer [\(customers[c].customerNumber) : \(customers[c].favoredRatio)] favors diluted lemonade");
                    if (lemonadeRatio < 1.00) {
                        println("customer purchased lemonade.");
                        gameStats.cash += gameStats.salePrice;
                        gameStats.currentCustomerPuchasedCount += 1;
                    } else {
                        println("No match, no revenue.");
                    }
                }
            }
        }
        gameStats.ice = 0;
        gameStats.lemons = 0;
        // adjust totals
        gameStats.totalCustomerCount += gameStats.currentCustomerCount;
        gameStats.totalCustomerPurchasedCount += gameStats.currentCustomerPuchasedCount;
        // update the summary

        return gameStats;
    }
    
}