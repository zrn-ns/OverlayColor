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

        let colorViewA = UIView(frame: CGRect(x: 20, y: 20, width: 200, height: 200))
            .withBackgroundColor(UIColor.yellow.withAlphaComponent(0.70))
        let colorViewB = UIView(frame: CGRect(x: 70, y: 70, width: 200, height: 200))
            .withBackgroundColor(UIColor.black.withAlphaComponent(0.80))

        view.addSubview(colorViewA)
        view.addSubview(colorViewB)

        self.view = view
    }
}

PlaygroundPage.current.liveView = MyViewController()
