
import UIKit

class CollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imgView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.imgView.layer.cornerRadius = 10
        self.imgView.layer.masksToBounds = true
        self.imgView.contentMode = .scaleToFill
    }
}
