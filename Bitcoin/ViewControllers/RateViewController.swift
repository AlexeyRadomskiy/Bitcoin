//
//  RateViewController.swift
//  Bitcoin
//
//  Created by Alexey on 18.03.2022.
//

import UIKit
import Alamofire

class RateViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var rateLabel: UILabel!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var currencySegmentedControl: UISegmentedControl!
    
    private var bitcoin: [Bitcoin] = []
    private var code = "USD"
    
    override func viewDidLoad() {
        
        title = ""
        
        imageView.image = UIImage(named: "Bitcoin")
        
        dateLabel.isHidden = true
        rateLabel.isHidden = true
        
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        
        currencySegmentedControl.setTitleTextAttributes(
            [NSAttributedString.Key.foregroundColor: UIColor.black,
             NSAttributedString.Key.font: UIFont.systemFont(ofSize: 26)],
            for: .normal)
        
        downloadData()
    }
    
    @IBAction func refreshButton() {
        downloadData()
    }
    
    @IBAction func currencySelection() {
        downloadData()
    }
    
    private func downloadData() {
        NetworkManager.shared.fetchDataWithAlamofire { results in
            switch results {
            case .success(let bitcoin):
                self.activityIndicator.isHidden = false
                self.activityIndicator.startAnimating()
                self.title = bitcoin.chartName
                self.dateLabel.text = bitcoin.time.updateduk
                self.rateLabel.text = "\(bitcoin.bpi.USD.rate_float ?? 0)"
//                if self.currencySegmentedControl.selectedSegmentIndex == 0 {
//                    self.rateLabel.text = "\(bitcoin.bpi.USD.rate_float ?? 0) $"
//                } else {
//                    self.rateLabel.text = "\(bitcoin.bpi.EUR.rate_float ?? 0) €"
//                }
                self.activityIndicator.stopAnimating()
                self.activityIndicator.isHidden = true
                self.dateLabel.isHidden = false
                self.rateLabel.isHidden = false
            case .failure(let error):
                print(error)
            }
        }
    }
}
