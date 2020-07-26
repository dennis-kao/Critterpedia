//
//  CritterPicker.swift
//  Critterpedia
//
//  Created by Dennis Kao on 2020-04-25.
//  Copyright © 2020 Dennis Kao. All rights reserved.
//

import UIKit

protocol CritterPickerDelegate {
    func critterPicked(picked: Critter.Category)
}

final class CritterPicker: UIControl {
    
    var delegate: CritterPickerDelegate? = nil
    
    var selectedCritter: Critter.Category = .Insect {
        didSet {
            setFillColors()
            delegate?.critterPicked(picked: selectedCritter)
        }
    }
    
    fileprivate let circleFillColor: UIColor = .white
    fileprivate let selectedColor: UIColor = #colorLiteral(red: 0.9764705882, green: 0.7921568627, blue: 0.3921568627, alpha: 1)
    fileprivate let unselectedColor: UIColor = #colorLiteral(red: 0.5176470588, green: 0.4745098039, blue: 0.3960784314, alpha: 1)
    
    fileprivate var circleCenter1 = CGPoint()
    fileprivate var circleCenter2 = CGPoint()
    fileprivate var circleCenter3 = CGPoint()
    fileprivate var radius = CGFloat()
    fileprivate var imageYOffset: CGFloat = -10
    fileprivate let textYOffset: CGFloat = 20

    fileprivate let circleBackgroundLayer = CAShapeLayer()
    fileprivate let insectsLayer = CAShapeLayer()
    fileprivate let fishLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        // fishShape bezierPath is vertically inverted
        layer.transform = CATransform3DMakeRotation(.pi, 1, 0, 0)
        return layer
    }()
    fileprivate let octopusLayer = CAShapeLayer()
    
    fileprivate let insectsTextLayer = CATextLayer()
    fileprivate let fishTextLayer = CATextLayer()
    fileprivate let octopusTextLayer = CATextLayer()

    fileprivate var insectShape: UIBezierPath = {
        let shape = UIBezierPath()
        shape.move(to: CGPoint(x: 72.89, y: 5.9))
        shape.addCurve(to: CGPoint(x: 65.74, y: 0.96), controlPoint1: CGPoint(x: 71.21, y: 3.14), controlPoint2: CGPoint(x: 68.83, y: 1.49))
        shape.addCurve(to: CGPoint(x: 57.69, y: 2.59), controlPoint1: CGPoint(x: 63.19, y: 0.45), controlPoint2: CGPoint(x: 60.51, y: 1))
        shape.addCurve(to: CGPoint(x: 50.43, y: 7.7), controlPoint1: CGPoint(x: 55.98, y: 3.52), controlPoint2: CGPoint(x: 53.56, y: 5.23))
        shape.addCurve(to: CGPoint(x: 43.44, y: 14.48), controlPoint1: CGPoint(x: 47.05, y: 10.39), controlPoint2: CGPoint(x: 44.72, y: 12.65))
        shape.addCurve(to: CGPoint(x: 42.13, y: 17.07), controlPoint1: CGPoint(x: 43.02, y: 15.15), controlPoint2: CGPoint(x: 42.58, y: 16.01))
        shape.addCurve(to: CGPoint(x: 42.05, y: 17.19), controlPoint1: CGPoint(x: 42.07, y: 17.13), controlPoint2: CGPoint(x: 42.05, y: 17.17))
        shape.addCurve(to: CGPoint(x: 38.06, y: 22.82), controlPoint1: CGPoint(x: 41.36, y: 18.6), controlPoint2: CGPoint(x: 40.03, y: 20.48))
        shape.addLine(to: CGPoint(x: 39.57, y: 18.07))
        shape.addLine(to: CGPoint(x: 39.85, y: 17.59))
        shape.addLine(to: CGPoint(x: 40.21, y: 17.39))
        shape.addLine(to: CGPoint(x: 40.89, y: 17.39))
        shape.addCurve(to: CGPoint(x: 41.13, y: 17.39), controlPoint1: CGPoint(x: 41.02, y: 17.39), controlPoint2: CGPoint(x: 41.1, y: 17.39))
        shape.addLine(to: CGPoint(x: 41.41, y: 17.27))
        shape.addCurve(to: CGPoint(x: 41.73, y: 16.95), controlPoint1: CGPoint(x: 41.57, y: 17.19), controlPoint2: CGPoint(x: 41.68, y: 17.09))
        shape.addCurve(to: CGPoint(x: 41.73, y: 16.68), controlPoint1: CGPoint(x: 41.76, y: 16.85), controlPoint2: CGPoint(x: 41.76, y: 16.76))
        shape.addCurve(to: CGPoint(x: 41.37, y: 16.52), controlPoint1: CGPoint(x: 41.6, y: 16.57), controlPoint2: CGPoint(x: 41.48, y: 16.52))
        shape.addLine(to: CGPoint(x: 40.85, y: 16.32))
        shape.addCurve(to: CGPoint(x: 40.57, y: 16.32), controlPoint1: CGPoint(x: 40.77, y: 16.29), controlPoint2: CGPoint(x: 40.68, y: 16.29))
        shape.addLine(to: CGPoint(x: 39.57, y: 16.52))
        shape.addLine(to: CGPoint(x: 39.49, y: 16.52))
        shape.addCurve(to: CGPoint(x: 38.34, y: 17.71), controlPoint1: CGPoint(x: 39.07, y: 16.68), controlPoint2: CGPoint(x: 38.68, y: 17.07))
        shape.addLine(to: CGPoint(x: 38.34, y: 17.79))
        shape.addCurve(to: CGPoint(x: 38.18, y: 18.11), controlPoint1: CGPoint(x: 38.26, y: 17.9), controlPoint2: CGPoint(x: 38.2, y: 18.01))
        shape.addLine(to: CGPoint(x: 38.18, y: 18.19))
        shape.addCurve(to: CGPoint(x: 37.5, y: 20.11), controlPoint1: CGPoint(x: 37.91, y: 18.78), controlPoint2: CGPoint(x: 37.69, y: 19.41))
        shape.addCurve(to: CGPoint(x: 36.78, y: 18.19), controlPoint1: CGPoint(x: 37.29, y: 19.41), controlPoint2: CGPoint(x: 37.05, y: 18.78))
        shape.addLine(to: CGPoint(x: 36.78, y: 18.11))
        shape.addCurve(to: CGPoint(x: 36.62, y: 17.79), controlPoint1: CGPoint(x: 36.76, y: 18.01), controlPoint2: CGPoint(x: 36.7, y: 17.9))
        shape.addLine(to: CGPoint(x: 36.62, y: 17.71))
        shape.addCurve(to: CGPoint(x: 35.47, y: 16.52), controlPoint1: CGPoint(x: 36.28, y: 17.07), controlPoint2: CGPoint(x: 35.89, y: 16.68))
        shape.addLine(to: CGPoint(x: 35.39, y: 16.52))
        shape.addLine(to: CGPoint(x: 34.39, y: 16.32))
        shape.addCurve(to: CGPoint(x: 34.11, y: 16.32), controlPoint1: CGPoint(x: 34.28, y: 16.29), controlPoint2: CGPoint(x: 34.19, y: 16.29))
        shape.addLine(to: CGPoint(x: 33.59, y: 16.52))
        shape.addCurve(to: CGPoint(x: 33.23, y: 16.68), controlPoint1: CGPoint(x: 33.48, y: 16.52), controlPoint2: CGPoint(x: 33.36, y: 16.57))
        shape.addCurve(to: CGPoint(x: 33.23, y: 16.95), controlPoint1: CGPoint(x: 33.2, y: 16.76), controlPoint2: CGPoint(x: 33.2, y: 16.85))
        shape.addCurve(to: CGPoint(x: 33.55, y: 17.27), controlPoint1: CGPoint(x: 33.28, y: 17.09), controlPoint2: CGPoint(x: 33.39, y: 17.19))
        shape.addLine(to: CGPoint(x: 33.83, y: 17.39))
        shape.addCurve(to: CGPoint(x: 34.07, y: 17.39), controlPoint1: CGPoint(x: 33.86, y: 17.39), controlPoint2: CGPoint(x: 33.94, y: 17.39))
        shape.addLine(to: CGPoint(x: 34.75, y: 17.39))
        shape.addLine(to: CGPoint(x: 35.11, y: 17.59))
        shape.addLine(to: CGPoint(x: 35.39, y: 18.07))
        shape.addLine(to: CGPoint(x: 36.9, y: 22.82))
        shape.addCurve(to: CGPoint(x: 32.91, y: 17.19), controlPoint1: CGPoint(x: 34.93, y: 20.48), controlPoint2: CGPoint(x: 33.6, y: 18.6))
        shape.addCurve(to: CGPoint(x: 32.83, y: 17.07), controlPoint1: CGPoint(x: 32.91, y: 17.17), controlPoint2: CGPoint(x: 32.89, y: 17.13))
        shape.addCurve(to: CGPoint(x: 31.52, y: 14.48), controlPoint1: CGPoint(x: 32.38, y: 16.01), controlPoint2: CGPoint(x: 31.94, y: 15.15))
        shape.addCurve(to: CGPoint(x: 24.53, y: 7.7), controlPoint1: CGPoint(x: 30.24, y: 12.65), controlPoint2: CGPoint(x: 27.91, y: 10.39))
        shape.addCurve(to: CGPoint(x: 17.27, y: 2.59), controlPoint1: CGPoint(x: 21.4, y: 5.23), controlPoint2: CGPoint(x: 18.98, y: 3.52))
        shape.addCurve(to: CGPoint(x: 9.22, y: 0.96), controlPoint1: CGPoint(x: 14.45, y: 1), controlPoint2: CGPoint(x: 11.77, y: 0.45))
        shape.addCurve(to: CGPoint(x: 2.07, y: 5.9), controlPoint1: CGPoint(x: 6.13, y: 1.49), controlPoint2: CGPoint(x: 3.75, y: 3.14))
        shape.addLine(to: CGPoint(x: 2.15, y: 5.9))
        shape.addCurve(to: CGPoint(x: 1.91, y: 21.62), controlPoint1: CGPoint(x: 0.24, y: 8.99), controlPoint2: CGPoint(x: 0.16, y: 14.23))
        shape.addLine(to: CGPoint(x: 1.91, y: 21.66))
        shape.addCurve(to: CGPoint(x: 8.66, y: 36.1), controlPoint1: CGPoint(x: 3.38, y: 28.52), controlPoint2: CGPoint(x: 5.63, y: 33.34))
        shape.addLine(to: CGPoint(x: 8.58, y: 36.1))
        shape.addCurve(to: CGPoint(x: 14.04, y: 39.41), controlPoint1: CGPoint(x: 9.61, y: 37.11), controlPoint2: CGPoint(x: 11.44, y: 38.22))
        shape.addCurve(to: CGPoint(x: 9.3, y: 45.56), controlPoint1: CGPoint(x: 11.22, y: 42.05), controlPoint2: CGPoint(x: 9.64, y: 44.1))
        shape.addCurve(to: CGPoint(x: 9.3, y: 50.47), controlPoint1: CGPoint(x: 9, y: 47.07), controlPoint2: CGPoint(x: 9, y: 48.71))
        shape.addCurve(to: CGPoint(x: 17.15, y: 63.75), controlPoint1: CGPoint(x: 10.33, y: 57.35), controlPoint2: CGPoint(x: 12.95, y: 61.78))
        shape.addCurve(to: CGPoint(x: 26.17, y: 63.35), controlPoint1: CGPoint(x: 19.95, y: 65.11), controlPoint2: CGPoint(x: 22.95, y: 64.97))
        shape.addCurve(to: CGPoint(x: 34.47, y: 53.86), controlPoint1: CGPoint(x: 29.68, y: 61.65), controlPoint2: CGPoint(x: 32.45, y: 58.48))
        shape.addLine(to: CGPoint(x: 34.51, y: 53.82))
        shape.addLine(to: CGPoint(x: 36.14, y: 47.83))
        shape.addLine(to: CGPoint(x: 36.26, y: 48.03))
        shape.addCurve(to: CGPoint(x: 36.26, y: 48.11), controlPoint1: CGPoint(x: 36.26, y: 48.06), controlPoint2: CGPoint(x: 36.26, y: 48.09))
        shape.addLine(to: CGPoint(x: 36.5, y: 48.67))
        shape.addLine(to: CGPoint(x: 36.5, y: 48.59))
        shape.addLine(to: CGPoint(x: 36.74, y: 49.39))
        shape.addCurve(to: CGPoint(x: 36.94, y: 49.63), controlPoint1: CGPoint(x: 36.77, y: 49.52), controlPoint2: CGPoint(x: 36.84, y: 49.6))
        shape.addCurve(to: CGPoint(x: 37.38, y: 49.71), controlPoint1: CGPoint(x: 37.07, y: 49.68), controlPoint2: CGPoint(x: 37.22, y: 49.71))
        shape.addCurve(to: CGPoint(x: 37.5, y: 49.71), controlPoint1: CGPoint(x: 37.41, y: 49.71), controlPoint2: CGPoint(x: 37.45, y: 49.71))
        shape.addCurve(to: CGPoint(x: 37.58, y: 49.71), controlPoint1: CGPoint(x: 37.53, y: 49.71), controlPoint2: CGPoint(x: 37.55, y: 49.71))
        shape.addCurve(to: CGPoint(x: 38.02, y: 49.63), controlPoint1: CGPoint(x: 37.74, y: 49.71), controlPoint2: CGPoint(x: 37.89, y: 49.68))
        shape.addCurve(to: CGPoint(x: 38.22, y: 49.39), controlPoint1: CGPoint(x: 38.13, y: 49.6), controlPoint2: CGPoint(x: 38.19, y: 49.52))
        shape.addLine(to: CGPoint(x: 38.46, y: 48.59))
        shape.addLine(to: CGPoint(x: 38.46, y: 48.67))
        shape.addLine(to: CGPoint(x: 38.7, y: 48.11))
        shape.addCurve(to: CGPoint(x: 38.7, y: 48.03), controlPoint1: CGPoint(x: 38.7, y: 48.09), controlPoint2: CGPoint(x: 38.7, y: 48.06))
        shape.addLine(to: CGPoint(x: 38.82, y: 47.83))
        shape.addLine(to: CGPoint(x: 40.45, y: 53.82))
        shape.addLine(to: CGPoint(x: 40.49, y: 53.86))
        shape.addCurve(to: CGPoint(x: 48.79, y: 63.35), controlPoint1: CGPoint(x: 42.51, y: 58.48), controlPoint2: CGPoint(x: 45.28, y: 61.65))
        shape.addCurve(to: CGPoint(x: 57.81, y: 63.75), controlPoint1: CGPoint(x: 52.01, y: 64.97), controlPoint2: CGPoint(x: 55.01, y: 65.11))
        shape.addCurve(to: CGPoint(x: 65.66, y: 50.47), controlPoint1: CGPoint(x: 62.01, y: 61.78), controlPoint2: CGPoint(x: 64.63, y: 57.35))
        shape.addCurve(to: CGPoint(x: 65.66, y: 45.56), controlPoint1: CGPoint(x: 65.96, y: 48.71), controlPoint2: CGPoint(x: 65.96, y: 47.07))
        shape.addCurve(to: CGPoint(x: 60.92, y: 39.41), controlPoint1: CGPoint(x: 65.32, y: 44.1), controlPoint2: CGPoint(x: 63.74, y: 42.05))
        shape.addCurve(to: CGPoint(x: 66.38, y: 36.1), controlPoint1: CGPoint(x: 63.52, y: 38.22), controlPoint2: CGPoint(x: 65.35, y: 37.11))
        shape.addLine(to: CGPoint(x: 66.3, y: 36.1))
        shape.addCurve(to: CGPoint(x: 73.05, y: 21.66), controlPoint1: CGPoint(x: 69.34, y: 33.34), controlPoint2: CGPoint(x: 71.58, y: 28.52))
        shape.addLine(to: CGPoint(x: 73.05, y: 21.62))
        shape.addCurve(to: CGPoint(x: 72.81, y: 5.9), controlPoint1: CGPoint(x: 74.8, y: 14.23), controlPoint2: CGPoint(x: 74.72, y: 8.99))
        shape.addLine(to: CGPoint(x: 72.89, y: 5.9))
        shape.close()
        return shape
    }()
    
    fileprivate var fishShape: UIBezierPath = {
        let shape = UIBezierPath()
        shape.move(to: CGPoint(x: 73.3, y: 35.32))
        shape.addLine(to: CGPoint(x: 65.34, y: 29.49))
        shape.addCurve(to: CGPoint(x: 29.17, y: 38.62), controlPoint1: CGPoint(x: 55.49, y: 22.27), controlPoint2: CGPoint(x: 48.48, y: 38.62))
        shape.addCurve(to: CGPoint(x: 0.76, y: 19.5), controlPoint1: CGPoint(x: 11.41, y: 38.62), controlPoint2: CGPoint(x: 0.76, y: 23.47))
        shape.addCurve(to: CGPoint(x: 29.17, y: 0.38), controlPoint1: CGPoint(x: 0.76, y: 15.53), controlPoint2: CGPoint(x: 11.41, y: 0.38))
        shape.addCurve(to: CGPoint(x: 65.34, y: 9.51), controlPoint1: CGPoint(x: 48.48, y: 0.38), controlPoint2: CGPoint(x: 55.49, y: 16.73))
        shape.addLine(to: CGPoint(x: 73.3, y: 3.68))
        shape.addCurve(to: CGPoint(x: 68.75, y: 19.5), controlPoint1: CGPoint(x: 74.86, y: 7.65), controlPoint2: CGPoint(x: 73.58, y: 13.57))
        shape.addCurve(to: CGPoint(x: 73.3, y: 35.32), controlPoint1: CGPoint(x: 73.58, y: 25.43), controlPoint2: CGPoint(x: 74.86, y: 31.4))
        shape.close()
        shape.move(to: CGPoint(x: 15.1, y: 20.31))
        shape.addCurve(to: CGPoint(x: 11.51, y: 23.94), controlPoint1: CGPoint(x: 13.12, y: 20.31), controlPoint2: CGPoint(x: 11.51, y: 21.94))
        shape.addCurve(to: CGPoint(x: 15.1, y: 27.53), controlPoint1: CGPoint(x: 11.51, y: 25.9), controlPoint2: CGPoint(x: 13.12, y: 27.53))
        shape.addCurve(to: CGPoint(x: 18.7, y: 23.94), controlPoint1: CGPoint(x: 17.09, y: 27.53), controlPoint2: CGPoint(x: 18.7, y: 25.9))
        shape.addCurve(to: CGPoint(x: 15.1, y: 20.31), controlPoint1: CGPoint(x: 18.7, y: 21.94), controlPoint2: CGPoint(x: 17.09, y: 20.31))
        shape.close()
        return shape
    }()
    
    fileprivate var octopusShape: UIBezierPath = {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 21.1, y: 21.6))
        path.addCurve(to: CGPoint(x: 22.9, y: 23.4), controlPoint1: CGPoint(x: 22.1, y: 21.6), controlPoint2: CGPoint(x: 22.9, y: 22.4))
        path.addCurve(to: CGPoint(x: 21.1, y: 25.1), controlPoint1: CGPoint(x: 22.9, y: 24.3), controlPoint2: CGPoint(x: 22.1, y: 25.1))
        path.addCurve(to: CGPoint(x: 19.3, y: 23.4), controlPoint1: CGPoint(x: 20.1, y: 25.1), controlPoint2: CGPoint(x: 19.3, y: 24.3))
        path.addCurve(to: CGPoint(x: 21.1, y: 21.6), controlPoint1: CGPoint(x: 19.3, y: 22.4), controlPoint2: CGPoint(x: 20.1, y: 21.6))
        path.move(to: CGPoint(x: 28.9, y: 21.6))
        path.addCurve(to: CGPoint(x: 30.7, y: 23.4), controlPoint1: CGPoint(x: 29.9, y: 21.6), controlPoint2: CGPoint(x: 30.7, y: 22.4))
        path.addCurve(to: CGPoint(x: 28.9, y: 25.1), controlPoint1: CGPoint(x: 30.7, y: 24.3), controlPoint2: CGPoint(x: 29.9, y: 25.1))
        path.addCurve(to: CGPoint(x: 27.1, y: 23.4), controlPoint1: CGPoint(x: 27.9, y: 25.1), controlPoint2: CGPoint(x: 27.1, y: 24.3))
        path.addCurve(to: CGPoint(x: 28.9, y: 21.6), controlPoint1: CGPoint(x: 27.1, y: 22.4), controlPoint2: CGPoint(x: 27.9, y: 21.6))
        path.close()
        path.move(to: CGPoint(x: 35.6, y: 3.6))
        path.addCurve(to: CGPoint(x: 14.4, y: 3.6), controlPoint1: CGPoint(x: 29.8, y: -1.2), controlPoint2: CGPoint(x: 20.2, y: -1.2))
        path.addCurve(to: CGPoint(x: 9.5, y: 20), controlPoint1: CGPoint(x: 9.7, y: 7.6), controlPoint2: CGPoint(x: 8, y: 14.1))
        path.addCurve(to: CGPoint(x: 13.8, y: 27.5), controlPoint1: CGPoint(x: 10.2, y: 22.8), controlPoint2: CGPoint(x: 11.6, y: 25.4))
        path.addCurve(to: CGPoint(x: 9.9, y: 35.8), controlPoint1: CGPoint(x: 10.8, y: 29.5), controlPoint2: CGPoint(x: 10.4, y: 32.7))
        path.addCurve(to: CGPoint(x: 3.6, y: 42.5), controlPoint1: CGPoint(x: 9.5, y: 39.1), controlPoint2: CGPoint(x: 9, y: 42.5))
        path.addCurve(to: CGPoint(x: 3.4, y: 45.6), controlPoint1: CGPoint(x: 1.7, y: 42.6), controlPoint2: CGPoint(x: 1.5, y: 45.3))
        path.addCurve(to: CGPoint(x: 13.9, y: 38.7), controlPoint1: CGPoint(x: 11, y: 46.6), controlPoint2: CGPoint(x: 12.4, y: 42.6))
        path.addCurve(to: CGPoint(x: 17, y: 34.1), controlPoint1: CGPoint(x: 14.6, y: 37), controlPoint2: CGPoint(x: 15.3, y: 35.1))
        path.addCurve(to: CGPoint(x: 17.4, y: 38.9), controlPoint1: CGPoint(x: 16.8, y: 35.6), controlPoint2: CGPoint(x: 17.1, y: 37.2))
        path.addCurve(to: CGPoint(x: 15.6, y: 47.2), controlPoint1: CGPoint(x: 17.9, y: 41.9), controlPoint2: CGPoint(x: 18.4, y: 45.4))
        path.addCurve(to: CGPoint(x: 17, y: 49.9), controlPoint1: CGPoint(x: 14, y: 48.2), controlPoint2: CGPoint(x: 15.3, y: 50.6))
        path.addCurve(to: CGPoint(x: 24, y: 38.5), controlPoint1: CGPoint(x: 21.9, y: 47.7), controlPoint2: CGPoint(x: 23, y: 42.8))
        path.addCurve(to: CGPoint(x: 25, y: 34.9), controlPoint1: CGPoint(x: 24.3, y: 37.2), controlPoint2: CGPoint(x: 24.6, y: 35.9))
        path.addCurve(to: CGPoint(x: 26, y: 38.5), controlPoint1: CGPoint(x: 25.4, y: 35.9), controlPoint2: CGPoint(x: 25.7, y: 37.2))
        path.addCurve(to: CGPoint(x: 33, y: 49.9), controlPoint1: CGPoint(x: 27, y: 42.8), controlPoint2: CGPoint(x: 28.1, y: 47.7))
        path.addCurve(to: CGPoint(x: 34.4, y: 47.2), controlPoint1: CGPoint(x: 34.7, y: 50.6), controlPoint2: CGPoint(x: 36, y: 48.2))
        path.addCurve(to: CGPoint(x: 32.6, y: 38.9), controlPoint1: CGPoint(x: 31.6, y: 45.4), controlPoint2: CGPoint(x: 32.1, y: 41.9))
        path.addCurve(to: CGPoint(x: 33, y: 34.1), controlPoint1: CGPoint(x: 32.9, y: 37.2), controlPoint2: CGPoint(x: 33.2, y: 35.6))
        path.addCurve(to: CGPoint(x: 36.1, y: 38.7), controlPoint1: CGPoint(x: 34.7, y: 35.1), controlPoint2: CGPoint(x: 35.4, y: 37))
        path.addCurve(to: CGPoint(x: 46.6, y: 45.6), controlPoint1: CGPoint(x: 37.6, y: 42.6), controlPoint2: CGPoint(x: 39, y: 46.6))
        path.addCurve(to: CGPoint(x: 46.4, y: 42.5), controlPoint1: CGPoint(x: 48.5, y: 45.3), controlPoint2: CGPoint(x: 48.3, y: 42.6))
        path.addCurve(to: CGPoint(x: 40.1, y: 35.8), controlPoint1: CGPoint(x: 41, y: 42.4), controlPoint2: CGPoint(x: 40.5, y: 39.1))
        path.addCurve(to: CGPoint(x: 36.2, y: 27.5), controlPoint1: CGPoint(x: 39.6, y: 32.7), controlPoint2: CGPoint(x: 39.2, y: 29.5))
        path.addCurve(to: CGPoint(x: 40.5, y: 20), controlPoint1: CGPoint(x: 38.4, y: 25.4), controlPoint2: CGPoint(x: 39.8, y: 22.8))
        path.addCurve(to: CGPoint(x: 35.6, y: 3.6), controlPoint1: CGPoint(x: 42, y: 14.1), controlPoint2: CGPoint(x: 40.3, y: 7.6))
        path.close()
        return path
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    fileprivate func commonInit() {
        self.isOpaque = false
        setFillColors()
        layer.addSublayer(circleBackgroundLayer)
        layer.addSublayer(insectsLayer)
        layer.addSublayer(insectsTextLayer)
        layer.addSublayer(fishLayer)
        layer.addSublayer(fishTextLayer)
        layer.addSublayer(octopusLayer)
        layer.addSublayer(octopusTextLayer)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateBackgroundCircleLayer()
        updateShapeLayer(shape: insectShape, layer: insectsLayer, circleCenter: circleCenter1)
        updateTextLayer(textLayer: insectsTextLayer, point: CGPoint(x: insectsLayer.frame.midX, y: insectsLayer.frame.maxY + textYOffset), text: NSLocalizedString("Insects", comment: "Critter type Insects"))
        updateShapeLayer(shape: fishShape, layer: fishLayer, circleCenter: CGPoint(x: circleCenter2.x, y: circleCenter2.y + insectsLayer.bounds.height * 0.125))
        updateTextLayer(textLayer: fishTextLayer, point: CGPoint(x: fishLayer.frame.midX, y: insectsLayer.frame.maxY + textYOffset), text: NSLocalizedString("Fish", comment: "Critter type Fish"))
        updateShapeLayer(shape: octopusShape, layer: octopusLayer, circleCenter: CGPoint(x: circleCenter3.x, y: circleCenter3.y))
        updateTextLayer(textLayer: octopusTextLayer, point: CGPoint(x: octopusLayer.frame.midX, y: insectsLayer.frame.maxY + textYOffset), text: NSLocalizedString("Sea", comment: "Critter type Sea"))
    }
    
    fileprivate func updateBackgroundCircleLayer() {
                
        self.radius = min(bounds.width, bounds.height) / 3.5
        let circleGap: CGFloat = self.radius * 0.80

        self.circleCenter1 = CGPoint(x: bounds.midX - circleGap - radius, y: bounds.midY)
        self.circleCenter2 = CGPoint(x: bounds.midX, y: bounds.midY)
        self.circleCenter3 = CGPoint(x: bounds.midX + circleGap + radius, y: bounds.midY)

        let circlePath1 = UIBezierPath(arcCenter: circleCenter1,
            radius: self.radius,
        startAngle: 0,
          endAngle: 360,
         clockwise: true)
        
        let circlePath2 = UIBezierPath(arcCenter: circleCenter2,
            radius: self.radius,
        startAngle: 0,
          endAngle: 360,
         clockwise: true)

        let circlePath3 = UIBezierPath(arcCenter: circleCenter3,
            radius: self.radius,
        startAngle: 0,
          endAngle: 360,
         clockwise: true)

        let combined = UIBezierPath()
        combined.append(circlePath1)
        combined.append(circlePath2)
        combined.append(circlePath3)
        combined.usesEvenOddFillRule = false
                
        circleBackgroundLayer.path = combined.cgPath
        circleBackgroundLayer.contentsGravity = .center
        circleBackgroundLayer.frame = bounds
        circleBackgroundLayer.fillColor = circleFillColor.cgColor
    }
    
    fileprivate func setFillColors() {
        switch(selectedCritter) {
            case .Insect:
                insectsLayer.fillColor = selectedColor.cgColor
                insectsTextLayer.foregroundColor = selectedColor.cgColor
                fishLayer.fillColor = unselectedColor.cgColor
                fishTextLayer.foregroundColor = unselectedColor.cgColor
                octopusLayer.fillColor = unselectedColor.cgColor
                octopusTextLayer.foregroundColor = unselectedColor.cgColor
            case .Fish:
                fishLayer.fillColor = selectedColor.cgColor
                fishTextLayer.foregroundColor = selectedColor.cgColor
                insectsLayer.fillColor = unselectedColor.cgColor
                insectsTextLayer.foregroundColor = unselectedColor.cgColor
                octopusLayer.fillColor = unselectedColor.cgColor
                octopusTextLayer.foregroundColor = unselectedColor.cgColor
            case .Sea:
                octopusLayer.fillColor = selectedColor.cgColor
                octopusTextLayer.foregroundColor = selectedColor.cgColor
                fishLayer.fillColor = unselectedColor.cgColor
                fishTextLayer.foregroundColor = unselectedColor.cgColor
                insectsLayer.fillColor = unselectedColor.cgColor
                insectsTextLayer.foregroundColor = unselectedColor.cgColor
        }
    }
    
    fileprivate func updateShapeLayer(shape: UIBezierPath, layer: CAShapeLayer, circleCenter: CGPoint) {
        let aspectRatio = shape.bounds.width / shape.bounds.height
        
        shape.apply(CGAffineTransform(scaleX: radius / shape.bounds.width, y: radius / shape.bounds.height / aspectRatio))
        
        layer.path = shape.cgPath
        layer.contentsGravity = .center
        layer.frame = CGRect(x: 0, y: 0, width: shape.bounds.width, height: shape.bounds.height)
        layer.position = CGPoint(x: circleCenter.x, y: circleCenter.y + imageYOffset)
    }
    
    fileprivate func updateTextLayer(textLayer: CATextLayer, point: CGPoint, text: String) {
        
        textLayer.frame = CGRect(x: 0, y: 0, width: 80, height: 20)
        textLayer.position = point
        textLayer.string = text
        textLayer.fontSize = 20
        textLayer.font = UIFont(name: "FinkHeavy", size: 20)
        textLayer.contentsScale = UIScreen.main.scale
        textLayer.alignmentMode = .center
    }
    
    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        func layerFor(_ touch: UITouch) -> CALayer? {
            let touchLocation = touch.location(in: self)
            let locationInView = self.convert(touchLocation, to: nil)

            let hitPresentationLayer = self.layer.presentation()?.hitTest(locationInView)
            return hitPresentationLayer?.model()
        }
        
        guard let touch = touch, let layer = layerFor(touch) else {
            return
        }
        
        if (layer == insectsLayer || layer == insectsTextLayer) && selectedCritter != .Insect {
            selectedCritter = .Insect
        } else if (layer == fishLayer || layer == fishTextLayer) && selectedCritter != .Fish {
            selectedCritter = .Fish
        } else if (layer == octopusLayer || layer == octopusTextLayer) && selectedCritter != .Sea {
            selectedCritter = .Sea
        }
    }
}
