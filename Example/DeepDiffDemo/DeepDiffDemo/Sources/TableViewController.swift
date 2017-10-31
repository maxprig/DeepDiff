import UIKit
import DeepDiff
import Anchors

class TableViewController: UIViewController, UITableViewDataSource {

  var tableView: UITableView!
  var items: [Int] = []

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = UIColor.white

    title = "TableView"

    tableView = UITableView()
    tableView.dataSource = self
    tableView.backgroundColor = .lightGray

    view.addSubview(tableView)
    activate(
      tableView.anchor.edges
    )

    tableView.register(TableViewCell.self, forCellReuseIdentifier: "Cell")
    navigationItem.rightBarButtonItem = UIBarButtonItem(
      title: "Reload", style: .plain, target: self, action: #selector(reload)
    )
  }

  @objc func reload() {
    let oldItems = items
    items = generateItems()
    let changes = diff(old: oldItems, new: items, reduceMove: false)
    tableView.reload(changes: changes, completion: { _ in })
  }

  // MARK: - UITableViewDataSource

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return items.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
    let item = items[indexPath.item]

    cell.label.text = "\(item)"

    return cell
  }

  // MARK: - Data

  func generateItems() -> [Int] {
    let count = 4
    let items = Array(0..<count)
    return items.shuffled()
  }
}

