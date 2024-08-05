import UIKit

class ListItemTableViewCell: UITableViewCell {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Apply corner radius and shadow
        self.bgView.layer.cornerRadius = 10
        self.bgView.layer.shadowColor = UIColor.black.cgColor
        self.bgView.layer.shadowOpacity = 0.2
        self.bgView.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.bgView.layer.shadowRadius = 4
        self.imgView.layer.cornerRadius = 10
        self.imgView.layer.masksToBounds = true
        self.imgView.contentMode = .scaleToFill
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}
