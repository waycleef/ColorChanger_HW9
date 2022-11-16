//
//  ViewController.swift
//  ColorChanger_HW9
//
//  Created by Алишер Маликов on 16.11.2022.
//

import UIKit


protocol SettingViewControllerDelegate {
    func newBackGroundColor(for viewController: UIColor)
}

class MainViewController: UIViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let settingsVC = segue.destination as? SettingsViewController else { return }
        settingsVC.mainColor = self.view.backgroundColor!
        settingsVC.delegate = self
    }


}

// MARK: - SettingViewControllerDelegate
extension MainViewController: SettingViewControllerDelegate {
    func newBackGroundColor(for viewController: UIColor) {
        self.view.backgroundColor = viewController
    }
}

