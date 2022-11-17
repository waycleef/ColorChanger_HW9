//
//  SettingsViewController.swift
//  ColorChanger_HW9
//
//  Created by Алишер Маликов on 16.11.2022.
//

import UIKit

class SettingsViewController: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet var colorView: UIView!
    
    @IBOutlet var redLabel: UILabel!
    @IBOutlet var greenLabel: UILabel!
    @IBOutlet var blueLabel: UILabel!
    
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    @IBOutlet var redTextField: UITextField!
    @IBOutlet var greenTextField: UITextField!
    @IBOutlet var blueTextField: UITextField!
    
    // MARK: - Public parameters
    var mainColor: UIColor!
    var delegate: SettingViewControllerDelegate!
    
    
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        doneButtonOnKeyboard()
        colorView.backgroundColor = mainColor
        setValueToMainController()
       
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    // MARK: - IBActions
    @IBAction func colorSliderActions(_ sender: UISlider) {
        setColor()
        switch sender.tag {
        case 0:
            redLabel.text = string(from: redSlider)
            redTextField.text = redLabel.text
        case 1:
            greenLabel.text = string(from: greenSlider)
            greenTextField.text = greenLabel.text
        default:
            blueLabel.text = string(from: blueSlider)
            blueTextField.text = blueLabel.text
        }
        
    }
    
    @IBAction func doneButtonPressed(_ sender: UIButton) {
        delegate.newBackGroundColor(for: colorView.backgroundColor ?? UIColor(red: 1, green: 1, blue: 1, alpha: 1))
        dismiss(animated: true)      
        
    }
    
    
    // MARK: - Private Methods
    private func setColor() {
        colorView.backgroundColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1)
    }
    
    private func string(from slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
    
    private func setValueToMainController() {
        let ciColor = CIColor(color: colorView.backgroundColor!)
        let red = ciColor.red
        let green = ciColor.green
        let blue = ciColor.blue

        redSlider.value = Float(red)
        greenSlider.value = Float(green)
        blueSlider.value = Float(blue)
        
        redLabel.text = string(from: redSlider)
        redTextField.text = redLabel.text
        
        greenLabel.text = string(from: greenSlider)
        greenTextField.text = greenLabel.text
        
        blueLabel.text = string(from: blueSlider)
        blueTextField.text = blueLabel.text
    }
    
    private func doneButtonOnKeyboard() {
        let toolBar = UIToolbar ( )
        toolBar.sizeToFit ()
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(self.textFieldDidEndEditing(_:)))
                                         
        toolBar.setItems([flexibleSpace, doneButton], animated: false)
        
        redTextField.inputAccessoryView = toolBar
        greenTextField.inputAccessoryView = toolBar
        blueTextField.inputAccessoryView = toolBar
    }
    
//    @objc private func endEdditing() {
//        view.endEditing(true)
//    }
}


// MARK: - Table View Data Source
extension SettingsViewController: UISearchTextFieldDelegate {
    @objc func textFieldDidEndEditing(_ textField: UITextField) {
        let floatFromTextField = Float(redTextField.text ?? "0.0")
        if floatFromTextField ?? 0.5 > 1.0 && floatFromTextField ?? 0.5 < 0.0 {
            showAlert(title: "Некорректные данные", andMessage: "введите число от 0 до 1.0", textField: nil)
        }
        textField.endEditing(true)
        redSlider.value
    }
    
}

extension SettingsViewController {
    private func showAlert(title: String, andMessage message: String, textField: UITextField? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) {_ in
            textField?.text = ""
        }
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}

