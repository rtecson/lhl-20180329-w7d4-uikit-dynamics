//
//  ViewController.swift
//  w6d4
//
//  Created by Roland on 2017-08-30.
//  Copyright © 2017 MoozX Internet Ventures. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var squareView: UIView!
    @IBOutlet weak var barrierView: UIView!
    
    // MARK: - Fileprivate properties
    fileprivate var animator: UIDynamicAnimator!
    fileprivate var gravity: UIGravityBehavior!
    fileprivate var collision: UICollisionBehavior!
}

// MARK: - UIViewController methods
extension ViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startTest()
    }
}

// MARK: - Fileprivate methods
extension ViewController {
    
    fileprivate func startTest() {
        // Create UIKit physics engine, its reference view is our ViewController's view
        animator = UIDynamicAnimator(referenceView: view)
        
        // Create a gravity behaviour and apply it to the squareView
        gravity = UIGravityBehavior(items: [squareView])
        
        // Add the gravity behaviour to our physics engine
        animator.addBehavior(gravity)
        
        // Create a collision behavior and apply it to the squareView
        collision = UICollisionBehavior(items: [squareView])
        
        // Set the bounds of the reference view as the boundary
        collision.translatesReferenceBoundsIntoBoundary = true
        
        // Add a boundary around the barrierView
        collision.addBoundary(withIdentifier: "barrierView" as NSCopying, for: UIBezierPath(rect: barrierView.frame))

        // Add the collision behaviour to our physics engine
        animator.addBehavior(collision)
        
        // Make ourselves the delegate for the collision behaviour
        collision.collisionDelegate = self
        
        // Change elasticity of squareView
        let itemBehavior = UIDynamicItemBehavior(items: [squareView])
        itemBehavior.elasticity = 0.6
        
        // Add the elasticity dynamic item behavior to our physics engine
        animator.addBehavior(itemBehavior)
    }
}

// MARK: - UICollisionBehaviorDelegate
extension ViewController: UICollisionBehaviorDelegate {

    func collisionBehavior(_ behavior: UICollisionBehavior, beganContactFor item: UIDynamicItem, withBoundaryIdentifier identifier: NSCopying?, at p: CGPoint) {
        // Collision detected
        print("Collision detected, \(String(describing: identifier))")
        
        // Set colour of colliding view to yellow on collision
        let collidingView = item as! UIView
        collidingView.backgroundColor = UIColor.yellow
        
        // Animate colour of colliding view back to light gray after collision
        UIView.animate(withDuration: 0.3) { 
            collidingView.backgroundColor = UIColor.lightGray
        }
    }
}
