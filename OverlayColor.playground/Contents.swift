//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

extension UIView {
    func withBackgroundColor(_ color: UIColor) -> Self {
        backgroundColor = color
        return self
    }
}

extension UIColor {
    /// 色を重ね合わせたときの色を生成する
    /// 参考 https://ja.wikipedia.org/wiki/アルファブレンド
    func overlayColor(_ otherColor: UIColor) -> UIColor {
        /// 背景
        var (dstR, dstG, dstB, dstA) = (CGFloat(0), CGFloat(0), CGFloat(0), CGFloat(0))
        /// 前景
        var (srcR, srcG, srcB, srcA) = (CGFloat(0), CGFloat(0), CGFloat(0), CGFloat(0))

        getRed(&dstR, green: &dstG, blue: &dstB, alpha: &dstA)
        otherColor.getRed(&srcR, green: &srcG, blue: &srcB, alpha: &srcA)

        let outA = srcA + dstA - dstA * srcA
        let outR = (srcR * srcA + dstR * dstA * (1 - srcA)) / outA
        let outG = (srcG * srcA + dstG * dstA * (1 - srcA)) / outA
        let outB = (srcB * srcA + dstB * dstA * (1 - srcA)) / outA
        return UIColor(red: outR,
                       green: outG,
                       blue: outB,
                       alpha: outA)
    }
}

class MyViewController: UIViewController {
    override func loadView() {
        let view = UIView()
        view.backgroundColor = UIColor(patternImage: UIImage(named: "background.png")!)

        let colorA = UIColor.yellow.withAlphaComponent(0.70)
        let colorB = UIColor.black.withAlphaComponent(0.80)

        let colorViewA = UIView(frame: CGRect(x: 20, y: 20, width: 200, height: 200))
            .withBackgroundColor(colorA)
        let colorViewB = UIView(frame: CGRect(x: 70, y: 70, width: 200, height: 200))
            .withBackgroundColor(colorB)

        let colorViewC = UIView(frame: CGRect(x: 20, y: 320, width: 100, height: 100))
            .withBackgroundColor(colorA)
        let colorViewD = UIView(frame: CGRect(x: 230, y: 320, width: 100, height: 100))
            .withBackgroundColor(colorB)
        let colorViewE = UIView(frame: CGRect(x: 125, y: 320, width: 100, height: 100))
            .withBackgroundColor(colorA.overlayColor(colorB))

        view.addSubview(colorViewA)
        view.addSubview(colorViewB)

        view.addSubview(colorViewC)
        view.addSubview(colorViewD)
        view.addSubview(colorViewE)

        self.view = view
    }
}

PlaygroundPage.current.liveView = MyViewController()
