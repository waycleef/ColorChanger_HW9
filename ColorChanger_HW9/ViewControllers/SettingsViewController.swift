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
        setValue(for: redLabel, greenLabel, blueLabel)
        
        redSlider.value = mainColor.red() ?? 1.0
        greenSlider.value = mainColor.green() ?? 1.0
        blueSlider.value = mainColor.blue() ?? 1.0
        
        
        
        print(mainColor.red())
        print(mainColor.green())
        print(mainColor.blue())
        
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
}

extension UIColor {

    func red() -> Float? {
        var fRed : CGFloat = 0
        var fGreen : CGFloat = 0
        var fBlue : CGFloat = 0
        var fAlpha: CGFloat = 0
        if self.getRed(&fRed, green: &fGreen, blue: &fBlue, alpha: &fAlpha) {
            let iRed = Float(fRed * 255.0)
            let iGreen = Float(fGreen * 255.0)
            let iBlue = Float(fBlue * 255.0)
            let iAlpha = Int(fAlpha * 255.0)

            return iRed
        } else {
            // Could not extract RGBA components:
            return nil
        }
    }
    
    func green() -> Float? {
        var fRed : CGFloat = 0
        var fGreen : CGFloat = 0
        var fBlue : CGFloat = 0
        var fAlpha: CGFloat = 0
        if self.getRed(&fRed, green: &fGreen, blue: &fBlue, alpha: &fAlpha) {
            let iRed = Float(fRed * 255.0)
            let iGreen = Float(fGreen * 255.0)
            let iBlue = Float(fBlue * 255.0)
            let iAlpha = Int(fAlpha * 255.0)

            return iGreen
        } else {
            // Could not extract RGBA components:
            return nil
        }
    }
    
    func blue() -> Float? {
        var fRed : CGFloat = 0
        var fGreen : CGFloat = 0
        var fBlue : CGFloat = 0
        var fAlpha: CGFloat = 0
        if self.getRed(&fRed, green: &fGreen, blue: &fBlue, alpha: &fAlpha) {
            let iRed = Float(fRed * 255.0)
            let iGreen = Float(fGreen * 255.0)
            let iBlue = Float(fBlue * 255.0)
            let iAlpha = Int(fAlpha * 255.0)

            return iBlue
        } else {
            // Could not extract RGBA components:
            return nil
        }
    }
}
