//
//  CommentViewController.swift
//  Photogram
//
//  Created by Bao Nguyen on 9/22/16.
//  Copyright © 2016 Chinh Le. All rights reserved.
//

import UIKit
import JSQMessagesViewController

class CommentViewController: JSQMessagesViewController {
    
    let incomingBubble = JSQMessagesBubbleImageFactory().incomingMessagesBubbleImage(with: UIColor.white)
    let outgoingBubble = JSQMessagesBubbleImageFactory().outgoingMessagesBubbleImage(with: UIColor.clear)
    var messages = [JSQMessage]()

    override func viewDidLoad() {
        super.viewDidLoad()
        inputToolbar.contentView.textView.placeHolder = "Enter your comment"
        inputToolbar.contentView.rightBarButtonItem.setImage(UIImage(named: "icn_send"), for: .normal)
        inputToolbar.contentView.rightBarButtonItem.setTitle("", for: .normal)
        
        let image = UIImage(named: "icn_add")
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: image!.size.width, height: image!.size.height))
        button.setImage(image, for: .normal)
        button.setImage(image, for: .highlighted)
        inputToolbar.contentView.leftBarButtonItem = button
//        inputToolbar.contentView.leftBarButtonItem.setImage(UIImage(named: "icn_add"), for: .normal)
//        inputToolbar.contentView.leftBarButtonItem.setImage(UIImage(named: "icn_add"), for: .highlighted)
//        inputToolbar.contentView.leftBarButtonItem.contentMode = .scaleAspectFit
        
        collectionView.collectionViewLayout.incomingAvatarViewSize = .zero
        collectionView.collectionViewLayout.outgoingAvatarViewSize = .zero
        
        collectionView.collectionViewLayout.messageBubbleFont = UIFont.systemFont(ofSize: 13, weight: UIFontWeightRegular)
        collectionView.collectionViewLayout.messageBubbleTextViewTextContainerInsets = UIEdgeInsetsMake(0, 0, 0, 0)
        
        self.setup()
        self.addDemoMessages()
    }
    
    @IBAction func didClickView(_ sender: AnyObject) {
        self.view.endEditing(true)
    }

    func reloadMessagesView() {
        self.collectionView?.reloadData()
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageDataForItemAt indexPath: IndexPath!) -> JSQMessageData! {
        let data = self.messages[indexPath.row]
        return data
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, didDeleteMessageAt indexPath: IndexPath!) {
        
    }
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAt indexPath: IndexPath!) -> JSQMessageBubbleImageDataSource! {
        return self.incomingBubble
    }
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAt indexPath: IndexPath!) -> JSQMessageAvatarImageDataSource! {
        return nil
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.messages.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = super.collectionView(collectionView, cellForItemAt: indexPath) as! JSQMessagesCollectionViewCell
        cell.textView.textColor = UIColor.black
        
        let data = self.messages[indexPath.row]
        let attributedText = NSMutableAttributedString(string: data.senderId, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 15, weight: UIFontWeightMedium),
                                                                                    NSForegroundColorAttributeName: UIColor.rgb(red: 243, green: 51, blue: 100)])
        
        attributedText.append(NSAttributedString(string: " \(data.text!)", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 14), NSForegroundColorAttributeName: UIColor.black]))
        
        cell.textView.attributedText = attributedText
        
        return cell
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, layout collectionViewLayout: JSQMessagesCollectionViewFlowLayout!, heightForCellTopLabelAt indexPath: IndexPath!) -> CGFloat {
        return 0
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, layout collectionViewLayout: JSQMessagesCollectionViewFlowLayout!, heightForMessageBubbleTopLabelAt indexPath: IndexPath!) -> CGFloat {
        return 0
    }

    override func collectionView(_ collectionView: JSQMessagesCollectionView!, layout collectionViewLayout: JSQMessagesCollectionViewFlowLayout!, heightForCellBottomLabelAt indexPath: IndexPath!) -> CGFloat {
        return 0
    }
}

//MARK - Setup
extension CommentViewController {
    func addDemoMessages() {
        let senderName = ["username1", "username2", "username3", "username4"]
        for i in 1...10 {
            let index: Int = Int(arc4random_uniform(UInt32(senderName.count)))
            let sender = senderName[index]
            let messageContent = "Message form user nr. \(i). this is a new message get from local server"
            let message = JSQMessage(senderId: sender, displayName: sender, text: messageContent)
            self.messages.append(message!)
        }
        self.reloadMessagesView()
    }
    
    func setup() {
        self.senderId = "baon"
        self.senderDisplayName = "baon"
    }
}

//MARK - Toolbar
extension CommentViewController {
    
    override func didPressSend(_ button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: Date!) {
        let message = JSQMessage(senderId: "username01", senderDisplayName: senderDisplayName, date: date, text: text)
        self.messages.append(message!)
        self.finishSendingMessage()
//        collectionView.reloadData()

    }
    
    override func didPressAccessoryButton(_ sender: UIButton!) {
        
    }
}

