//
//  ViewController.swift
//  TeachMeSkillsApp
//
//  Created by Dmitrii Pogonia on 21.06.2023.
//

import UIKit

// MARK: - Enums
enum Directions: String {
    case up = "up"
    case down = "down"
    case left =  "left"
    case right = "right"
}

class ViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var buttonsView: UIView!
    
    // MARK: - let/var
    private let text = "Party Woolf!!!"
    let circleView = UIView()
    let screenSize = UIScreen.main.bounds
    let step = CGFloat(20)
    let size = CGFloat(20)
    var safe = UIEdgeInsets()
    var error = false
    
    // MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        createView()
        safe = self.view.safeAreaInsets
    }
    
    // MARK: - IBActions
    @IBAction func upPressed(_ sender: UIButton) {
        move(directions: .up)
    }
    @IBAction func downPressed(_ sender: UIButton) {
        move(directions: .down)
    }
    @IBAction func leftPressed(_ sender: UIButton) {
        move(directions: .left)
    }
    @IBAction func rightPressed(_ sender: UIButton) {
        move(directions: .right)
    }
    @IBAction func actionPressed(_ sender: UIButton) {
        
    }
    @IBAction func showThirdVCButtonPressed(_ sender: Any) {
        let controller = UIStoryboard(name: "ThirdViewController", bundle: nil).instantiateViewController(withIdentifier: "ThirdViewController") as! ThirdViewController
        self.navigationController?.popViewController(animated: true)}
    
    
    @IBAction func fourthButtonPressed(_ sender: UIButton) {
        let controller = UIStoryboard(name: "Main2", bundle: nil).instantiateViewController(withIdentifier: "ViewController2") as! ViewController2
        controller.modalPresentationStyle = .fullScreen
        controller.modalTransitionStyle = .coverVertical
        self.present(controller, animated: true, completion: nil)
    }
    
    // MARK: - flow func
    private func createView(){
        circleView.frame = CGRect(x: screenSize.midX-(size/2), y: (screenSize.midY-(size/2))*2/3, width: size, height: size)
        circleView.backgroundColor = .blue
        self.view.addSubview(circleView)
        
        circleView.layer.cornerRadius = circleView.frame.size.width/2
    }
    private func move(directions: Directions) {
        errorLabel.text = ""
        switch directions{
        case .up:
            if self.circleView.frame.origin.x - step > safe.top {
                self.circleView.frame.origin.y -= step
            } else { error = true }
        case .down:
            if self.circleView.frame.origin.y + size + step > errorLabel.frame.minY{
                self.circleView.frame.origin.y += step
            } else { error = true }
        case .left:
            if self.circleView.frame.origin.x - step > safe.left{
                self.circleView.frame.origin.x -= step
            } else { error = true }
        case .right:
            if self.circleView.frame.origin.x + size + step < screenSize.width - safe.right{
                self.circleView.frame.origin.x += step
            } else { error = true }
        }
        if circleView.frame.intersects(buttonsView.frame){
            switch directions{
            case .up:
                self.circleView.frame.origin.y += step
            case .down:
                self.circleView.frame.origin.y -= step
            case .left:
                self.circleView.frame.origin.x += step
            case .right:
                self.circleView.frame.origin.x -= step
            }
            error = true
        }
        if error == true{
            errorLabel.text = "Move \(directions.rawValue) isn't possible"
            error = false
        }
    }
}

