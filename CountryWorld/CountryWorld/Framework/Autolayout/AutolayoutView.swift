//
//  AutolayoutView.swift
//  CountryWorld
//
//  Created by Gabriele Moia on 18/02/23.
//

import Foundation
import UIKit

class AutolayoutView: UIView {
    
    public private(set) var autolayoutView: UIView!
    
    open func nibBundle() -> Bundle {
        return Bundle(for: type(of: self))
    }
    
    open func nibName() -> String {
        return String(describing: type(of: self))
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.setupAutolayout()
        self.configure()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupAutolayout()
        self.configure()
    }
    
    private func setupAutolayout() {
        guard let xib = self.nibBundle().loadNibNamed(self.nibName(), owner: self, options: nil),
              let backedView = xib.first as? UIView else {
            return
        }
        
        self.autolayoutView = backedView
        self.autolayoutView.frame = self.bounds
        self.backgroundColor = self.autolayoutView.backgroundColor
        self.autolayoutView.backgroundColor = UIColor.clear
        self.addSubview(self.autolayoutView)
    }
    
    open func configure() { }
    
}
