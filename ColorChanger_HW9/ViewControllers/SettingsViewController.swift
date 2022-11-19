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
        
        
        colorView.backgroundColor = mainColor
        setValueToMainController()
        
//        redTextField.delegate = self
//        greenTextField.delegate = self
//        blueTextField.delegate = self
       
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
        delegate.newBackGroundColor(for: colorView.backgroundColor ?? .white)
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
    
    private func setValue(for labels: UILabel...) {
        labels.forEach { label in
            switch label {
            case redLabel:
                redLabel.text = string(from: redSlider)
            case greenLabel:
                greenLabel.text = string(from: greenSlider)
            default:
                blueLabel.text = string(from: blueSlider)
            }
        }
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
    
    @objc private func endEdditing() {
        view.endEditing(true)
    }
}


// MARK: - UITextFieldDelegate
extension SettingsViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        guard let text = textField.text else { return }
        
        if let currentValue = Float(text) {
            switch textField {
            case redTextField:
                redSlider.setValue(currentValue, animated: true)
                setValue(for: redLabel)
            case greenTextField:
                greenSlider.setValue(currentValue, animated: true)
                setValue(for: greenLabel)
            default:
                blueSlider.setValue(currentValue, animated: true)
                setValue(for: blueLabel)
            }
            setColor()
            return
        }
        showAlert(title: "Wrong format", andMessage: "Please enter correct value", textField: nil)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let keyboardToolbar = UIToolbar()
        keyboardToolbar.sizeToFit()
        textField.inputAccessoryView = keyboardToolbar
        
        let doneButton = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(endEdditing)
            )
        
        let flexBarButton = UIBarButtonItem(
            barButtonSystemItem: .fixedSpace,
            target: nil,
            action: nil
        )

        keyboardToolbar.items = [flexBarButton, doneButton]
    }
}


// MARK: - Extensions
extension SettingsViewController {
    func showAlert(title: String, andMessage message: String, textField: UITextField? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) {_ in
            textField?.text = ""
        }
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}


// черновик
//    private func doneButtonOnKeyboard() {
//        let toolBar = UIToolbar ( )
//        toolBar.sizeToFit ()
//        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
//
//        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(self.endEdditing))
//
//        toolBar.setItems([flexibleSpace, doneButton], animated: false)
//
//        redTextField.inputAccessoryView = toolBar
//        greenTextField.inputAccessoryView = toolBar
//        blueTextField.inputAccessoryView = toolBar
//    }

