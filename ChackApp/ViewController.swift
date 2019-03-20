//
//  ViewController.swift
//  ChackApp
//
//  Created by Максим Лисица on 16/03/2019.
//  Copyright © 2019 Максим Лисица. All rights reserved.
//

import UIKit
import MessageUI


class ViewController: UIViewController {

    let model = Model()
    
    let mailController = MFMailComposeViewController()
    let messageController = MFMessageComposeViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        citata.text = model.loadJoke()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBOutlet weak var citata: UILabel!
    
    
    
    @IBAction func updateJoke(){
        citata.text = model.loadJoke()
    }
    
    
    @IBAction func pushMessageAction(_ sender: Any) {
        
        messageController.body = citata.text!
        messageController.messageComposeDelegate = self
        
        self.present(messageController, animated: true, completion: nil)
    }
    
    @IBAction func pushMessageMail(_ sender: Any) {
        mailController.setSubject("New Joke From Chuck!")
        mailController.setMessageBody(citata.text!, isHTML: false)
        mailController.mailComposeDelegate = self
        self.present(mailController, animated: true, completion: nil)
    }
    
    
    
}



extension ViewController: MFMailComposeViewControllerDelegate {
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?){
        
        mailController.dismiss(animated: true) {
            var messageText = ""
            switch result{
            case MFMailComposeResult.cancelled: messageText = "Mail was cancelled"
            case MFMailComposeResult.saved: messageText = "Mail was saved"
            case MFMailComposeResult.sent: messageText = "Mail was sent"
            case MFMailComposeResult.failed: messageText = "Mail was failed"
            default: messageText = ""
            }
            
            let alert = UIAlertController(title: messageText, message: "", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    
}

extension ViewController: MFMessageComposeViewControllerDelegate {
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult){
        messageController.dismiss(animated: true) {
            var messageText = ""
            switch result{
            case MessageComposeResult.cancelled: messageText = "Message was cancelled"
            case MessageComposeResult.failed: messageText = "Message was failed"
            case MessageComposeResult.sent: messageText = "Message was sent"
            default: messageText = ""
            }
            
            let alert = UIAlertController(title: messageText, message: "", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
}
