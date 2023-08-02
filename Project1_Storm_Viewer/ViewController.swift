//
//  ViewController.swift
//  Project1_Storm_Viewer
//
//  Created by Petro Strynada on 01.06.2023.
//

import UIKit

class ViewController: UITableViewController {
    var pictures = [String]()
    var picturesShownTimes = [Int]()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Storme View"
        navigationController?.navigationBar.prefersLargeTitles = true

        //navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(alert1))

        performSelector(inBackground: #selector(fetchPictures), with: nil)
        performSelector(inBackground: #selector(loadPicturesShownTimes), with: nil)
    }

    //for checking picturesShownTimes array
//    @objc func alert1() {
//        let ac = UIAlertController(title: "\(picturesShownTimes)", message: nil, preferredStyle: .alert)
//        ac.addAction(UIAlertAction(title: "ok", style: .default))
//        present(ac, animated: true)
//    }

    @objc func fetchPictures() {
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)

        for item in items {
            if item.hasPrefix("nssl") {
                //this is a picture to load!
                pictures.append(item)
                picturesShownTimes.append(0)
            }
        }

        pictures.sort()
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text = pictures[indexPath.row]
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //if is story board. if no look for project 7
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.selectedImage = pictures[indexPath.row]

            if let selectedImage = vc.selectedImage {
                if let selectedImageNumber = pictures.firstIndex(of: selectedImage) {
                    vc.selectedImageNumber = selectedImageNumber + 1
                    picturesShownTimes[selectedImageNumber] += 1
                    savePicturesShownTimes()
                    vc.picturesShownTimes = picturesShownTimes[selectedImageNumber]
                }
            }

            vc.imageCount = pictures.count
            navigationController?.pushViewController(vc, animated: true)
        }
    }

    @objc func loadPicturesShownTimes() {
        let defaults = UserDefaults.standard

        if let savedPicturesShownTimes = defaults.object(forKey: "picturesShownTimes") as? Data {
            let jsonDecoder = JSONDecoder()

            do {
                picturesShownTimes = try jsonDecoder.decode([Int].self, from: savedPicturesShownTimes)
            } catch {
                print("Failed to load pictures shown times")
            }
        }
    }

    func savePicturesShownTimes() {
        let jsonEncoder = JSONEncoder()

        if let saveData = try? jsonEncoder.encode(picturesShownTimes) {
            let defaults = UserDefaults.standard
            defaults.set(saveData, forKey: "picturesShownTimes")
        } else {
            print("Failed to save people.")
        }
    }


}

