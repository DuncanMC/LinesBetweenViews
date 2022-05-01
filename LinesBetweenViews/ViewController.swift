//
//  ViewController.swift
//  LinesBetweenViews
//
//  Created by Duncan Champney on 4/27/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var linesBetweenViews: LinesBetweenViews!

    @IBAction func handleButton(_ sender: UIButton) {
        linesBetweenViews.createPath()
        for aView in linesBetweenViews.subviews {
            aView.center = CGPoint(x: CGFloat.random(in: linesBetweenViews.bounds.minX+aView.bounds.width/1.9...linesBetweenViews.bounds.maxX-aView.bounds.width/1.9),
                                   y: CGFloat.random(in: linesBetweenViews.bounds.minY+aView.bounds.height/1.9...linesBetweenViews.bounds.maxY-aView.bounds.height/1.9))
            linesBetweenViews.createPath()
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        linesBetweenViews.createPath()
    }

    override func viewDidLayoutSubviews() {
    }
}

