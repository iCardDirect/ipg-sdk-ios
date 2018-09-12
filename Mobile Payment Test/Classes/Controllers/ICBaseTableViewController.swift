//
//  ICBaseTableViewController.swift
//  Mobile Payment Test
//
//  Created by Valio Cholakov on 1/16/17.
//  Copyright © 2017 Intercard Finance AD. All rights reserved.
//

import UIKit
import ICCheckout

class ICBaseTableViewController: UITableViewController, ICPaymentDelegate, ICStoreCardDelegate {
    
    // MARK: Constants
    
    private let _HUD = JGProgressHUD(style: .dark)

    
    // MARK: Controller Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.applyTheme()
    }
    
    
    // MARK: Payment Delegate
    
    func paymentDidComplete(withReference transactionReference: String) {
        self.showAlertWithText("Payment completed with reference: \(transactionReference)", popToRoot: true)
    }
    
    func paymentDidFailWithError(_ error: ICCheckoutError) {
        self.showAlertWithText("Payment error: \(error.localizedDescription)")
    }
    
    
    // MARK: Store Card Delegate
    
    func storeCardDidComplete(withData storedCard: ICStoredCard) {
        self.showAlertWithText("Stored card \(storedCard.customName) with token \(storedCard.token)")
    }
    
    func storeCardDidFailWithError(_ error: ICCheckoutError) {
        self.showAlertWithText("Store card error: \(error.localizedDescription)")
    }
    
    func updateStoredCardDidComplete(withData storedCard: ICStoredCard, forCardWithToken cardToken: String) {
        self.showAlertWithText("Updated stored card \(storedCard.customName). New token \(storedCard.token). Old token \(cardToken)")
    }
    
    func updateStoredCardDidFailWithError(_ error: ICCheckoutError) {
        self.showAlertWithText("Update stored card error: \(error.localizedDescription)")
    }
    
    func paymentFailed(error: ICCheckoutError) {
        self.paymentDidFailWithError(error)
    }
    
    func storeCardFailed(error: ICCheckoutError) {
        self.storeCardDidFailWithError(error)
    }
    
    func updateStoredCardFailed(error: ICCheckoutError) {
        self.updateStoredCardDidFailWithError(error)
    }
    
    
    // MARK: Public Methods
    
    func showLoadingHUD() {
        _HUD?.show(in: self.view)
    }
    
    func hideLoadingHUD() {
        self._HUD?.dismiss()
    }
    
    func showAlertWithText(_ text: String) {
        self.showAlertWithText(text, popToRoot: false)
    }
    
    func showAlertWithText(_ text: String, popToRoot: Bool) {
        let alertController = UIAlertController(title: "Demo", message: text, preferredStyle: .alert)
        let okAction        = UIAlertAction(title: "Ok", style: .default) { (_) in
            if popToRoot {
                _ = self.navigationController?.popToRootViewController(animated: true)
            }
        }
        
        alertController.addAction(okAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    // MARK: Private Methods
    
    private func applyTheme() {
        let rgb: CGFloat = 247.0 / 255.0
        
        self.tableView.tableFooterView = UIView()
        self.tableView.backgroundColor = UIColor(red: rgb, green: rgb, blue: rgb, alpha: 1.0)
    }
}