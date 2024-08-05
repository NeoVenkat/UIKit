
import UIKit

class BottomSheetViewController: UIViewController {
    @IBOutlet weak var statsLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    var statsText: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        containerView.layer.cornerRadius = 20
        containerView.layer.masksToBounds = true
        statsLabel.text = statsText
    }

    @IBAction func dismissButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
