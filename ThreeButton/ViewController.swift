//
//  ViewController.swift
//  ThreeButton
//
//  Created by Dmitiy Myachin on 05.03.2023.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var button1 = CustomButton(buttonTitle: "Button")
    lazy var button2 = CustomButton(buttonTitle: "Long button title")
    lazy var button3 = CustomButton(buttonTitle: "Show sheet")
    
    lazy var isShowSheet = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupView()
    }
    
    func setupView(){
        view.backgroundColor = .white
        
        
        view.addSubview(button1)
        view.addSubview(button2)
        view.addSubview(button3)
        
        button1.configurationUpdateHandler = { button in
            if self.isShowSheet{
                button.configuration?.background.backgroundColor = .gray
            } else {
                button.configuration?.background.backgroundColor = .systemMint
            }
        }
        
        button2.configurationUpdateHandler = { button in
            if self.isShowSheet{
                button.configuration?.background.backgroundColor = .gray
            } else {
                button.configuration?.background.backgroundColor = .systemMint
            }
        }
        
        button3.configurationUpdateHandler = { button in
            if self.isShowSheet{
                button.configuration?.background.backgroundColor = .gray
            } else {
                button.configuration?.background.backgroundColor = .systemMint
            }
        }

        
        
        button3.addTarget(self, action: #selector(self.showSheet), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            button1.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            button1.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            button2.topAnchor.constraint(equalTo: button1.bottomAnchor, constant: 10),
            button2.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            button3.topAnchor.constraint(equalTo: button2.bottomAnchor, constant: 10),
            button3.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    @objc func showSheet(){
        isShowSheet = true
        let sheet = SheetContriller()
        sheet.dismisAction = {
            self.isShowSheet = false
        }
        sheet.view.backgroundColor = .white
        present(sheet, animated: true, completion: nil)
    }
    
    
}


class SheetContriller: UIViewController {
    var dismisAction: (()->Void)?
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let dismisAction = dismisAction{
            dismisAction()
        }
    }
}

class CustomButton: UIButton {
    
    private lazy var animator: UIViewPropertyAnimator = {
        return UIViewPropertyAnimator(duration: 0.2, curve: .linear)
    }()
    
    init(buttonTitle: String){
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        
        var config = UIButton.Configuration.plain()
        
        config.cornerStyle = .medium
        config.background.backgroundColor = .systemMint
        
        config.baseForegroundColor = .white
        
        config.title = buttonTitle
        
        config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.foregroundColor = UIColor.white
            return outgoing
        }
        
        config.imageColorTransformer = UIConfigurationColorTransformer { _ in UIColor.white }
        
        config.image = UIImage(systemName: "chevron.right.circle.fill")
        config.imagePadding = 8
        config.imagePlacement = .trailing
        
        config.contentInsets = .init(top: 10, leading: 14, bottom: 10, trailing: 14)
        
        configuration = config
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        animator.addAnimations {
            self.transform = CGAffineTransform(scaleX: 0.85, y: 0.85)
        }
        
        animator.startAnimation()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
        animator.addAnimations {
            self.transform = .identity
        }
        
        animator.startAnimation()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
