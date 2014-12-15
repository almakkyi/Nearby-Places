//
//  SideMenuViewController.swift
//  Maps
//
//  Created by Ibrahim Almakky on 13/12/2014.
//  Copyright (c) 2014 Ibrahim Almakky. All rights reserved.
//

import UIKit

@objc
protocol SidePanelViewControllerDelegate {
    func categorySelected(category: String)
}

class SideMenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var categories:[String] = ["food", "bar", "atm", "park", "laundry", "casino", "library", "doctor"]
    
    var delegate: SidePanelViewControllerDelegate?

    @IBOutlet weak var categoriesTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.categoriesTable.delegate = self
        self.categoriesTable.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.categories.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CategoryCell", forIndexPath: indexPath) as UITableViewCell
        cell.textLabel?.text = self.categories[indexPath.row]
        return cell
    }
    
    // When a category is selected
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let selectedCategory = categories[indexPath.row]
        delegate?.categorySelected(selectedCategory)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
