//
//  WeatherForecastSlot.swift
//  Lemonade Stand
//
//  Created by ADRIAN HERRERA on 12/27/14.
//  Copyright (c) 2014 After Works Projects. All rights reserved.
//

import Foundation
import UIKit

struct WeatherForecastSlot {
    var value = 0; // weather value, maybe a sort by severity, 0 = sunny, 10 = stormy for example.
    var image = UIImage(named: ""); // when working with image assets you don't need the extension
                                    // Swift will automatically know which to use for each device.
    var description = ""; // describes the weather, for the game summary.
    var chance:Float = 0.0; // chance of this weather forecast actually happening on "today".
}