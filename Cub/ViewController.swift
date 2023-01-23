//
//  ViewController.swiftё
//  Cub
//
//  Created by Konstantyn Koroban on 07/09/2021.
//

import UIKit

class ViewController: UIViewController {
    
    var circleView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        addRightView()
        addLeftView()
        addSubViewUp()
        addSubViewDown()
        
    }
    
    private func configureView()  {
        circleView = makeCircleView()
        view.addSubview(circleView)
        view.backgroundColor = .black
        
    }
    
    private func makeCircleView() -> UIView {
        let circleView = UIView()
        let width: CGFloat = 100
        let height: CGFloat = 100
        circleView.frame.size = CGSize(width: width, height: height)
        circleView.center = view.center
        circleView.layer.cornerRadius = circleView.frame.width / 2
        circleView.backgroundColor = .orange
        return circleView
        
    }
    
    private func makeButtonView(titled title: String?) -> UIView {
        let buttonView = UIView()
        let titleLabel = UILabel()
        
        let widthSubViewRight: CGFloat = 30
        let heigtSubViewRight: CGFloat = 30
        
        buttonView.frame.size = CGSize(width: widthSubViewRight, height: heigtSubViewRight)
        
        titleLabel.frame.size = CGSize(width: 30, height: 30)
        titleLabel.textAlignment = .center
        titleLabel.text = title
        titleLabel.textColor = .orange
        buttonView.addSubview(titleLabel)
        
        return buttonView
    }
    
    private func addRightView() {
        
        let subViewRight = makeButtonView(titled: "R")
        
        circleView.addSubview(subViewRight)
        
        subViewRight.frame.origin = CGPoint(x: circleView.frame.size.width - subViewRight.frame.size.width, y: circleView.frame.size.height / 2 - subViewRight.frame.size.height / 2)
        subViewRight.layer.cornerRadius = subViewRight.frame.width / 2
        subViewRight.backgroundColor = .black
        
        let rightTapGesture = UITapGestureRecognizer(target: self, action: #selector(didRightTap))
        subViewRight.addGestureRecognizer(rightTapGesture)
        
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        rightSwipe.direction = .right
        view.addGestureRecognizer(rightSwipe)
        
    }
    
    @objc
    private func didRightTap(_ sender: UIGestureRecognizer) {
        move(to:.right)
        
    }
    
    private func addLeftView() {
        let subViewLeft = makeButtonView(titled: "L")
        
        subViewLeft.frame.origin = CGPoint(x: 0, y: circleView.frame.size.height / 2 - subViewLeft.frame.size.height / 2)
        subViewLeft.layer.cornerRadius = subViewLeft.frame.width / 2
        circleView.addSubview(subViewLeft)
        subViewLeft.backgroundColor = .black
        
        let LeftTapGesture = UITapGestureRecognizer(target: self, action: #selector(didLeftTap))
        subViewLeft.addGestureRecognizer(LeftTapGesture)
        
        let LeftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        LeftSwipe.direction = .left
        view.addGestureRecognizer(LeftSwipe)
        
    }
    
    @objc
    private func didLeftTap(_ sender: UIGestureRecognizer) {
        move(to:.left)
        
    }
    
    private func addSubViewDown() {
        let subViewDown = makeButtonView(titled: "D")
        
        subViewDown.frame.origin = CGPoint(x: circleView.frame.size.height / 2 - subViewDown.frame.size.height / 2, y: circleView.frame.size.height - subViewDown.frame.size.height)
        subViewDown.layer.cornerRadius = subViewDown.frame.width / 2
        circleView.addSubview(subViewDown)
        subViewDown.backgroundColor = .black
        
        let downTapGesture = UITapGestureRecognizer(target: self, action: #selector(didDownTap))
        subViewDown.addGestureRecognizer(downTapGesture)
        
        let downSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        downSwipe.direction = .down
        view.addGestureRecognizer(downSwipe)
        
    }
    
    @objc
    private func didDownTap(_ sender: UIGestureRecognizer) {
        move(to:.down)
        
    }
    
    private func addSubViewUp() {
        let subViewUp = makeButtonView(titled: "Up")
        
        subViewUp.frame.origin = CGPoint(x: circleView.frame.size.height / 2 - subViewUp.frame.size.height / 2, y: 0)
        subViewUp.layer.cornerRadius = subViewUp.frame.width / 2
        circleView.addSubview(subViewUp)
        subViewUp.backgroundColor = .black
        
        let upTapGesture = UITapGestureRecognizer(target: self, action: #selector(didUpTap))
        subViewUp.addGestureRecognizer(upTapGesture)
        
        let upSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        upSwipe.direction = .up
        view.addGestureRecognizer(upSwipe)
        
    }
    
    @objc
    private func didUpTap(_ sender: UIGestureRecognizer) {
        move(to:.up)
        
    }
    
    func move(to direction: Direction) {
        let viewPosition = circleView.frame.origin
        
        switch direction {
        case .up:
            circleView.frame.origin = CGPoint(
                x: viewPosition.x,
                y: max(viewPosition.y - 50, 0)
            )
        case .down:
            let maxDownHeight = view.frame.height - circleView.frame.height
            circleView.frame.origin = CGPoint(
                x: viewPosition.x,
                y: min(viewPosition.y + 50, maxDownHeight)
            )
        case .left:
            circleView.frame.origin = CGPoint(
                x: max(viewPosition.x - 50 ,0),
                y: viewPosition.y)
        case .right:
            let maxRightWithd = view.frame.width - circleView.frame.width
            circleView.frame.origin = CGPoint(
                x: min(viewPosition.x + 50, maxRightWithd),
                y: viewPosition.y)
        }
    }
    
    @objc
    private func handleSwipe (_ sender: UISwipeGestureRecognizer ){
        let viewPosition = circleView.frame.origin
        switch sender.direction {
        case .up:
            circleView.frame.origin = CGPoint(
                x: viewPosition.x,
                y: max(viewPosition.y - 100, 0)
            )
        case .down:
            let maxDownHeight = view.frame.height - circleView.frame.height
            circleView.frame.origin = CGPoint(
                x: viewPosition.x,
                y: min(viewPosition.y + 100, maxDownHeight)
            )
        case .left:
            circleView.frame.origin = CGPoint(
                x: max(viewPosition.x - 100 ,0),
                y: viewPosition.y)
        case .right:
            let maxRightWithd = view.frame.width - circleView.frame.width
            circleView.frame.origin = CGPoint(
                x: min(viewPosition.x + 100, maxRightWithd),
                y: viewPosition.y)
        default:
            break
        }
    }
}
