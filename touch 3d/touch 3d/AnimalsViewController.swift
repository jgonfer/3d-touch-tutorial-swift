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
    
    let kColorRed = UIColor(colorLiteralRed: 234/255, green: 94/255, blue: 55/255, alpha: 1)
    let type: ItemType = .animal
    let cellHeight: CGFloat = 75.0
    let footerHeight: CGFloat = 55.0
    let cellIdentifier = "cell"
    let segueIdentifier = "showAnimalDetail"
    var animals: [Animal]?
    var selectedIndex: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
        if traitCollection.forceTouchCapability == .available {
            registerForPreviewing(with: self, sourceView: view)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let index = selectedIndex else {
            return
        }
        updateAnimalState(atIndex: index)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueIdentifier {
            guard let vc = segue.destination as? AnimalDetailViewController, let selectedIndex = self.selectedIndex, let animals = self.animals else {
                return
            }
            let animal = animals[selectedIndex.row]
            vc.animal = animal
        }
    }
    
    func openAnimalFor(shortcutIdentifier: ShortcutIdentifier) -> Bool {
        switch shortcutIdentifier {
        case .OpenFox:
            selectedIndex = IndexPath(row: 1, section: 0)
            performSegue(withIdentifier: segueIdentifier, sender: nil)
        case .OpenRandomAnimal:
            guard let animals = self.animals else {
                return false
            }
            let randomNumber = Int(arc4random_uniform(UInt32(animals.count)))
            selectedIndex = IndexPath(row: randomNumber, section: 0)
            performSegue(withIdentifier: segueIdentifier, sender: nil)
        default:
            return false
        }
        return true
    }
    
    func updateAnimalState(atIndex index: IndexPath) {
        let row = index.row
        guard let animals = self.animals, animals.count >= row else {
            return
        }
        let animal = animals[row]
        let like = animal.getLike()
        let cell = tableView.cellForRow(at: index)
        UIView.animate(withDuration: 0.5) { 
            cell?.textLabel?.textColor = like ? self.kColorRed : .black
            self.view.setNeedsLayout()
        }
    }
    
    private func setupView() {
        title = "Animals"
        
        animals = [Animal]()
        animals?.append(Animal(name: "Cat", image: "cat", url: nil, type: type))
        animals?.append(Animal(name: "Fox", image: "fox", url: nil, type: type))
        animals?.append(Animal(name: "Rabbit", image: "rabbit", url: nil, type: type))
        animals?.append(Animal(name: "Bear", image: "bear", url: nil, type: type))
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
        cell.textLabel?.text = animal.getName()
        let like = animal.getLike()
        cell.textLabel?.textColor = like ? kColorRed : UIColor.black
        
        if let image = animal.getImage() {
            cell.imageView?.image = UIImage(named: image)
        } else if let urlAddress = animal.getUrl() {
            let url = URL(string: urlAddress)
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

extension AnimalsViewController: UIViewControllerPreviewingDelegate {
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        var heightOffset = UIApplication.shared.statusBarFrame.height
        if let navigationController = navigationController {
            heightOffset += navigationController.navigationBar.frame.height
        }
        let newLocation = CGPoint(x: location.x, y: location.y - heightOffset)
        guard let indexPath = tableView.indexPathForRow(at: newLocation) else {
            return nil
        }
        guard let cell = tableView.cellForRow(at: indexPath) else {
            return nil
        }
        guard let animals = animals, animals.count >= indexPath.row else {
            return nil
        }
        guard let animalDetailVC = storyboard?.instantiateViewController(withIdentifier: "AnimalDetailVC") as? AnimalDetailViewController else { return nil
        }
        
        selectedIndex = indexPath
        let animal = animals[indexPath.row]
        animalDetailVC.delegate = self
        animalDetailVC.animal = animal
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        animalDetailVC.preferredContentSize = CGSize(width: screenWidth, height: screenHeight - 300)
        
        var previewFrame = cell.frame
        previewFrame.origin.y += heightOffset
        previewingContext.sourceRect = previewFrame
        
        return animalDetailVC
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        performSegue(withIdentifier: segueIdentifier, sender: nil)
    }
}

extension AnimalsViewController: AnimalDetailViewControllerDelegate {
    func updateAnimalCellState() {
        guard let selectedIndex = selectedIndex else {
            return
        }
        updateAnimalState(atIndex: selectedIndex)
    }
}
