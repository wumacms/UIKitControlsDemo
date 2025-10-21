//
//  ViewController.swift
//  UIKitControlsDemo
//
//  Created by devlink on 2025/10/21.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - Properties
    private let tableView = UITableView()
    private let controls: [(title: String, type: ControlType)] = [
        ("UILabel - 标签控件", .label),
        ("UIButton - 按钮控件", .button),
        ("UITextField - 文本输入框", .textField),
        ("UITextView - 文本视图", .textView),
        ("UISwitch - 开关控件", .switchControl),
        ("UISlider - 滑块控件", .slider),
        ("UISegmentedControl - 分段控件", .segmentedControl),
        ("UIActivityIndicatorView - 活动指示器", .activityIndicator),
        ("UIProgressView - 进度条", .progressView),
        ("UIStepper - 步进器", .stepper),
        ("UIDatePicker - 日期选择器", .datePicker),
        ("UIPickerView - 选择器", .pickerView),
        ("UIImageView - 图片视图", .imageView),
        ("UIAlertController - 警告框", .alertController)
    ]
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        title = "UIKit 控件演示"
        view.backgroundColor = .systemBackground
        
        // 设置表格视图
        tableView.frame = view.bounds
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
    }
}

// MARK: - UITableView DataSource & Delegate
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return controls.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = controls[indexPath.row].title
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let controlType = controls[indexPath.row].type
        let detailVC = ControlDetailViewController(controlType: controlType)
        detailVC.title = controls[indexPath.row].title
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

// MARK: - Control Type
enum ControlType {
    case label
    case button
    case textField
    case textView
    case switchControl
    case slider
    case segmentedControl
    case activityIndicator
    case progressView
    case stepper
    case datePicker
    case pickerView
    case imageView
    case alertController
}


