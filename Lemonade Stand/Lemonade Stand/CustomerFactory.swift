//
//  CustomerFactory.swift
//  Lemonade Stand
//
//  Created by ADRIAN HERRERA on 12/29/14.
//  Copyright (c) 2014 After Works Projects. All rights reserved.
//

import Foundation

class CustomerFactory {
    
    class func generateCustomers() -> [Customer] {
        var customerCount = Int(arc4random_uniform(UInt32(10)));
        println("number of customers for the day: \(customerCount)");
        
        var customerArray:[Customer] = [];
        
        for (var c = 0; c < customerCount; c++) {
            customerArray.append(createCustomer(c));
        }
        
        return customerArray;
    }
    
    class func createCustomer(num:Int) -> Customer {
        var customer:Customer = Customer();
        customer.customerNumber = num;
        customer.favoredRatio = (Float(arc4random_uniform(UInt32(99))) / 100);
        return customer;
    }
}