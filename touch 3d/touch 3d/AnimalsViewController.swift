//
//  AnimalsViewController.swift
//  touch 3d
//
//  Created by jgonzalez on 20/1/17.
//  Copyright © 2017 jgonfer. All rights reserved.
//

import UIKit

enum ItemType {
    case animal, mountain
}

class AnimalsViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    let type: ItemType = .animal
    let cellHeight: CGFloat = 75.0
    let footerHeight: CGFloat = 55.0
    let cellIdentifier = "cell"
    let segueIdentifier = "showAnimalDetail"
    var animals: [Item]?
    var selectedIndex: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueIdentifier {
            guard let vc = segue.destination as? ItemViewController, let selectedIndex = self.selectedIndex, let animals = self.animals else {
                return
            }
            vc.item = animals[selectedIndex.row]
        }
    }
    
    private func setupView() {
        title = "Animals"
        
        animals = [Item]()
        animals?.append(Item(name: "Cat", image: "cat", url: nil, type: type))
        animals?.append(Item(name: "Fox", image: "fox", url: nil, type: type))
        animals?.append(Item(name: "Rabbit", image: "rabbit", url: nil, type: type))
        animals?.append(Item(name: "Bear", image: "bear", url: nil, type: type))
    }
}

extension AnimalsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let _ = animals else {
            return 0
        }
        return animals!.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return footerHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) ?? UITableViewCell(style: .default, reuseIdentifier: cellIdentifier)
        
        let animal = animals![indexPath.row]
        cell.textLabel?.text = animal.name
        
        if let image = animal.image {
            cell.imageView?.image = UIImage(named: image)
        } else if let image = animal.image {
            let url = URL(string: image)
            let data = try? Data(contentsOf: url!)
            cell.imageView?.image = UIImage(data: data!)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return "Designed by Freepik: http://www.freepik.com/"
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        selectedIndex = indexPath
        performSegue(withIdentifier: segueIdentifier, sender: nil)
    }
}

