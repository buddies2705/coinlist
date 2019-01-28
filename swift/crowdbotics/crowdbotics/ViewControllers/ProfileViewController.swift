//
//  ProfielViewController.swift
//  Jito
//
//  Created by Amit Kumar on 6/14/17.
//  Copyright © 2017 Amit Kumar. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController,PageContainerCustomDelegates {
 
    @IBOutlet weak var profileButton: UIButton!
    @IBOutlet weak var membersButton: UIButton!
    @IBOutlet weak var offersButton: UIButton!
    @IBOutlet weak var activitiesButton: UIButton!
    @IBOutlet weak var profileSelectedLabel: UILabel!
    @IBOutlet weak var memberSelectedLabel: UILabel!
    @IBOutlet weak var offerSelectedLabel: UILabel!
    @IBOutlet weak var activitiesSelectedLabel: UILabel!
    
    
    var currentIndexValue : Int = 0
    
    var onBoardPageViewController: ContainerViewController? {
        didSet {
         }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ServiceManager.getRequestWithFullUrl("https://koinex.in/api/ticker", success: { (responseObject) in
            print(responseObject)
        }) { (errorObject) in
            print(errorObject)
        }
        
         self.setButtonStateWithIndex(index: self.currentIndexValue)
        
        
      
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let statusBar: UIView = UIApplication.shared.value(forKey: "statusBar") as! UIView
        if statusBar.responds(to: #selector(setter: UIView.backgroundColor)) {
            statusBar.backgroundColor = UIColor(red: 46/255.0, green: 110/255.0, blue: 176/255.0, alpha: 1.0)
            statusBar.tintColor = UIColor.white
        }
    
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
       
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let onBoardPageViewController = segue.destination as? ContainerViewController {
            onBoardPageViewController.currentPageIndex = self.currentIndexValue
            self.onBoardPageViewController = onBoardPageViewController
            onBoardPageViewController.pageCustomDelegate = self
            onBoardPageViewController.scrollToViewController(index: self.currentIndexValue)
        }
    }
    
   
  
    @IBAction func backButtonAction(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func scrollingButtonsAction(_ sender: Any) {
        
        self.setButtonStateWithIndex(index: (sender as AnyObject).tag)
        onBoardPageViewController?.scrollToViewController(index: (sender as AnyObject).tag)
        
    }
    
    
    
    
    
    func didChangePageControlValue() {
        onBoardPageViewController?.scrollToViewController(index: 0)
    }
    
  
    
    func setButtonStateWithIndex(index : Int) {
        self.currentIndexValue = index
        self.profileSelectedLabel.isHidden = true
        self.memberSelectedLabel.isHidden = true
        self.offerSelectedLabel.isHidden = true
        self.activitiesSelectedLabel.isHidden = true

         if(index == 0){
            self.profileSelectedLabel.isHidden = false

            self.profileButton.isSelected = true
            self.membersButton.isSelected = false
            self.offersButton.isSelected = false
            self.activitiesButton.isSelected = false
        }else if(index == 1){
            self.memberSelectedLabel.isHidden = false

            self.profileButton.isSelected = false
            self.membersButton.isSelected = true
            self.offersButton.isSelected = false
            self.activitiesButton.isSelected = false
            
        }else if(index == 2){
            self.offerSelectedLabel.isHidden = false

            self.profileButton.isSelected = false
            self.membersButton.isSelected = false
            self.offersButton.isSelected = true
            self.activitiesButton.isSelected = false
            
            
            
        }else {
            self.activitiesSelectedLabel.isHidden = false

            self.profileButton.isSelected = false
            self.membersButton.isSelected = false
            self.offersButton.isSelected = false
            self.activitiesButton.isSelected = true
            
        }
    }

    
    
    func customPageViewController(_ onBaordPageViewController: ContainerViewController,
                                  didUpdatePageCount count: Int){
        
    }
    
    
    
    func customPageViewController(_ onBaordViewController: ContainerViewController,
                                  didUpdatePageIndex index: Int){
        self.setButtonStateWithIndex(index : index)
    }

  

}





