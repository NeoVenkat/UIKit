
import UIKit

class ViewController: UIViewController {
    
    //IBOutlet
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var btnFloating: UIButton!
    @IBOutlet weak var nodatalbl:UILabel!
    let viewModel = ViewControllerViewModel()

    //Variables
    var isSearching: Bool = false
    lazy var searchBar:UISearchBar = UISearchBar()

    override func viewDidLoad() {
        super.viewDidLoad()
        // load data from view model
        self.viewModel.loadJSONData()
        self.setUpUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    private func setUpUI() {
        self.hideKeyboardWhenTappedAround()
        
        //SearchBar View
        self.searchBar.searchBarStyle = UISearchBar.Style.default
        self.searchBar.placeholder = UIConstants.searchBarPlaceholder
        self.searchBar.sizeToFit()
        self.searchBar.searchTextField.backgroundColor = .systemGray3
        self.searchBar.isTranslucent = false
        self.searchBar.backgroundImage = UIImage()
        self.searchBar.delegate = self
        self.searchBar.returnKeyType = .default
        self.searchBar.showsCancelButton = false
        
        //Items Table View
        self.tblView.delegate = self
        self.tblView.dataSource = self
        self.tblView.sectionHeaderHeight = 1
        self.tblView.tableFooterView = UIView()
        self.tblView.keyboardDismissMode = .onDrag
        self.tblView.register(UINib(nibName: UIConstants.headerTableViewCell, bundle: nil), forCellReuseIdentifier: UIConstants.headerTableViewCell)
        self.tblView.register(UINib(nibName: UIConstants.listItemTableViewCell, bundle: nil), forCellReuseIdentifier: UIConstants.listItemTableViewCell)
        self.tblView.reloadData()
        
        self.navigationItem.title = self.viewModel.selectedItem?.uppercased()
        
        self.btnFloating.layer.cornerRadius = 30
        self.btnFloating.layer.shadowColor = UIColor.black.cgColor
        self.btnFloating.layer.shadowOpacity = 0.2
        self.btnFloating.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.btnFloating.layer.shadowRadius = 10
        self.btnFloating.layer.masksToBounds = false
        
        nodatalbl.isHidden = true
    }
    
    func updateFilteredItems(_ category: String?, _ searchText: String) {
        guard let category = category else { return }
        self.navigationItem.title = category.uppercased()
        self.viewModel.filterItems(category, searchText)
        self.tblView.reloadData()
        
    }
}

extension ViewController {
    @IBAction func action_BtnFloatingClicked(_ sender: UIButton) {
        presentBottomSheet(with: self.viewModel.getStatistics())
    }
    func presentBottomSheet(with statsText: String) {
        let storyboard = UIStoryboard(name: UIConstants.storyboardName, bundle: nil)
        if let bottomSheetVC = storyboard.instantiateViewController(withIdentifier: UIConstants.bottomSheetViewController) as? BottomSheetViewController {
            bottomSheetVC.statsText = statsText
            bottomSheetVC.modalPresentationStyle = .pageSheet
            bottomSheetVC.modalTransitionStyle = .coverVertical

            if let sheet = bottomSheetVC.sheetPresentationController {
                sheet.detents = [.medium()]
                sheet.preferredCornerRadius = 20
            }

            present(bottomSheetVC, animated: true, completion: nil)
        }
    }
}
