//
//  GameStatistics.swift
//  Lemonade Stand
//
//  Created by ADRIAN HERRERA on 12/30/14.
//  Copyright (c) 2014 After Works Projects. All rights reserved.
//

import Foundation

class GameStatistics {
    var initialCash:Double = 10.0;
    var cash:Double = 10.0;
    var lemons:Int = 1;
    var lemonsToBuy:Int = 0;
    var lemonsPrice:Double = 2.0;
    var ice:Int = 1;
    var iceToBuy:Int = 0;
    var icePrice:Double = 1.0;
    var salePrice:Double = 1.50;
    var currentCustomerCount:Int = 0;
    var gameStarted:Bool = false;
    var currentCustomerPuchasedCount:Int = 0;
    var totalCustomerCount:Int = 0;
    var totalCustomerPurchasedCount:Int = 0;
    var slots:[WeatherForecastSlot] = [];
    var messages:String = "";
}