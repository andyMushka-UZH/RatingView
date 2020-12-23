//
//  RaingView.swift
//  Rating
//


import UIKit

private let kWidthForScale: CGFloat = 90
private let kMaxRatingValue: Int = 100
private let kMinRatingValue: Int = 0

@IBDesignable
class RaingView: UIView {
    
    @IBOutlet private weak var backgoundView: UIView!
    @IBOutlet private weak var ratingLabel: UILabel!
    @IBOutlet private weak var percentLabel: UILabel!
    private var circleRatingValueLayer = CAShapeLayer()
    private var circleRatingBackgroundLayer = CAShapeLayer()
    
    // MARK: - Properies

    private var ratingOldValue: Int = 0
    private var ratingValue: Int = 0 {
        didSet {
            if ratingValue >= kMaxRatingValue {
                ratingValue = kMaxRatingValue
            } else if ratingValue <= kMinRatingValue {
                ratingValue = kMinRatingValue
            }
            ratingOldValue = oldValue
        }
    }
    
    
    // MARK: - Internal
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
        
    override func layoutSubviews() {
        super.layoutSubviews()
        configureView()
    }
        
    // MARK: - Public
    
    func setRating(value: Int, with animate: Bool) {
        ratingValue = value
        if animate {
            animateLabel()
            circleRatingValueLayer.strokeEnd = CGFloat(ratingValue) / 100
            circleRatingValueLayer.strokeColor = genereteColor().cgColor
            circleRatingBackgroundLayer.strokeColor = genereteColor().cgColor
        } else {
            ratingLabel.text = "\(ratingValue)"
            CATransaction.begin()
            CATransaction.setDisableActions(true)
            circleRatingValueLayer.strokeEnd = CGFloat(ratingValue) / 100
            circleRatingValueLayer.strokeColor = genereteColor().cgColor
            circleRatingBackgroundLayer.strokeColor = genereteColor().cgColor
            CATransaction.commit()
        }
    }
    

    // MARK: - Private
    
    private func setup() {
        
        let view = Bundle.main.loadNibNamed("\(Self.self)", owner: self, options: nil)?.first as! UIView
        view.frame = bounds
        view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        addSubview(view)
        configureView()
    }
    
    private func configureView() {
        prepareBackgoundView()
        addCircle(layer: circleRatingBackgroundLayer, color: genereteColor(), opacity: 0.5)
        addCircle(layer: circleRatingValueLayer, color: genereteColor(), opacity: 1.0)
        prepareRatingValueLayer()
        prepareLabels()
    }
    
    
    // MARK: - UI Configures
    
    private func genereteColor() -> UIColor {
        switch ratingValue {
        case 0...25: return .red
        case 25...50: return .orange
        case 50...75: return .yellow
        case 75...100: return .green
        default: return .blue
        }
    }
    
    private func prepareBackgoundView() {
        backgoundView.layer.cornerRadius = backgoundView.bounds.width / 2
        backgoundView.layer.shadowColor = UIColor.black.cgColor
        backgoundView.layer.shadowOpacity = 0.5
        backgoundView.layer.shadowRadius = 4
    }
    
    private func prepareRatingValueLayer() {
        if ratingValue == kMinRatingValue {
            circleRatingValueLayer.strokeEnd = 0.0
            circleRatingValueLayer.strokeStart = 0.0
        }
    }
    
    private func prepareLabels() {
        ratingLabel.font = ratingLabel.font.withSize(calculateScaling(constant: 20))
        percentLabel.font = percentLabel.font.withSize(calculateScaling(constant: 8))
    }
    
    private func addCircle(layer: CAShapeLayer, color: UIColor, opacity: Float) {
        
        let center = CGPoint(x: backgoundView.bounds.origin.x + (backgoundView.bounds.width / 2),
                             y: backgoundView.bounds.origin.y + (backgoundView.bounds.height / 2))
        
        layer.path = UIBezierPath(arcCenter: center,
                                  radius: (backgoundView.frame.width / 2) - calculateScaling(constant: 10),
                                  startAngle: -.pi/2,
                                  endAngle: (.pi/2) * 3 ,
                                  clockwise: true).cgPath
        
        layer.lineWidth = calculateScaling(constant: 6)
        layer.opacity = opacity
        layer.strokeColor = color.cgColor
        layer.fillColor = UIColor.clear.cgColor
        layer.lineCap = .round
    
        backgoundView.layer.addSublayer(layer)
    }
    
    private func calculateScaling(constant: CGFloat) -> CGFloat {
        return constant * (backgoundView.bounds.width / kWidthForScale)
    }
    
    
    // MARK: - Animations
    
    func animateLabel() {
        
        let isReverce = ratingOldValue < ratingValue
        let sequence = isReverce ? (ratingOldValue...ratingValue).sorted() : (ratingValue...ratingOldValue).reversed()
        
        DispatchQueue.global(qos: .userInteractive).async {
            for index in sequence {
                usleep(1000)
                DispatchQueue.main.sync {
                    self.ratingLabel.text = "\(index)"
                }
            }
        }
    }
}

