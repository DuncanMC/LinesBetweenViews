//
//  LinesBetweenViews.swift
//  LinesBetweenViews
//
//  Created by Duncan Champney on 4/27/22.
//

import UIKit

/// This class demonstrates a custom UIView subclass that sets up its backing layer as a CAShapeLayer.
/// It iterates through its subviews, drawing lines between pairs of subviews. If it contains an odd number of subviews
/// it won't draw a line to the last subview.
/// To use this class in to draw lines in a matching game you would probably want to give it a property containing an array of pairs of views
/// (or an array of frame rectangles, or center points) so that you could control which views it connected.

class LinesBetweenViews: UIView {

    /// A computed property that casts the view's backing layer to type CAShapeLayer for convenience.
    /// This will likely cause a crash if the view's layer is NOT a CAShapeLayer. (See the `override class var layerClass` below)

    var shapeLayer: CAShapeLayer { return self.layer as! CAShapeLayer }

    /// This is the color used to draw the path. If you change it, the didSet will change the layer's strokeColor
    public var pathColor: UIColor = .blue{
        didSet {
            guard let layer = self.layer as? CAShapeLayer else { return }
            layer.strokeColor = pathColor.cgColor
        }
    }

    /// This declaration causes the  view's backing layer to be a CAShapeLayer
    override class var layerClass : AnyClass {
        return CAShapeLayer.self}

    /// If the view's bounds change, update our layer's path
    override var bounds: CGRect {
        didSet {
            createPath()
        }
    }

    /// When we get added to a view, set up our shape layer's properties.
    override func didMoveToSuperview() {
        shapeLayer.strokeColor = pathColor.cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineWidth = 2
        shapeLayer.borderWidth = 1
        shapeLayer.borderColor = UIColor.cyan.cgColor
    }

    override func didAddSubview(_ subview: UIView) {
        createPath()
    }

    /// Build the path for our shape layer and install it.
    /// If you want to use different rules to draw your view's path, change the code in this method.
    
    public func createPath() {
        let views = self.subviews
        guard views.count > 1 else { return }
        let path = UIBezierPath()

        //Draw lines between pairs of subviews.
        for index in stride(from: 0, to:views.count, by: 2) {
            let nextIndex = index + 1
            guard nextIndex < views.count else { continue }
            var point = CGPoint(x: views[index].frame.midX, y: views[index].frame.midY)
            path.move(to: point)
            point = CGPoint(x: views[nextIndex].frame.midX, y: views[nextIndex].frame.midY)
            path.addLine(to: point)
        }
        shapeLayer.path = path.cgPath
    }
}
