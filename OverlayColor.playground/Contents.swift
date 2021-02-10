//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

extension UIView {
    func withBackgroundColor(_ color: UIColor) -> Self {
        backgroundColor = color
        return self
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
