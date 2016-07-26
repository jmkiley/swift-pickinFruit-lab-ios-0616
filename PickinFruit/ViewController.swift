//
//  ViewController.swift
//  PickinFruit
//
//  Created by Flatiron School on 7/17/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var spinButton: UIButton!
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBOutlet weak var fruitPicker: UIPickerView!
    
    var numberOfRows = 1000
    var numberOfComponents = 3
    var fruitsArray = ["🍎", "🍊", "🍌", "🍐", "🍇", "🍉", "🍓", "🍒", "🍍"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.fruitPicker.accessibilityLabel = Constants.FRUIT_PICKER
        self.spinButton.accessibilityLabel = Constants.SPIN_BUTTON
        self.fruitPicker.delegate = self
        self.fruitPicker.dataSource = self
        
    }
    
    @IBAction func spinButtonTapped(sender: UIButton) {
        chooseFruit()
        let firstFruit = self.fruitPicker.selectedRowInComponent(0) % self.fruitsArray.count
        let secondFruit = self.fruitPicker.selectedRowInComponent(1) % self.fruitsArray.count
        let thirdFruit = self.fruitPicker.selectedRowInComponent(2) % self.fruitsArray.count
        
        switch self.fruitsArray[firstFruit] == self.fruitsArray[secondFruit] && self.fruitsArray[firstFruit] == self.fruitsArray[thirdFruit] {
        case true :
            self.resultLabel.text = "WINNER!"
        default:
            self.resultLabel?.text = "TRY AGAIN"
        }
        
    }
    
    func chooseFruit() {
        for i in 0..<numberOfComponents {
            let randomNumber = arc4random_uniform(UInt32(numberOfRows))
            fruitPicker.selectRow(Int(randomNumber), inComponent: i, animated: true)
            print("Component: \(i) Random Number: \(randomNumber)")
        }
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return numberOfComponents
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return numberOfRows
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.fruitsArray[row % self.fruitsArray.count]
    }
}

// MARK: Set Up
extension ViewController {
    
    override func viewDidLayoutSubviews() {
        if self.spinButton.layer.cornerRadius == 0.0 {
            configureButton()
        }
    }
    
    func configureButton()
    {
        self.spinButton.layer.cornerRadius = 0.5 * self.spinButton.bounds.size.width
        self.spinButton.layer.borderColor = UIColor.whiteColor().CGColor
        self.spinButton.layer.borderWidth = 4.0
        self.spinButton.clipsToBounds = true
    }
    
}



