//
//  ItemViewController.swift
//  touch 3d
//
//  Created by jgonzalez on 20/1/17.
//  Copyright © 2017 jgonfer. All rights reserved.
//

import UIKit

class ItemViewController: UIViewController {
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemName: UILabel!

    var item: Item?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func setupView() {
        guard let item = self.item else {
            navigationController!.popToRootViewController(animated: true)
            return
        }
        itemName.text = item.name
        if let image = item.image {
            itemImage.image = UIImage(named: image)
        } else if let image = item.image {
            let url = URL(string: image)
            let data = try? Data(contentsOf: url!)
            itemImage.image = UIImage(data: data!)
        }
    }
}
