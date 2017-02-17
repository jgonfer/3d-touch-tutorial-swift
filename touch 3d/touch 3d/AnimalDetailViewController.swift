//
//  AnimalDetailViewController.swift
//  touch 3d
//
//  Created by jgonzalez on 20/1/17.
//  Copyright © 2017 jgonfer. All rights reserved.
//

import Foundation
import UIKit

class AnimalDetailViewController: UIViewController {
    @IBOutlet weak var animalImage: UIImageView!
    @IBOutlet weak var animalName: UILabel!
    @IBOutlet weak var likeButton: UIButton!

    var animal: Animal?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func setupView() {
        guard let animal = self.animal else {
            navigationController!.popToRootViewController(animated: true)
            return
        }
        animalName.text = animal.getName()
        if let image = animal.getImage() {
            animalImage.image = UIImage(named: image)
        } else if let urlAddress = animal.getUrl() {
            let url = URL(string: urlAddress)
            let data = try? Data(contentsOf: url!)
            animalImage.image = UIImage(data: data!)
        }
        let like = animal.getLike()
        likeButton.imageView?.image = UIImage(named: like ? "like_on" : "like_off")
    }
    
    @IBAction func toggleLikeState(_ sender: UIButton) {
        sender.pushSoft {
            self.animal?.toggleLikeState()
            self.setupView()
        }
    }
}
