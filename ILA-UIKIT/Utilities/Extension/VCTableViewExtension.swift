
import Foundation
import UIKit

// MARK:- UITableViewDataSource
extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return self.isSearching == true ? 0 : 1
        } else {
            return self.viewModel.filteredItems.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            //For CollectionView
            guard let cell = tableView.dequeueReusableCell(withIdentifier: UIConstants.headerTableViewCell, for: indexPath) as? HeaderTableViewCell else {
                return UITableViewCell()
            }
            cell.configureCarousalCollectionView(self.viewModel)
            cell.cellDelgate = self
            return cell
        } else{
            //For Listing
            guard let cell = tableView.dequeueReusableCell(withIdentifier: UIConstants.listItemTableViewCell, for: indexPath) as? ListItemTableViewCell else {
                return UITableViewCell()
            }
            let data = self.viewModel.filteredItems[indexPath.row]
            cell.imgView.image = UIImage(named: data.image)
            cell.lblTitle.text = data.name
            cell.lblDesc.text = data.description

            return cell
        }
    }
}


// MARK:- UITableViewDelegate
extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 {
            return 50
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 1 {
            return searchBar
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 240
        }
        return UITableView.automaticDimension
    }
}

extension ViewController : HeaderTableViewCellDelegate {
    func updateSelectedCategory(_ selectedCategory: String?) {
        if let category = selectedCategory {
            self.updateFilteredItems(category, "")
        }
    }
}
