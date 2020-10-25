//
//  ViewController.swift
//  TableTest
//
//  Created by Joseph on 25.10.2020.
//

import UIKit

struct Person {
    let name: String
    let surnname: String

    let phoneNumber: String
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let tableView: UITableView = UITableView(frame: .zero, style: .grouped)

    override func viewDidLoad() {
        super.viewDidLoad()

        let stackView = UIStackView(frame: .zero)
        stackView.addArrangedSubview(tableView)
        stackView.axis = .vertical

        view.addSubview(stackView)

        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])

        tableView.dataSource = self
        tableView.delegate = self

        tableView.allowsSelection = true
    }

    //MARK: - TableView Methods

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.contactsCount(for: section)
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return self.segmentsCount()
    }

    //MARK: - TableView Cell Methods

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = CellView()

        let person = self.getPerson(for: indexPath)

        cell.leftLabel.text = person.surnname
        cell.rightLabel.text = person.name

        cell.awakeFromNib()

        return cell
    }

    //MARK: - TableView Header Methods

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 32
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        let label = UILabel()

        label.text = self.getHeaderFor(section: section)
        label.font = UIFont.boldSystemFont(ofSize: 16.0)

        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false

        let dict = ["label": label]

        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[label]|", options: [], metrics: nil, views: dict))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "|-[label]", options: [], metrics: nil, views: dict))

        return view
    }

    //MARK: - TableView Footer Methods

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }

    //MARK: - TableView Action For Cell

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ContactDetailView") as! ContactDetailViewController
        vc.setData(person: self.getPerson(for: indexPath))
        self.navigationController?.pushViewController(vc, animated: true)
        self.tableView.deselectRow(at: indexPath, animated: false)
    }

    //MARK: - Data
    private var contactsKeys: [String] {
        return contacts.keys.sorted { $0.lowercased() < $1.lowercased() }
    }

    private let contacts: [String: [Person]] = [
        "A": [
            Person(name: "John", surnname: "Adams", phoneNumber: "91 5999 399 23"),
            Person(name: "Annie", surnname: "Allen", phoneNumber: "92 999 399 23"),
            Person(name: "Willson", surnname: "Allen", phoneNumber: "93 999 399 23"),
            Person(name: "John", surnname: "Allen", phoneNumber: "90 999 399 23"),
        ],
        "C": [
            Person(name: "Zuck", surnname: "Cukerberg", phoneNumber: "xd 95 999 399 23")
        ],
        "B": [
            Person(name: "Aria", surnname: "Baker", phoneNumber: "91 999 399 23")
        ],
        "R": [
            Person(name: "Billy", surnname: "Robertson", phoneNumber: "92 999 399 23")
        ],
        "F": [
            Person(name: "Brad", surnname: "Frank", phoneNumber: "95 999 399 23")
        ],
    ]

    //MARK: - Data Helpers

    private func contactsCount(for section: Int) -> Int {
        return contacts[contactsKeys[section]]?.count ?? 0
    }

    private func segmentsCount() -> Int {
        return contacts.count
    }

    private func getHeaderFor(section: Int) -> String {
        return contactsKeys[section]
    }

    private func getPerson(for index: IndexPath) -> Person {
        return contacts[contactsKeys[index.section]]?[index.item] ?? contacts[contacts.startIndex].value[index.item]
    }
}
