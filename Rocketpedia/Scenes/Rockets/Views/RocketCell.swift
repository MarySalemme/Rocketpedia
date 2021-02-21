//
//  RocketCell.swift
//  Rocketpedia
//
//  Created by Mary Salemme on 20/02/2021.
//

import UIKit
import Nuke

class RocketCell: UITableViewCell {

	public static let reuseIdentifier = "RocketCell"

	// MARK: Subviews
	
	private var _imageView: UIImageView
	
	private var _nameLabel: UILabel
	
	private var _firstFlightLabel: UILabel
	
	private var _successRateLabel: UILabel

	// MARK: Properties
	
	public var imageUrl: String? {
		didSet {
			if let url = URL(string: imageUrl ?? "") {
				Nuke.loadImage(with: url, options: ImageLoadingOptions(placeholder: UIImage(named: "rocket-placeholder")), into: self._imageView)
			}
		}
	}
	
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
	
	public var successRate: Int? {
		didSet {
			if let successRate = successRate {
				self._successRateLabel.attributedText = NSAttributedString(string: getSuccessRateString(from: successRate), attributes: getSuccessRateAttributes(for: successRate))
			}
		}
	}
	
	// MARK: Initializers

	public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		_imageView = UIImageView(frame: .zero)
		_nameLabel = UILabel(frame: .zero)
		_firstFlightLabel = UILabel(frame: .zero)
		_successRateLabel = UILabel(frame: .zero)
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setupUI()
		setupConstraints()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func setupUI() {
		_imageView.contentMode = .scaleAspectFill
		_imageView.clipsToBounds = true
		_imageView.translatesAutoresizingMaskIntoConstraints = false
		contentView.addSubview(_imageView)
		
		_nameLabel.textAlignment = .left
		_nameLabel.textColor = UIColor.white
		_nameLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
		_nameLabel.translatesAutoresizingMaskIntoConstraints = false
		_nameLabel.numberOfLines = 0
		contentView.addSubview(_nameLabel)
		
		_firstFlightLabel.textAlignment = .left
		_firstFlightLabel.textColor = UIColor.white
		_firstFlightLabel.translatesAutoresizingMaskIntoConstraints = false
		_firstFlightLabel.numberOfLines = 0
		contentView.addSubview(_firstFlightLabel)
		
		_successRateLabel.textAlignment = .left
		_successRateLabel.textColor = UIColor.white
		_successRateLabel.translatesAutoresizingMaskIntoConstraints = false
		contentView.addSubview(_successRateLabel)
	}

	func setupConstraints() {
		NSLayoutConstraint.activate([
			_imageView.widthAnchor.constraint(equalToConstant: 80),
			_imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
			_imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
			_imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
			_nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
			_nameLabel.leadingAnchor.constraint(equalTo: _imageView.trailingAnchor, constant: 10),
			_nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 20),
			_firstFlightLabel.topAnchor.constraint(equalTo: _nameLabel.bottomAnchor, constant: 10),
			_firstFlightLabel.leadingAnchor.constraint(equalTo: _imageView.trailingAnchor, constant: 10),
			_firstFlightLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 20),
			_successRateLabel.topAnchor.constraint(equalTo: _firstFlightLabel.bottomAnchor, constant: 10),
			_successRateLabel.leadingAnchor.constraint(equalTo: _imageView.trailingAnchor, constant: 10),
			_successRateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 20)
		])
	}
	
	private func getSuccessRateString(from int: Int) -> String {
		return "\(String(int))% success rate"
	}
	
	private func getSuccessRateAttributes(for int: Int) -> [NSAttributedString.Key : UIColor] {
		var attributes: [NSAttributedString.Key : UIColor]
		switch int {
		case 60...100:
			attributes = [NSAttributedString.Key.foregroundColor: UIColor.green]
		case 30...59:
			attributes = [NSAttributedString.Key.foregroundColor: UIColor.orange]
		case 0...29:
			attributes = [NSAttributedString.Key.foregroundColor: UIColor.red]
		default:
			assertionFailure()
			attributes = [:]
		}
		return attributes
	}
}
