//
//  ViewController.swift
//  coloringApp
//
//  Created by  on 10/10/19.
//  Copyright © 2019 goodstuff. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    var drawColor = UIColor.black
    var lineWidth: CGFloat = 5
    //needed for a continuous stroke
    var lastPoint = CGPoint.zero
    var swipe = false
    var highlighterBool = false
    var eraserBool = false
    
    @IBOutlet weak var topStack: UIStackView!
    @IBOutlet weak var bottomStack: UIStackView!
    
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var tempImageView: UIImageView!
    
    
    @IBOutlet weak var redbutton: UIButton!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
//        tempImageView.isUserInteractionEnabled = true
//
//        mainImageView.translatesAutoresizingMaskIntoConstraints = false
//        tempImageView.translatesAutoresizingMaskIntoConstraints = false
//        mainImageView.topAnchor.constraint(equalTo: topStack.bottomAnchor, constant: 10).isActive = true
//        mainImageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
//         mainImageView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
//        mainImageView.bottomAnchor.constraint(equalTo: bottomStack.topAnchor, constant: -10).isActive = true
//
//        tempImageView.topAnchor.constraint(equalTo: topStack.bottomAnchor, constant: 10).isActive = true
//        tempImageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
//         tempImageView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
//        tempImageView.bottomAnchor.constraint(equalTo: bottomStack.topAnchor, constant: -10).isActive = true
//
        
    }
    
    @IBAction func clearButton(_ sender: UIButton)
    {
        tempImageView.image = nil
    }
    
    @IBAction func mySlider(_ sender: UISlider)
    {
        lineWidth = CGFloat(sender.value)
    }
    
    @IBAction func orangeColor(_ sender: UIButton)
    {
        drawColor = UIColor.orange
        eraserBool = false
        highlighterBool = false
    }
    
    @IBAction func yellowColor(_ sender: UIButton)
    {
        drawColor = UIColor.yellow
        eraserBool = false
        highlighterBool = false
    }
    
    @IBAction func greenColor(_ sender: UIButton)
    {
        drawColor = UIColor.green
        eraserBool = false
        highlighterBool = false
    }
    
    @IBAction func purpleColor(_ sender: UIButton)
    {
        drawColor = UIColor.purple
        eraserBool = false
        highlighterBool = false
    }
    
    @IBAction func blackColor(_ sender: UIButton)
    {
        drawColor = UIColor.black
        eraserBool = false
        highlighterBool = false
    }
    
    @IBAction func redColor(_ sender: UIButton)
    {
        redbutton.showsTouchWhenHighlighted = true
        drawColor = UIColor.red
        eraserBool = false
        highlighterBool = false
    }
    
    @IBAction func blueColor(_ sender: UIButton)
    {
        //blueColor.showstouchwhen
        drawColor = UIColor.blue
        eraserBool = false
        highlighterBool = false
    }
    
    @IBAction func eraser(_ sender: UIButton)
    {
        drawColor = UIColor.white
        eraserBool = true
        highlighterBool = false
    }
    
    @IBAction func highlighter(_ sender: UIButton)
    {
        drawColor = UIColor.yellow
        highlighterBool = true
        eraserBool = false
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        guard let touch = touches.first
            else
        {
            return
        }
        swipe = false
        
        lastPoint = touch.location(in: view)
    }
    

    func drawLine(from fromPoint: CGPoint, to toPoint: CGPoint)
    {
        //UIScreen.main.bounds.size
        UIGraphicsBeginImageContext(UIScreen.main.bounds.size)
        guard let context = UIGraphicsGetCurrentContext() else
        {
            return
        }
        tempImageView.image?.draw(in: view.bounds)

        context.move(to: fromPoint)
        context.addLine(to: toPoint)
        
        context.setLineCap(.round)
        
        if highlighterBool
        {
            context.setBlendMode(.overlay)
        }
        else if eraserBool
        {
        context.setBlendMode(.clear)
        }
        else
        {
            context.setBlendMode(.normal)
        }
        
        context.setLineWidth(lineWidth)
        context.setStrokeColor(drawColor.cgColor)
        
        context.strokePath()
        
        tempImageView.image = UIGraphicsGetImageFromCurrentImageContext()

        tempImageView.alpha = 1.0
        UIGraphicsEndImageContext()

    }

    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent? )
    {
        guard let touch = touches.first
            else
        {
            return
        }
        swipe = true
        let currentPoint = touch.location(in: view)

        drawLine(from: lastPoint, to: currentPoint)
        lastPoint = currentPoint
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        if swipe != true
        {
           drawLine(from: lastPoint
            , to: lastPoint)
        }
        UIGraphicsBeginImageContext(mainImageView.frame.size)
        mainImageView.image?.draw(in: view.bounds, blendMode: .normal, alpha: 1.0)
        tempImageView.image?.draw(in: view.bounds, blendMode: .normal, alpha: 1.0)
        
 UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
    }
    
    
    @IBAction func cameraPicker(_ sender: UIButton)
    {
        //
    }
    
    @IBAction func exportButton(_ sender: UIButton)
    {
    
        var myImage = tempImageView.image
        let items = [myImage]
        let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
        

        present(ac, animated: true)
    }
}
