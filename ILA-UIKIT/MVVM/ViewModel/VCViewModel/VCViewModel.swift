

import Foundation

class ViewControllerViewModel : NSObject {
    private(set) var items: [ItemList] = []
    private(set) var typeOFItems: [String] = []
    private(set) var filteredItems: [ItemList] = []
    private(set) var selectedItem: String? = ""
    
    //Load data from local json
    func loadJSONData() {
        self.items = []
        self.items = BundleDecoderFromJson.decodeLandmarkFromBundleToJson()
        self.typeOFItems = []
        self.typeOFItems = Array(Set( self.items.map { $0.item })).sorted()
        self.filterItems(self.typeOFItems.first, "")
    }
    
    //Get filtered data
    func filterItems(_ selectedItem: String?, _ searchText: String) {
        self.selectedItem = selectedItem
        let filteredData = items.filter { $0.item == selectedItem }
        if searchText.isEmpty {
            self.filteredItems = filteredData
        } else {
            self.filteredItems = filteredData.filter{ $0.name.lowercased().contains(searchText.lowercased()) }
        }
    }
    
    //Get Top 3 Characters to show on floating button
    func getTop3Characters() -> [(Character, Int)] {
        var charCount: [Character: Int] = [:]
        for location in self.filteredItems {
            for char in location.name.lowercased() {
                if char.isLetter {
                    charCount[char, default: 0] += 1
                }
            }
        }
        return charCount.sorted { $0.value > $1.value }.prefix(3).map { $0 }
    }
    
    func getStatistics() -> String {
        let top3Characters = self.getTop3Characters()
        return "Items on this page: \(self.filteredItems.count)\nTop 3 characters: \(top3Characters.map { "\($0.0): \($0.1)" }.joined(separator: ", "))"
    }
}
