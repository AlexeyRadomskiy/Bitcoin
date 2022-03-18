//
//  RateViewController.swift
//  Bitcoin
//
//  Created by Alexey on 18.03.2022.
//

import UIKit

class RateViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var rateLabel: UILabel!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var currencySegmentedControl: UISegmentedControl!
    
    private var bitcoin: Bitcoin?
    private var code = "USD"
    
    override func viewDidLoad() {
        
        imageView.image = UIImage(named: "Bitcoin")
        
        dateLabel.isHidden = true
        rateLabel.isHidden = true
        
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        
        currencySegmentedControl.setTitleTextAttributes(
            [NSAttributedString.Key.foregroundColor: UIColor.black,
             NSAttributedString.Key.font: UIFont.systemFont(ofSize: 26)],
            for: .normal)
        
        fetchData()
    }
    
    @IBAction func refreshButton() {
        fetchData()
    }
    
    @IBAction func currencySelection() {
        fetchData()
    }
    
    private func fetchData() {
        NetworkManager.shared.fetchData { bitcoin in
            self.activityIndicator.isHidden = false
            self.activityIndicator.startAnimating()
            
            self.title = bitcoin.chartName
            self.dateLabel.text = bitcoin.time.updateduk
            if self.currencySegmentedControl.selectedSegmentIndex == 0 {
                self.rateLabel.text = "\(bitcoin.bpi.USD.rate_float ?? 0) $"
            } else {
                self.rateLabel.text = "\(bitcoin.bpi.EUR.rate_float ?? 0) €"
            }
            
            self.activityIndicator.stopAnimating()
            self.activityIndicator.isHidden = true
            self.dateLabel.isHidden = false
            self.rateLabel.isHidden = false
        }
    }
}
