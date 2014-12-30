//
//  ViewController.swift
//  Lemonade Stand
//
//  Created by ADRIAN HERRERA on 12/26/14.
//  Copyright (c) 2014 After Works Projects. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {

    var firstContainer:UIView! // ! = un-wraps the object.
    var secondContainer:UIView!
    var thirdContainer:UIView!
    var fourthContainer:UIView!
    var fifthContainer:UIView!
    var sixthContainer:UIView!
    
    let kMarginForView:CGFloat = 10.0; // constant, accessible to this class only.
    // if the variable name starts with a lowercase 'k'
    // it indicates it's a constant to other programmers.
    let kMarginForSlot:CGFloat = 2.0;
    
    let kSixth:CGFloat = 1.0/6.0;
    let kThird:CGFloat = 1.0/3.0;
    let kHalf:CGFloat = 1.0/2.0;
    let kEigth:CGFloat = 1.0/8.0;
    let kTenth:CGFloat = 1.0/10.0;
    let kTwentieth:CGFloat = 1.0/20.0;

    var lemonsLabel:UILabel!
    var iceLabel:UILabel!
    var coinLabel:UILabel!
    var summaryLabel:UILabel!
    
    var lemonsTextField:UITextField!
    var iceTextField:UITextField!
    
    var shopCartButton:UIButton!
    
    var titleImage:UIImage! // game title
    var shopCartEmptyImage:UIImage!
    var shopCartNotEmptyImage:UIImage!
    
    var gameStats:GameStatistics = GameStatistics();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupContainerViews();
        setupFirstContainer(firstContainer);
        setupSecondContainer(secondContainer);
        setupThirdContainer(thirdContainer);
        setupFourthContainer(fourthContainer);
        setupFifthContainer(fifthContainer);
        setupSixthContainer(sixthContainer);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /**
     * Configure the dimensions for each container (or sectioned placeholder).
     */
    func setupContainerViews() {
        // frame is relative to the super view.
        // self.view = super view for the 'xxxxxContainer'
        /*
         * FIRST CONTAINER - Title
         */
        self.firstContainer = UIView(
            frame: CGRect(
                x: self.view.bounds.origin.x + kMarginForView,
                y: self.view.bounds.origin.y + kMarginForView * 2,
                width: self.view.bounds.width - (kMarginForView * 2),
                height: self.view.bounds.height * kSixth));
        // set the background color.
        self.firstContainer.backgroundColor = UIColor.yellowColor();
        // add the view to the current view.
        self.view.addSubview(firstContainer);
        /*
         * SECOND CONTAINER - 5 Day Forecast
         */
        self.secondContainer = UIView(
            frame: CGRect(
                x: self.view.bounds.origin.x + kMarginForView,
                y: firstContainer.frame.height,
                width: self.view.bounds.width - (kMarginForView * 2),
                height: CGFloat(45))); // width & height of the images are 40x40
        // set background color
        secondContainer.backgroundColor = UIColor.blackColor();
        // add view
        self.view.addSubview(secondContainer);
        /*
         * THIRD CONTAINER - Current Inventory
         */
        self.thirdContainer = UIView(
            frame: CGRect(
                x: self.view.bounds.origin.x + kMarginForView,
                y: firstContainer.frame.height + secondContainer.frame.height,
                width: self.view.bounds.width - (kMarginForView * 2),
                height: self.view.bounds.height * kEigth));
        thirdContainer.backgroundColor = UIColor.lightGrayColor();
        self.view.addSubview(thirdContainer);
        /*
         * FOURTH CONTAINER - Purchase Supplies (ice/lemons)
         */
        self.fourthContainer = UIView(
            frame: CGRect(
                x: self.view.bounds.origin.x + kMarginForView,
                y: firstContainer.frame.height + secondContainer.frame.height + thirdContainer.frame.height,
                width: self.view.bounds.width - (kMarginForView * 2),
                height: self.view.bounds.height * kTenth));
        fourthContainer.backgroundColor = UIColor.blackColor();
        self.view.addSubview(fourthContainer);
        
        var nextContainerY = firstContainer.frame.height +
            secondContainer.frame.height +
            thirdContainer.frame.height +
            fourthContainer.frame.height;
        /*
         * FIFTH CONTAINER - Today's Sales Report - Today's "Actual" Weather
         */
        self.fifthContainer = UIView(
            frame: CGRect(
                x: self.view.bounds.origin.x + kMarginForView,
                y: nextContainerY,
                width: self.view.bounds.width - (kMarginForView * 2),
                height: self.view.bounds.height * kSixth * 2));
        fifthContainer.backgroundColor = UIColor.brownColor();
        self.view.addSubview(fifthContainer);
        
        nextContainerY = firstContainer.frame.height +
            secondContainer.frame.height +
            thirdContainer.frame.height +
            fourthContainer.frame.height +
            fifthContainer.frame.height;
        
        /*
        * SIXTH CONTAINER - Menu Items / Toolbar Menu Items
        */
        self.sixthContainer = UIView(
            frame: CGRect(
                x: self.view.bounds.origin.x + kMarginForView,
                y: nextContainerY,
                width: self.view.bounds.width - (kMarginForView * 2),
                height: self.view.bounds.height * kSixth));
        sixthContainer.backgroundColor = UIColor.orangeColor();
        self.view.addSubview(sixthContainer);
    }
    
    /**
     * Populate the first container with a title.
     */
    func setupFirstContainer(containerView: UIView) {
        var imageView = UIImageView();
        titleImage = UIImage(
            named: "lemonade_stand_title.png");
        imageView.contentMode = .ScaleAspectFit
        imageView.image = titleImage;
        imageView.backgroundColor = UIColor.whiteColor();
        imageView.frame = CGRect(
            x: containerView.bounds.origin.x,
            y: containerView.bounds.origin.y,
            width: containerView.bounds.width,
            height: containerView.bounds.height);
        containerView.addSubview(imageView);
    }
    
    /**
     * Populate the second container. This will be a 5-day weather forecast.
     * As each day passes, the weather given will have a percent of actually happening. 
     * Today's weather will be the 1st slot. The next 4 slots will be tomorrow and so-on.
     * As each day passes, each slot will shift one to the left, and the 5th slot will be 
     * given a new forecasted "value".
     *
     * Note to self: this is one heck of a challenge to attempt!
     */
    func setupSecondContainer(containerView: UIView) {
        // build the 5 slots first. Use the math samples given in the slot machine project.
        // create the WeatherSlot class and have it use the class functions.
        if (gameStats.slots.count < 1) {
            gameStats.slots = WeatherForecastFactory.createInitialForecasts();
        }
        
        if (gameStats.slots.count < 1) {
            println("do not have weather forecasts ready!");
        }
        //println(slots);
        for (var count = 0; count < gameStats.slots.count; count++) {
            // add image placeholders for all 5 slots.
            var slotImageView = UIImageView();
            slotImageView.image = gameStats.slots[count].image;
            var imageWidth = gameStats.slots[count].image?.size.width;
            var imageHeight = gameStats.slots[count].image?.size.height;
            slotImageView.backgroundColor = UIColor.whiteColor();
            slotImageView.frame = CGRect(
                x: CGFloat(imageWidth!) * CGFloat(count) + CGFloat(25 * (count+1)),
                y: 0, // always at the top
                width: CGFloat(imageWidth!),
                height: CGFloat(imageHeight!));
//            println(count);
//            println(slotImageView.frame.origin.x);
//            println(slotImageView.frame.origin.y);
            // Add slot to view.
            containerView.backgroundColor = UIColor.whiteColor();
            containerView.addSubview(slotImageView);
        }
    }
    
    func updateSecondContainer(containerView:UIView) {
        removeSlotImageViews(containerView);
        for (var s = 1; s < gameStats.slots.count; s++) {
            gameStats.slots[s - 1] = gameStats.slots[s];
        }
        gameStats.slots[gameStats.slots.count - 1] = WeatherForecastFactory.createWeatherForecastSlot();
        setupSecondContainer(containerView);
    }
    
    func removeSlotImageViews(containerView:UIView) {
        for view in containerView.subviews { // ! = unwrap the object for use.
            view.removeFromSuperview();
        }
    }
    
    /**
     * Populate the third container with the current inventory.
     * initially, the player will have the following: 
     * cash in hand : $10
     * lemon count  :   1
     * ice count    :   1
     */
    func setupThirdContainer(containerView: UIView) {
        containerView.backgroundColor = UIColor.whiteColor();
        // Coin image
        var coinImage = UIImage(named: "coins.png");
        var imageWidth = coinImage?.size.width;
        var imageHeight = coinImage?.size.height;
        
        var coinImageView = UIImageView();
        coinImageView.image = coinImage;
        coinImageView.backgroundColor = UIColor.whiteColor();
        coinImageView.frame = CGRect(
            x: 75, // always at the left
            y: 0, // always at the top
            width: CGFloat(imageWidth!),
            height: CGFloat(imageHeight!));
        containerView.addSubview(coinImageView);
        // Coin label
        coinLabel = UILabel();
        coinLabel.font = UIFont(
            name: "Menlo-Bold",
            size: 16);
        coinLabel.text = "\(gameStats.cash)";
        coinLabel.sizeToFit();
        coinLabel.frame = CGRect(
            x: 75,
            y: CGFloat(coinImageView.frame.height + 15),
            width: coinLabel.frame.width,
            height: coinLabel.frame.height);
        coinLabel.textAlignment = NSTextAlignment.Left;
        coinLabel.textColor = UIColor.redColor();
        containerView.addSubview(coinLabel);
        
        // Lemon count image
        var lemonImage = UIImage(named: "1lemon.png");
        imageWidth = lemonImage?.size.width;
        imageHeight = lemonImage?.size.height;
        
        var lemonImageView = UIImageView();
        lemonImageView.image = lemonImage;
        lemonImageView.backgroundColor = UIColor.whiteColor();
        lemonImageView.frame = CGRect(
            x: CGFloat(coinImageView.frame.origin.x + coinImageView.frame.width + 50),
            y: 0, //CGFloat(coinImageView.frame.height + 20),
            width: CGFloat(imageWidth!),
            height: CGFloat(imageHeight!));
        containerView.addSubview(lemonImageView);
        // Lemon count label
        lemonsLabel = UILabel();
        lemonsLabel.font = UIFont(
            name: "Menlo-Bold",
            size: 16);
        lemonsLabel.text = "\(gameStats.lemons)";
        lemonsLabel.sizeToFit();
        lemonsLabel.frame = CGRect(
            x: CGFloat(coinImageView.frame.origin.x + coinImageView.frame.width + 50),
            y: CGFloat(lemonImageView.frame.height + 15),
            width: lemonsLabel.frame.width,
            height: lemonsLabel.frame.height);
        lemonsLabel.textAlignment = NSTextAlignment.Left;
        lemonsLabel.textColor = UIColor.redColor();
        containerView.addSubview(lemonsLabel);
        // Ice count image
        var iceImage = UIImage(named: "ice_cube.png");
        imageWidth = iceImage?.size.width;
        imageHeight = iceImage?.size.height;
        
        var iceImageView = UIImageView();
        iceImageView.image = iceImage;
        iceImageView.backgroundColor = UIColor.whiteColor();
        iceImageView.frame = CGRect(
            x: CGFloat(lemonImageView.frame.origin.x + lemonImageView.frame.width + 50),
            y: 0,
            width: CGFloat(imageWidth!),
            height: CGFloat(imageHeight!));
        containerView.addSubview(iceImageView);
        // Ice count label
        iceLabel = UILabel();
        iceLabel.font = UIFont(
            name: "Menlo-Bold",
            size: 16);
        iceLabel.text = "\(gameStats.ice)";
        iceLabel.sizeToFit();
        iceLabel.frame = CGRect(
            x: CGFloat(lemonImageView.frame.origin.x +  lemonImageView.frame.width + 50),
            y: CGFloat(iceImageView.frame.height + 15),
            width: iceLabel.frame.width,
            height: iceLabel.frame.height);
        iceLabel.textAlignment = NSTextAlignment.Left;
        iceLabel.textColor = UIColor.redColor();
        containerView.addSubview(iceLabel);
    }
    
    func setupFourthContainer(containerView: UIView) {
        containerView.backgroundColor = UIColor.whiteColor();
        // add icon + text imput + remove icon
        var lemonsAddImage = UIImage(named: "add.png");
        var imageWidth = lemonsAddImage?.size.width;
        var imageHeight = lemonsAddImage?.size.height;
        
        var lemonsPurchaseLabel = UILabel();
        lemonsPurchaseLabel.text = "Lemons $\(gameStats.lemonsPrice)/ea:";
        lemonsPurchaseLabel.textColor = UIColor.blackColor();
        //lemonsPurchaseLabel.backgroundColor = UIColor.yellowColor();
        lemonsPurchaseLabel.frame = CGRect(
            x: 0,
            y: 0,
            width: 150,
            height: (imageHeight! / 2));
        containerView.addSubview(lemonsPurchaseLabel);
        
        var lemonsAddButton = UIButton();
        lemonsAddButton.frame = CGRect(
            x: lemonsPurchaseLabel.frame.origin.x + lemonsPurchaseLabel.frame.width + 15,
            y: 0,
            width: CGFloat(imageWidth! / 2),
            height: CGFloat(imageHeight! / 2));
        lemonsAddButton.setImage(lemonsAddImage, forState: UIControlState.Normal);
        lemonsAddButton.addTarget(
            self,
            action: "addLemons:",
            forControlEvents: UIControlEvents.TouchUpInside);
        containerView.addSubview(lemonsAddButton);
        
        lemonsTextField = UITextField();
        lemonsTextField.text = "\(gameStats.lemonsToBuy)";
        lemonsTextField.frame = CGRect(
            x: lemonsAddButton.frame.origin.x + lemonsAddButton.frame.width + 10,
            y: 0,
            width: 25,
            height: lemonsAddButton.frame.height);
        var bgColor : UIColor = UIColor( red: 0.5, green: 0.8, blue:0, alpha: 0.4 );
        lemonsTextField.backgroundColor = bgColor;
        lemonsTextField.layer.borderColor = UIColor.redColor().CGColor;
        lemonsTextField.textAlignment = NSTextAlignment.Center;
        containerView.addSubview(lemonsTextField);
        
        var LemonsRemoveButton = UIButton();
        var lemonsRemoveImage = UIImage(named: "remove.png");
        imageWidth = lemonsRemoveImage?.size.width;
        imageHeight = lemonsRemoveImage?.size.height;
        LemonsRemoveButton.frame = CGRect(
            x: lemonsTextField.frame.origin.x + lemonsTextField.frame.width + 10,
            y: 0,
            width: CGFloat(imageWidth! / 2),
            height: CGFloat(imageHeight! / 2));
        LemonsRemoveButton.setImage(lemonsRemoveImage, forState: UIControlState.Normal);
        LemonsRemoveButton.addTarget(
            self,
            action: "removeLemons:",
            forControlEvents: UIControlEvents.TouchUpInside);
        containerView.addSubview(LemonsRemoveButton);
        
        var icePurchaseLabel = UILabel();
        icePurchaseLabel.text = "Ice $\(gameStats.icePrice)/ea:";
        icePurchaseLabel.textColor = UIColor.blackColor();
        icePurchaseLabel.frame = CGRect(
            x: 0,
            y: (imageHeight! / 2) + 5,
            width: 150,
            height: (imageHeight! / 2));
        containerView.addSubview(icePurchaseLabel);
        
        var iceAddButton = UIButton();
        var iceAddImage = UIImage(named: "add.png");
        imageWidth = lemonsAddImage?.size.width;
        imageHeight = lemonsAddImage?.size.height;
        iceAddButton.frame = CGRect(
            x: icePurchaseLabel.frame.origin.x + icePurchaseLabel.frame.width + 15,
            y: (imageHeight! / 2) + 5,
            width: CGFloat(imageWidth! / 2),
            height: CGFloat(imageHeight! / 2));
        iceAddButton.setImage(iceAddImage, forState: UIControlState.Normal);
        iceAddButton.addTarget(
            self,
            action: "addIce:",
            forControlEvents: UIControlEvents.TouchUpInside);
        containerView.addSubview(iceAddButton);
        
        iceTextField = UITextField();
        iceTextField.text = "\(gameStats.iceToBuy)";
        iceTextField.frame = CGRect(
            x: iceAddButton.frame.origin.x + iceAddButton.frame.width + 10,
            y: (imageHeight! / 2) + 5,
            width: 25,
            height: iceAddButton.frame.height);
        bgColor = UIColor( red: 0.5, green: 0.8, blue:0, alpha: 0.4 );
        iceTextField.backgroundColor = bgColor;
        iceTextField.layer.borderColor = UIColor.redColor().CGColor;
        iceTextField.textAlignment = NSTextAlignment.Center;
        containerView.addSubview(iceTextField);
        
        var iceRemoveButton = UIButton();
        var iceRemoveImage = UIImage(named: "remove.png");
        imageWidth = iceRemoveImage?.size.width;
        imageHeight = iceRemoveImage?.size.height;
        iceRemoveButton.frame = CGRect(
            x: iceTextField.frame.origin.x + iceTextField.frame.width + 10,
            y: (imageHeight! / 2) + 5,
            width: CGFloat(imageWidth! / 2),
            height: CGFloat(imageHeight! / 2));
        iceRemoveButton.setImage(iceRemoveImage, forState: UIControlState.Normal);
        iceRemoveButton.addTarget(
            self,
            action: "removeIce:",
            forControlEvents: UIControlEvents.TouchUpInside);
        containerView.addSubview(iceRemoveButton);
        
        // shopping cart image/button
        shopCartButton = UIButton();
        shopCartEmptyImage = UIImage(named: "044.png");
        imageWidth = shopCartEmptyImage?.size.width;
        imageHeight = shopCartEmptyImage?.size.height;
        shopCartButton.frame = CGRect(
            x: iceRemoveButton.frame.origin.x + iceRemoveButton.frame.width + 30,
            y: LemonsRemoveButton.frame.origin.y,
            width: CGFloat(imageWidth!),
            height: CGFloat(imageHeight!));
        shopCartButton.setImage(shopCartEmptyImage, forState: UIControlState.Normal);
        shopCartButton.addTarget(
            self,
            action: "purchaseItems:",
            forControlEvents: UIControlEvents.TouchUpInside);
        containerView.addSubview(shopCartButton);
    }
    
    /**
     * Populate the fifth container - Game Summary screen.
     */
    func setupFifthContainer(containerView:UIView) {
        containerView.backgroundColor = UIColor.whiteColor();
        summaryLabel = UILabel();
        summaryLabel.textColor = UIColor.blueColor();
        summaryLabel.font = UIFont(name: "Arial", size: 14);
        summaryLabel.numberOfLines = 0;
        summaryLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping;
        updateGameSummaryLabel();
        containerView.addSubview(summaryLabel);
    }
    

    
    /**
     * Populate the sixth container - toolbar options/items.
     * Would like to figure out how to programmatically add the flexible space bar to this...
     */
    func setupSixthContainer(containerView:UIView) {
        containerView.backgroundColor = UIColor.whiteColor();
        // add the "restart" button. This will reset everything.
        var resetButton = UIButton();
        var resetImage = UIImage(named: "undo.png");
        var imageWidth = resetImage?.size.width;
        var imageHeight = resetImage?.size.height;
        resetButton.setImage(resetImage, forState: UIControlState.Normal);
        resetButton.frame = CGRect(
            x: ((containerView.frame.width - (kMarginForView * 2)) / 2) - (imageWidth! + 15),
            y: 0,
            width: CGFloat(imageWidth!),
            height: CGFloat(imageHeight!));
        resetButton.addTarget(
            self,
            action: "resetGame:",
            forControlEvents: UIControlEvents.TouchUpInside);
        containerView.addSubview(resetButton);
        // add the play button. this is the "start day" button.
        var startDayButton = UIButton();
        var startDayImage = UIImage(named: "play.png");
        imageWidth = startDayImage?.size.width;
        imageHeight = startDayImage?.size.height;
        startDayButton.setImage(startDayImage, forState: UIControlState.Normal);
        startDayButton.frame = CGRect(
            x: ((containerView.frame.width - (kMarginForView * 2)) / 2) + (imageWidth! + 15),
            y: 0,
            width: CGFloat(imageWidth!),
            height: CGFloat(imageHeight!));
        startDayButton.addTarget(
            self,
            action: "startDay:",
            forControlEvents: UIControlEvents.TouchUpInside);
        containerView.addSubview(startDayButton);
    }
    
    /**
     * Alerts
     * = "Warning" overrides empty value. message is required
     */
    func showAlertWithText(header:String = "Warning", message:String) {
        var alert = UIAlertController(title: header, message: message, preferredStyle: UIAlertControllerStyle.Alert);
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil));
        self.presentViewController(alert, animated: true, completion: nil);
    }
    
    /*********************
     * IBActions
     *********************/
    
    func resetGame(button:UIButton) {
        println("resetting the game");
        gameStats.ice = 1;
        gameStats.lemons = 1;
        summaryLabel.text = "";
        gameStats.cash = 10.0;
        coinLabel.text = "\(gameStats.cash)";
        iceLabel.text = "\(gameStats.ice)";
        lemonsLabel.text = "\(gameStats.lemons)";
        gameStats.slots = WeatherForecastFactory.createInitialForecasts();
        updateSecondContainer(secondContainer);
        gameStats.totalCustomerCount = 0;
        gameStats.totalCustomerPurchasedCount = 0;
        showAlertWithText(header: "Game Reset", message: "Starting over.");
    }
    
    /**

     */
    func startDay(button:UIButton) {
        if (!gameStats.gameStarted) {
            gameStats.gameStarted = true;
        }
        if (gameStats.ice == 0 || gameStats.lemons == 0) {
            showAlertWithText(header: "Mix Required!", message: "You can't make lemonade without lemons and ice.");
            return;
        }
        gameStats = TheBrain.processDay(gameStats);
        // display 5-day forecast. Has it changed?
        for (var s = 0; s < gameStats.slots.count; s++) {
            println("\(gameStats.slots[s].value) weather: \(gameStats.slots[s].description) chance: \(gameStats.slots[s].chance)");
        }
        // update the labels
        coinLabel.text = "\(gameStats.cash)";
        lemonsLabel.text = "\(gameStats.lemons)";
        iceLabel.text = "\(gameStats.ice)";
        updateGameSummaryLabel();
        // update weather images
        updateSecondContainer(secondContainer);
        // check to see if the game is over or not
        checkGameStatus();

    }
    
    func checkGameStatus() {
        println("cash on hand: \(gameStats.cash), ice price: \(gameStats.icePrice) lemon price: \(gameStats.lemonsPrice)");
        if (gameStats.cash < gameStats.icePrice && gameStats.cash < gameStats.lemonsPrice) {
            // not enough cash to continue.
            showAlertWithText(header: "Game Over", message: "You ran out of money.");
        }
        if (gameStats.cash < (gameStats.icePrice + gameStats.lemonsPrice)) {
            showAlertWithText(header: "Game Over", message: "You must have enough cash\nfor at least 1 of\neach item.");
        }
        
    }
    
    func updateGameSummaryLabel() {
        // first we give today's results.
        //        summaryLabel.text = "This is where the game summary goes...";
        summaryLabel.text = ""; // clear the text
        
        if (gameStats.gameStarted) {
            summaryLabel.text = "Today's Summary:";
            summaryLabel.text = summaryLabel.text! + "\n\nActual Weather: "+gameStats.slots[0].description;
            summaryLabel.text = summaryLabel.text! + "\n\(gameStats.currentCustomerCount) customers visited your lemonade stand.";
            summaryLabel.text = summaryLabel.text! + "\n\(gameStats.currentCustomerPuchasedCount) customers bought your lemonade.";
            // next we give a summary of the game totals.
            summaryLabel.text = summaryLabel.text! + "\n\nGame Summary:";
            summaryLabel.text = summaryLabel.text! + "\n\n\(gameStats.totalCustomerCount) customers have visited your stand.";
            summaryLabel.text = summaryLabel.text! + "\n\(gameStats.totalCustomerPurchasedCount) customers have bought your lemonade.";
            if (gameStats.initialCash > gameStats.cash) {
                summaryLabel.text = summaryLabel.text! + "\nYou have lost $\(gameStats.initialCash - gameStats.cash) revenue.";
            } else if (gameStats.initialCash == gameStats.cash) {
                summaryLabel.text = summaryLabel.text! + "\nYou have matched your initial revnue.";
            } else {
                summaryLabel.text = summaryLabel.text! + "\nYou have gained $\(gameStats.cash - gameStats.initialCash) revenue.";
            }
        }
        summaryLabel.sizeToFit();
    }
    
    func purchaseItems(button:UIButton) {
        // adjust counts in the "current supplies" container view.
        gameStats.ice += gameStats.iceToBuy;
        iceLabel.text = "\(gameStats.ice)";
        gameStats.lemons += gameStats.lemonsToBuy;
        lemonsLabel.text = "\(gameStats.lemons)";
        // reset the "purchase" container values.
        resetShopCart();
    }
    
    func addLemons(button:UIButton) {
        if (gameStats.cash >= gameStats.lemonsPrice) {
            gameStats.lemonsToBuy += 1;
            gameStats.cash -= gameStats.lemonsPrice;
            lemonsTextField.text = "\(gameStats.lemonsToBuy)";
            coinLabel.text = "\(gameStats.cash)";
        } else {
            showAlertWithText(message: "You need more cash!");
        }
        updateShopCartImage();
    }
    
    func removeLemons(button:UIButton) {
        if (gameStats.lemonsToBuy > 0) {
            gameStats.lemonsToBuy -= 1;
            gameStats.cash += gameStats.lemonsPrice;
            lemonsTextField.text = "\(gameStats.lemonsToBuy)";
            coinLabel.text = "\(gameStats.cash)";
        }
        updateShopCartImage();
    }
    
    func addIce(button:UIButton) {
        if (gameStats.cash >= gameStats.icePrice) {
            gameStats.iceToBuy += 1;
            gameStats.cash -= gameStats.icePrice;
            iceTextField.text = "\(gameStats.iceToBuy)";
            coinLabel.text = "\(gameStats.cash)";
        } else {
            showAlertWithText(message: "You need more cash!");
        }
        updateShopCartImage();
    }
    
    func removeIce(button:UIButton) {
        if (gameStats.iceToBuy > 0) {
            gameStats.iceToBuy -= 1;
            gameStats.cash += gameStats.icePrice;
            iceTextField.text = "\(gameStats.iceToBuy)";
            coinLabel.text = "\(gameStats.cash)";
        }
        updateShopCartImage();
    }
    
    func resetShopCart() {
        gameStats.iceToBuy = 0;
        iceTextField.text = "\(gameStats.iceToBuy)";
        gameStats.lemonsToBuy = 0;
        lemonsTextField.text = "\(gameStats.lemonsToBuy)";
        updateShopCartImage();
    }
    
    func updateShopCartImage() {
        if (shopCartNotEmptyImage == nil) {
            shopCartNotEmptyImage = UIImage(named: "045.png");
        }
        if (gameStats.iceToBuy > 0 || gameStats.lemonsToBuy > 0) {
            shopCartButton.setImage(shopCartNotEmptyImage, forState: UIControlState.Normal);
        } else {
            shopCartButton.setImage(shopCartEmptyImage, forState: UIControlState.Normal);
        }
    }

}

