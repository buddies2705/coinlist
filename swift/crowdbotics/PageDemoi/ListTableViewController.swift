//
//  ListTableViewController.swift
//  PageDemoi
//
//  Created by Amit Kumar on 18/01/19.
//  Copyright © 2019 Amit Kumar. All rights reserved.
//

import UIKit

class ListTableViewController: UITableViewController {

    var currentIndex : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if let currentVC = self.parent as? ContainerViewController {
            self.currentIndex = currentVC.currentPageIndex
        }

        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(self.currentIndex == 0){
            return appDelegateObj().finalModelObject?.inrList.count ?? 0
        }else if(self.currentIndex == 1){
            return appDelegateObj().finalModelObject?.bitcoinList.count ?? 0
        }else if(self.currentIndex == 2){
            return appDelegateObj().finalModelObject?.etherList.count ?? 0
        }else{
            return appDelegateObj().finalModelObject?.rippleList.count ?? 0
        }
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "DataTableViewCell", for: indexPath) as? DataTableViewCell {
            var koinObject : KoinModel?
            
            if(self.currentIndex == 0){
                koinObject =  appDelegateObj().finalModelObject?.inrList[indexPath.row]
                cell.iconImageView.image = UIImage(named: "rupees")
            }else if(self.currentIndex == 1){
                koinObject =  appDelegateObj().finalModelObject?.bitcoinList[indexPath.row]
                cell.iconImageView.image = UIImage(named: "bitcoin")

            }else if(self.currentIndex == 2){
                koinObject =  appDelegateObj().finalModelObject?.etherList[indexPath.row]
                cell.iconImageView.image = UIImage(named: "ether")

                
            }else{
                koinObject =  appDelegateObj().finalModelObject?.rippleList[indexPath.row]
                cell.iconImageView.image = UIImage(named: "ripple")

            }
            
            cell.nameLabel.text = koinObject?.currencyFullForm?.capitalized
            cell.name.text = koinObject?.currencyShortForm
            cell.priceLabel.text = koinObject?.lastTradedPrice
            cell.higherPrice.text = koinObject?.highestBid
            cell.lowerPrice.text = koinObject?.lowestAsk
            cell.selectionStyle = .none
            
            
            return cell
        }
        return UITableViewCell()
     
    }
 

   

}
