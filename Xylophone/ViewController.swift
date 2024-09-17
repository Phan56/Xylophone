//
//  ViewController.swift
//  Xylophone
//
//  Created by Phan56 on 16.09.2024.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var player: AVAudioPlayer!
    
    let displayStackView = UIStackView()
    
    let buttonAreey = ["C", "D", "E", "F", "G", "A", "B"]
    
    enum ColorButton {
        static let keyC = UIColor(red: 241/255, green: 161/255, blue: 154/255, alpha: 1)
        static let keyD = UIColor(red: 240/255, green: 154/255, blue: 55/255, alpha: 1)
        static let keyE = UIColor(red: 247/255, green: 206/255, blue: 70/255, alpha: 1)
        static let keyF = UIColor(red: 101/255, green: 196/255, blue: 102/255, alpha: 1)
        static let keyG = UIColor(red: 88/255, green: 86/255, blue: 206/255, alpha: 1)
        static let keyA = UIColor(red: 52/255, green: 120/255, blue: 246/255, alpha: 1)
        static let keyB = UIColor(red: 163/255, green: 87/255, blue: 215/255, alpha: 1)
    }
    
    let myView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        createStackView()
        // Do any additional setup after loading the view.
        
    }
    
    func createStackView() {
        
        view.addSubview(displayStackView)
        displayStackView.axis = .vertical
        displayStackView.spacing = 10
        displayStackView.translatesAutoresizingMaskIntoConstraints = false
        displayStackView.backgroundColor = .white
        displayStackView.distribution = .fillEqually
        displayStackView.alignment = .center
        
        NSLayoutConstraint.activate([
            displayStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            displayStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -15),
            displayStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            displayStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15)
        ])
        
        
        for item in buttonAreey.enumerated() {
            let button = createButton(name: item.element)
            displayStackView.addArrangedSubview(button)
            let offset = CGFloat(item.offset) * 10
            button.widthAnchor.constraint(equalTo: displayStackView.widthAnchor, constant: -offset).isActive = true
            
            switch item.offset {
            case 0: button.backgroundColor = ColorButton.keyC
            case 1: button.backgroundColor = ColorButton.keyD
            case 2: button.backgroundColor = ColorButton.keyE
            case 3: button.backgroundColor = ColorButton.keyF
            case 4: button.backgroundColor = ColorButton.keyG
            case 5: button.backgroundColor = ColorButton.keyA
            case 6: button.backgroundColor = ColorButton.keyB
            default: button.backgroundColor = .black
            }
            
        }
        
        
    }
    
    
    func createButton(name: String) -> UIButton {
        let button = UIButton()
        button.setTitle(name, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 50)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(buttonTap), for: .touchUpInside)
        return button
    }
    
    @objc func buttonTap(sender: UIButton) {
//        print("tap \(String(describing: sender.backgroundColor)) !!!")
        
        UIView.animate(withDuration: 1) {
            sender.backgroundColor = sender.backgroundColor?.withAlphaComponent(0.5)
        }
        
        guard let sound = sender.titleLabel?.text else {return}
        playSound(soundName: sound)
        UIView.animate(withDuration: 1) {
            sender.backgroundColor = sender.backgroundColor?.withAlphaComponent(1)
        }
    }


}

extension ViewController {
    
    func playSound(soundName: String) {
        let url = Bundle.main.url(forResource: soundName, withExtension: "wav")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
                
    }

    
}

