//
//  ChipsView.swift
//  Chips Custom View
//
//  Created by ilga yulian putra on 01/06/20.
//  Copyright © 2020 ilga yulian putra. All rights reserved.
//

import UIKit

@IBDesignable
class ChipsView: UIView {
    
    override init(frame: CGRect) {
      super.init(frame: frame)
      setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
      setupView()
    }
    
    @IBInspectable var chipColor: UIColor = #colorLiteral(red: 0.3921568627, green: 0.7803921569, blue: 0.8, alpha: 1) {
        didSet { preview() }
    }
    
    @IBInspectable var chipHeight: CGFloat = 34 {
        didSet { preview() }
    }
    
    @IBInspectable var textColor: UIColor = .white {
        didSet { preview() }
    }
    
    @IBInspectable var textSize: CGFloat = 13 {
        didSet { preview() }
    }
    
    @IBInspectable var isCloseIconVisible: Bool = false {
        didSet { preview() }
    }
    
    @IBInspectable var closeImage: UIImage? {
        didSet { preview() }
    }
    
    @IBInspectable var closeButtonSize: CGFloat = 16 {
        didSet { preview() }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 6 {
        didSet { preview() }
    }
    
    @IBInspectable var leftTextInset: CGFloat = 8 {
        didSet { preview() }
    }
    
    @IBInspectable var rightTextInset: CGFloat = 8 {
        didSet { preview() }
    }
    
    @IBInspectable var rightButtonInset: CGFloat = 8 {
        didSet { preview() }
    }
    
    @IBInspectable var spacingHorizontal: CGFloat = 8 {
        didSet { preview() }
    }
    
    @IBInspectable var spacingVertical: CGFloat = 8 {
        didSet { preview() }
    }
    
    @IBInspectable var value: String = "" {
        didSet {
            let valueArray = value.components(separatedBy: ";")
                .filter({$0.trimmingCharacters(in: .whitespacesAndNewlines).count > 0})
            setChipsValue(chips: valueArray)
        }
    }
    
    var delegate: ChipsViewDelegate?
    var fontFamily: String = "verdana"
    
    private var chipsArray:[String] = Array()
    private var viewHeight : NSLayoutConstraint?
    
    lazy var contectView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private func setupView() {
        addSubview(contectView)
        setupLayout()
    }
    
    private func setupLayout() {
      NSLayoutConstraint.activate([
        contectView.topAnchor.constraint(equalTo: topAnchor),
        contectView.bottomAnchor.constraint(equalTo: bottomAnchor),
        contectView.leadingAnchor.constraint(equalTo: leadingAnchor),
        contectView.trailingAnchor.constraint(equalTo: trailingAnchor)
      ])
        viewHeight = contectView.heightAnchor.constraint(equalToConstant: 100)
        viewHeight?.isActive = true
    }
    
    func setLayoutHeight(height: CGFloat) {
        viewHeight?.constant = height
    }

    private func chipsFont() -> UIFont? {
        UIFont(name: fontFamily, size: textSize)
    }
    
    private func textWidth(value: String) -> CGFloat {
        if let chipFont = chipsFont() {
            return value.widthOfString(usingFont: chipFont)
        } else {
            return 0
        }
    }
    
    private func componentWidth() -> CGFloat {
        var width = leftTextInset + rightTextInset
        if isCloseIconVisible {
            width += closeButtonSize + rightButtonInset
        }
        return width
    }
    
    func setChipsValue(chips: [String]) {
        chipsArray = chips
        addChipsToView()
    }
    
    func addChip(chip: String) {
        if chip.count != 0 {
            chipsArray.append(chip)
            addChipsToView()
        }
    }
    
    func addChips(chips: [String]) {
        for chip in chips {
            if chip.count != 0 {
                chipsArray.append(chip)
            }
        }
        addChipsToView()
    }
    
    private func preview() {
        addChipsToView()
    }
    
    private func addChipsToView() {
        var xPos:CGFloat = 0
        var yPos: CGFloat = 0
        var tag: Int = 1
        removeChipsSubView()
        for value in chipsArray  {
            let view = createChipView(value: value, xPos: &xPos, yPos: &yPos, tag: &tag)
            contectView.addSubview(view)
        }
        setLayoutHeight(height: yPos + chipHeight + spacingVertical)
    }
    
    
    private func createChipView(value: String, xPos: inout CGFloat, yPos: inout CGFloat, tag: inout Int) -> UIView {
        var lableWidth = textWidth(value: value)
        var widthOfChip = componentWidth() + lableWidth
        
        if widthOfChip >= self.frame.size.width {
            lableWidth = contectView.frame.size.width - componentWidth()
            widthOfChip = contectView.frame.width
        }
        
        let checkWholeWidth = CGFloat(xPos) + widthOfChip
        if checkWholeWidth > self.frame.size.width {
            xPos = 0.0
            yPos = yPos + chipHeight + spacingVertical
        }
        
        
        let chipView = UIView(frame: CGRect(x: xPos, y: yPos, width:widthOfChip, height: chipHeight))
        chipView.layer.cornerRadius = cornerRadius
        chipView.backgroundColor = chipColor
        chipView.tag = tag
        
        let textlable = UILabel(frame: CGRect(x: leftTextInset, y: 0.0, width: lableWidth, height: chipView.frame.size.height))
        textlable.font = chipsFont()
        textlable.text = value
        textlable.adjustsFontSizeToFitWidth = false
        textlable.lineBreakMode = .byTruncatingTail
        textlable.textColor = textColor
        chipView.addSubview(textlable)
        
        if isCloseIconVisible {
            let button = UIButton(type: .custom)
            button.frame = CGRect(x: chipView.frame.size.width - rightButtonInset - closeButtonSize, y: chipView.frame.size.height/2 - closeButtonSize/2, width: closeButtonSize, height: closeButtonSize)
            button.backgroundColor = UIColor.white
            button.layer.cornerRadius = CGFloat(button.frame.size.width)/CGFloat(2.0)
            button.setImage(closeImage, for: .normal)
            button.tag = tag
            button.addTarget(self, action: #selector(removeChipByTag(_:)), for: .touchUpInside)
            chipView.addSubview(button)
        }
        xPos = CGFloat(xPos) + CGFloat(chipView.frame.width) + spacingHorizontal
        
        tag += 1
        
        return chipView
    }
        
    private func removeChipsSubView() {
        for tempView in contectView.subviews {
            if tempView.tag != 0 {
                tempView.removeFromSuperview()
            }
        }
    }
    
    @objc func removeChipByTag(_ sender: AnyObject) {
        let value = chipsArray[sender.tag - 1]
        delegate?.removeChip(value: value)
        chipsArray.remove(at: (sender.tag - 1))
        addChipsToView()
   }
    
    override class var requiresConstraintBasedLayout: Bool {
         return true
    }
       
}

protocol ChipsViewDelegate {
    func removeChip(value: String)
}

extension String {
    func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }
}
