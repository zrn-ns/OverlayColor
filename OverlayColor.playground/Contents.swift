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
        var (r1, g1, b1, a1) = (CGFloat(0), CGFloat(0), CGFloat(0), CGFloat(0))
        var (r2, g2, b2, a2) = (CGFloat(0), CGFloat(0), CGFloat(0), CGFloat(0))

        getRed(&r1, green: &g1, blue: &b1, alpha: &a1)
        otherColor.getRed(&r2, green: &g2, blue: &b2, alpha: &a2)

        let a3 = a1 + a2 * (1 - a1)
        let r3 = (r2 * a2 + r1 * a1 * (1 - a2)) / a3
        let g3 = (g2 * a2 + g1 * a1 * (1 - a2)) / a3
        let b3 = (b2 * a2 + b1 * a1 * (1 - a2)) / a3
        return UIColor(red: r3,
                       green: g3,
                       blue: b3,
                       alpha: a3)
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
