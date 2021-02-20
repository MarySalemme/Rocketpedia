//
//  RocketCell.swift
//  Rocketpedia
//
//  Created by Mary Salemme on 20/02/2021.
//

import UIKit

class RocketCell: UITableViewCell {

	public static let reuseIdentifier = "RocketCell"

	// MARK: Subviews
	
	private var _nameLabel: UILabel
	
	private var _firstFlightLabel: UILabel

	// MARK: Properties
	
	public var name: String? {
		didSet {
			let attributes = [NSAttributedString.Key.foregroundColor: UIColor.label]
			self._nameLabel.attributedText = NSAttributedString(string: name ?? "", attributes: attributes)
		}
	}
	
	public var firstFlight: String? {
		didSet {
			guard let firstFlight = firstFlight else {
				return
			}
			let attributes = [NSAttributedString.Key.foregroundColor: UIColor.secondaryLabel]
			self._firstFlightLabel.attributedText = NSAttributedString(string: "First fligth: \(String(describing: firstFlight))" , attributes: attributes)
		}
	}
	
	// MARK: Initializers

	public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		_nameLabel = UILabel()
		_firstFlightLabel = UILabel()
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setupUI()
		setupConstraints()
		
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func setupUI() {
		_nameLabel.textAlignment = .left
		_nameLabel.textColor = UIColor.white
		_nameLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
		_nameLabel.translatesAutoresizingMaskIntoConstraints = false
		_nameLabel.numberOfLines = 0
		addSubview(_nameLabel)
		_firstFlightLabel.textAlignment = .left
		_firstFlightLabel.textColor = UIColor.white
		_firstFlightLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
		_firstFlightLabel.translatesAutoresizingMaskIntoConstraints = false
		_firstFlightLabel.numberOfLines = 0
		addSubview(_firstFlightLabel)
	}

	func setupConstraints() {
	
		let nameTopConstraint = _nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20)
		nameTopConstraint.priority = .defaultHigh

		NSLayoutConstraint.activate([
			nameTopConstraint,
			_nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
			_nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 20),
			_firstFlightLabel.topAnchor.constraint(equalTo: _nameLabel.bottomAnchor),
			_firstFlightLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
			_firstFlightLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 20),
			_firstFlightLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 20),
			contentView.heightAnchor.constraint(equalToConstant: 100)
		])
	}
}
