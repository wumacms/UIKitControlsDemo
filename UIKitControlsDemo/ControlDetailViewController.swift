//
//  AutoLayoutControlDetailViewController 2.swift
//  UIKitControlsDemo
//
//  Created by devlink on 2025/10/21.
//


import UIKit

class ControlDetailViewController: UIViewController {
    
    // MARK: - Properties
    private let controlType: ControlType
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private var stackView: UIStackView!
    
    // 存储控件的引用
    private var statusLabel: UILabel?
    private var valueLabel: UILabel?
    private var selectedLabel: UILabel?
    private var progressView: UIProgressView?
    private var progressLabel: UILabel?
    
    private var progressTimer: Timer?
    private var progress: Float = 0.0
    
    // MARK: - Initialization
    init(controlType: ControlType) {
        self.controlType = controlType
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupControlDemo()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        progressTimer?.invalidate()
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        setupScrollView()
        setupContentView()
        setupStackView()
    }
    
    private func setupScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.alwaysBounceVertical = true
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupContentView() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
    
    private func setupStackView() {
        stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.alignment = .fill
        stackView.distribution = .fill
        
        contentView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }
    
    // MARK: - Control Demos
    private func setupControlDemo() {
        // 添加标题
//        addTitleLabel()
        
        switch controlType {
        case .label:
            setupLabelDemo()
        case .button:
            setupButtonDemo()
        case .textField:
            setupTextFieldDemo()
        case .textView:
            setupTextViewDemo()
        case .switchControl:
            setupSwitchDemo()
        case .slider:
            setupSliderDemo()
        case .segmentedControl:
            setupSegmentedControlDemo()
        case .activityIndicator:
            setupActivityIndicatorDemo()
        case .progressView:
            setupProgressViewDemo()
        case .stepper:
            setupStepperDemo()
        case .datePicker:
            setupDatePickerDemo()
        case .pickerView:
            setupPickerViewDemo()
        case .imageView:
            setupImageViewDemo()
        case .alertController:
            setupAlertDemo()
        }
    }
    
    private func addTitleLabel() {
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        titleLabel.textAlignment = .center
        titleLabel.textColor = .label
        stackView.addArrangedSubview(titleLabel)
    }
    
    // MARK: - 各个控件的演示方法
    private func setupLabelDemo() {
        addSectionTitle("基本标签")
        
        let basicLabel = UILabel()
        basicLabel.text = "这是一个基本标签"
        basicLabel.textColor = .label
        basicLabel.textAlignment = .center
        stackView.addArrangedSubview(basicLabel)
        
        addSectionTitle("带样式的标签")
        
        let styledLabel = UILabel()
        styledLabel.text = "带样式的标签"
        styledLabel.textColor = .systemBlue
        styledLabel.font = UIFont.boldSystemFont(ofSize: 18)
        styledLabel.textAlignment = .center
        styledLabel.backgroundColor = .systemGray6
        styledLabel.layer.cornerRadius = 8
        styledLabel.clipsToBounds = true
        styledLabel.heightAnchor.constraint(equalToConstant: 44).isActive = true
        stackView.addArrangedSubview(styledLabel)
        
        addSectionTitle("多行标签")
        
        let multilineLabel = UILabel()
        multilineLabel.text = "这是一个多行标签，可以显示多行文本内容。UILabel 是 UIKit 中最常用的控件之一，支持丰富的文本显示功能。"
        multilineLabel.textColor = .label
        multilineLabel.numberOfLines = 0
        multilineLabel.textAlignment = .center
        stackView.addArrangedSubview(multilineLabel)
        
        addSectionTitle("富文本标签")
        
        let attributedLabel = UILabel()
        let attributedString = NSMutableAttributedString(string: "富文本标签演示")
        attributedString.addAttribute(.foregroundColor, value: UIColor.systemRed, range: NSRange(location: 0, length: 3))
        attributedString.addAttribute(.foregroundColor, value: UIColor.systemGreen, range: NSRange(location: 3, length: 2))
        attributedString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 20), range: NSRange(location: 0, length: 5))
        attributedLabel.attributedText = attributedString
        attributedLabel.textAlignment = .center
        stackView.addArrangedSubview(attributedLabel)
    }
    
    private func setupButtonDemo() {
        addSectionTitle("系统按钮")
        
        let systemButton = UIButton(type: .system)
        systemButton.setTitle("系统样式按钮", for: .normal)
        systemButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        systemButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        stackView.addArrangedSubview(systemButton)
        
        addSectionTitle("自定义按钮")
        
        let customButton = UIButton(type: .custom)
        customButton.setTitle("自定义按钮", for: .normal)
        customButton.setTitleColor(.white, for: .normal)
        customButton.backgroundColor = .systemBlue
        customButton.layer.cornerRadius = 8
        customButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        customButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        stackView.addArrangedSubview(customButton)
        
        addSectionTitle("带图标的按钮")
        
        let imageButton = UIButton(type: .system)
        imageButton.setTitle("带图标的按钮", for: .normal)
        imageButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        imageButton.tintColor = .systemYellow
        imageButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        imageButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        stackView.addArrangedSubview(imageButton)
    }
    
    private func setupTextFieldDemo() {
        addSectionTitle("基本文本输入框")
        
        let basicTextField = UITextField()
        basicTextField.placeholder = "请输入文本"
        basicTextField.borderStyle = .roundedRect
        basicTextField.heightAnchor.constraint(equalToConstant: 44).isActive = true
        stackView.addArrangedSubview(basicTextField)
        
        addSectionTitle("带图标的文本输入框")
        
        let iconTextField = UITextField()
        iconTextField.placeholder = "带图标的输入框"
        iconTextField.borderStyle = .roundedRect
        
        let leftView = UIImageView(image: UIImage(systemName: "envelope"))
        leftView.tintColor = .systemGray
        leftView.frame = CGRect(x: 0, y: 0, width: 30, height: 20)
        leftView.contentMode = .scaleAspectFit
        
        iconTextField.leftView = leftView
        iconTextField.leftViewMode = .always
        iconTextField.heightAnchor.constraint(equalToConstant: 44).isActive = true
        stackView.addArrangedSubview(iconTextField)
        
        addSectionTitle("安全文本输入框")
        
        let secureTextField = UITextField()
        secureTextField.placeholder = "请输入密码"
        secureTextField.borderStyle = .roundedRect
        secureTextField.isSecureTextEntry = true
        secureTextField.heightAnchor.constraint(equalToConstant: 44).isActive = true
        stackView.addArrangedSubview(secureTextField)
        
        addDescriptionLabel("点击输入框开始输入，点击空白处结束编辑")
    }
    
    private func setupTextViewDemo() {
        addSectionTitle("多行文本视图")
        
        let textView = UITextView()
        textView.text = "这是一个 UITextView，支持多行文本输入和显示。\n\n你可以在这里输入大量的文本内容，支持滚动查看。UITextView 提供了丰富的文本编辑功能，包括字体、颜色、对齐方式等设置。"
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.systemGray4.cgColor
        textView.layer.cornerRadius = 8
        textView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        stackView.addArrangedSubview(textView)
        
        addDescriptionLabel("UITextView 支持滚动和丰富的文本编辑功能")
    }
    
    private func setupSwitchDemo() {
        addSectionTitle("开关控件")
        
        let switchContainer = UIView()
        switchContainer.translatesAutoresizingMaskIntoConstraints = false
        
        let switchControl = UISwitch()
        switchControl.translatesAutoresizingMaskIntoConstraints = false
        switchControl.isOn = true
        switchControl.addTarget(self, action: #selector(switchValueChanged(_:)), for: .valueChanged)
        
        statusLabel = UILabel()
        statusLabel!.translatesAutoresizingMaskIntoConstraints = false
        statusLabel!.text = "开关状态: 开启"
        
        switchContainer.addSubview(switchControl)
        switchContainer.addSubview(statusLabel!)
        
        NSLayoutConstraint.activate([
            switchControl.leadingAnchor.constraint(equalTo: switchContainer.leadingAnchor),
            switchControl.centerYAnchor.constraint(equalTo: switchContainer.centerYAnchor),
            
            statusLabel!.leadingAnchor.constraint(equalTo: switchControl.trailingAnchor, constant: 20),
            statusLabel!.centerYAnchor.constraint(equalTo: switchContainer.centerYAnchor),
            statusLabel!.trailingAnchor.constraint(equalTo: switchContainer.trailingAnchor),
            
            switchContainer.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        stackView.addArrangedSubview(switchContainer)
    }
    
    private func setupSliderDemo() {
        addSectionTitle("滑块控件")
        
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 100
        slider.value = 50
        slider.addTarget(self, action: #selector(sliderValueChanged(_:)), for: .valueChanged)
        stackView.addArrangedSubview(slider)
        
        valueLabel = UILabel()
        valueLabel!.text = "当前值: 50"
        valueLabel!.textAlignment = .center
        stackView.addArrangedSubview(valueLabel!)
    }
    
    private func setupSegmentedControlDemo() {
        addSectionTitle("分段控件")
        
        let segmentedControl = UISegmentedControl(items: ["选项一", "选项二", "选项三"])
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)
        stackView.addArrangedSubview(segmentedControl)
        
        selectedLabel = UILabel()
        selectedLabel!.text = "选中: 选项一"
        selectedLabel!.textAlignment = .center
        stackView.addArrangedSubview(selectedLabel!)
    }
    
    private func setupActivityIndicatorDemo() {
        addSectionTitle("活动指示器")
        
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.startAnimating()
        activityIndicator.color = .systemBlue
        
        containerView.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            containerView.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        stackView.addArrangedSubview(containerView)
        
        addDescriptionLabel("活动指示器正在旋转，通常用于表示任务正在进行中")
    }
    
    private func setupProgressViewDemo() {
        addSectionTitle("进度条")
        
        progressView = UIProgressView(progressViewStyle: .default)
        progressView!.progress = 0.0
        stackView.addArrangedSubview(progressView!)
        
        progressLabel = UILabel()
        progressLabel!.text = "进度: 0%"
        progressLabel!.textAlignment = .center
        stackView.addArrangedSubview(progressLabel!)
        
        let buttonStack = UIStackView()
        buttonStack.axis = .horizontal
        buttonStack.spacing = 20
        buttonStack.distribution = .fillEqually
        
        let startButton = UIButton(type: .system)
        startButton.setTitle("开始进度", for: .normal)
        startButton.backgroundColor = .systemBlue
        startButton.setTitleColor(.white, for: .normal)
        startButton.layer.cornerRadius = 8
        startButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        startButton.addTarget(self, action: #selector(startProgress), for: .touchUpInside)
        
        let resetButton = UIButton(type: .system)
        resetButton.setTitle("重置进度", for: .normal)
        resetButton.backgroundColor = .systemGray
        resetButton.setTitleColor(.white, for: .normal)
        resetButton.layer.cornerRadius = 8
        resetButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        resetButton.addTarget(self, action: #selector(resetProgress), for: .touchUpInside)
        
        buttonStack.addArrangedSubview(startButton)
        buttonStack.addArrangedSubview(resetButton)
        
        stackView.addArrangedSubview(buttonStack)
    }
    
    private func setupStepperDemo() {
        addSectionTitle("步进器")
        
        let stepperContainer = UIView()
        stepperContainer.translatesAutoresizingMaskIntoConstraints = false
        
        let stepper = UIStepper()
        stepper.translatesAutoresizingMaskIntoConstraints = false
        stepper.minimumValue = 0
        stepper.maximumValue = 10
        stepper.stepValue = 1
        stepper.value = 5
        stepper.addTarget(self, action: #selector(stepperValueChanged(_:)), for: .valueChanged)
        
        valueLabel = UILabel()
        valueLabel!.translatesAutoresizingMaskIntoConstraints = false
        valueLabel!.text = "当前值: 5"
        
        stepperContainer.addSubview(stepper)
        stepperContainer.addSubview(valueLabel!)
        
        NSLayoutConstraint.activate([
            stepper.leadingAnchor.constraint(equalTo: stepperContainer.leadingAnchor),
            stepper.centerYAnchor.constraint(equalTo: stepperContainer.centerYAnchor),
            
            valueLabel!.leadingAnchor.constraint(equalTo: stepper.trailingAnchor, constant: 20),
            valueLabel!.centerYAnchor.constraint(equalTo: stepperContainer.centerYAnchor),
            valueLabel!.trailingAnchor.constraint(equalTo: stepperContainer.trailingAnchor),
            
            stepperContainer.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        stackView.addArrangedSubview(stepperContainer)
    }
    
    private func setupDatePickerDemo() {
        addSectionTitle("日期选择器")
        
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .dateAndTime
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
        stackView.addArrangedSubview(datePicker)
        
        selectedLabel = UILabel()
        selectedLabel!.text = "选择的日期和时间将显示在这里"
        selectedLabel!.textAlignment = .center
        selectedLabel!.numberOfLines = 0
        stackView.addArrangedSubview(selectedLabel!)
        
        // 初始显示当前日期
        datePickerValueChanged(datePicker)
    }
    
    private func setupPickerViewDemo() {
        addSectionTitle("选择器")
        
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        stackView.addArrangedSubview(pickerView)
        
        selectedLabel = UILabel()
        selectedLabel!.text = "选择的内容将显示在这里"
        selectedLabel!.textAlignment = .center
        stackView.addArrangedSubview(selectedLabel!)
        
        // 初始显示第一个选项
        selectedLabel!.text = "选择了: 选项 1"
    }
    
    private func setupImageViewDemo() {
        addSectionTitle("图片视图")
        
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .systemGray6
        
        // 使用系统图标作为演示图片
        if let image = UIImage(systemName: "photo.circle.fill") {
            imageView.image = image
        }
        
        imageView.tintColor = .systemBlue
        imageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        stackView.addArrangedSubview(imageView)
        
        addDescriptionLabel("UIImageView 用于显示图片，支持多种内容模式")
    }
    
    private func setupAlertDemo() {
        addSectionTitle("警告框演示")
        
        let showAlertButton = UIButton(type: .system)
        showAlertButton.setTitle("显示警告框", for: .normal)
        showAlertButton.backgroundColor = .systemOrange
        showAlertButton.setTitleColor(.white, for: .normal)
        showAlertButton.layer.cornerRadius = 8
        showAlertButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        showAlertButton.addTarget(self, action: #selector(showAlert), for: .touchUpInside)
        stackView.addArrangedSubview(showAlertButton)
        
        addSectionTitle("操作菜单演示")
        
        let showActionSheetButton = UIButton(type: .system)
        showActionSheetButton.setTitle("显示操作菜单", for: .normal)
        showActionSheetButton.backgroundColor = .systemPurple
        showActionSheetButton.setTitleColor(.white, for: .normal)
        showActionSheetButton.layer.cornerRadius = 8
        showActionSheetButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        showActionSheetButton.addTarget(self, action: #selector(showActionSheet), for: .touchUpInside)
        stackView.addArrangedSubview(showActionSheetButton)
    }
    
    // MARK: - Helper Methods
    private func addSectionTitle(_ text: String) {
        let titleLabel = UILabel()
        titleLabel.text = text
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.textColor = .label
        stackView.addArrangedSubview(titleLabel)
    }
    
    private func addDescriptionLabel(_ text: String) {
        let descriptionLabel = UILabel()
        descriptionLabel.text = text
        descriptionLabel.font = UIFont.systemFont(ofSize: 14)
        descriptionLabel.textColor = .systemGray
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textAlignment = .center
        stackView.addArrangedSubview(descriptionLabel)
    }
    
    // MARK: - Action Methods
    @objc private func buttonTapped() {
        print("按钮被点击")
    }
    
    @objc private func switchValueChanged(_ sender: UISwitch) {
        statusLabel?.text = "开关状态: \(sender.isOn ? "开启" : "关闭")"
    }
    
    @objc private func sliderValueChanged(_ sender: UISlider) {
        valueLabel?.text = "当前值: \(Int(sender.value))"
    }
    
    @objc private func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        let selectedIndex = sender.selectedSegmentIndex
        let title = sender.titleForSegment(at: selectedIndex) ?? "未知"
        selectedLabel?.text = "选中: \(title)"
    }
    
    @objc private func startProgress() {
        progressTimer?.invalidate()
        progress = 0.0
        
        progressView?.progress = progress
        progressLabel?.text = "进度: 0%"
        
        progressTimer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { [weak self] timer in
            guard let self = self else { return }
            
            self.progress += 0.01
            self.progressView?.progress = self.progress
            self.progressLabel?.text = "进度: \(Int(self.progress * 100))%"
            
            if self.progress >= 1.0 {
                timer.invalidate()
                self.progressLabel?.text = "进度: 完成!"
            }
        }
    }
    
    @objc private func resetProgress() {
        progressTimer?.invalidate()
        progress = 0.0
        progressView?.progress = progress
        progressLabel?.text = "进度: 0%"
    }
    
    @objc private func stepperValueChanged(_ sender: UIStepper) {
        valueLabel?.text = "当前值: \(Int(sender.value))"
    }
    
    @objc private func datePickerValueChanged(_ sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy年MM月dd日 HH:mm"
        selectedLabel?.text = "选择的日期: \(formatter.string(from: sender.date))"
    }
    
    @objc private func showAlert() {
        let alert = UIAlertController(title: "警告", message: "这是一个 UIAlertController 演示", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "确定", style: .default, handler: { _ in
            print("确定按钮被点击")
        }))
        
        alert.addAction(UIAlertAction(title: "取消", style: .cancel, handler: { _ in
            print("取消按钮被点击")
        }))
        
        present(alert, animated: true, completion: nil)
    }
    
    @objc private func showActionSheet() {
        let actionSheet = UIAlertController(title: "操作菜单", message: "请选择一个操作", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "选项一", style: .default, handler: { _ in
            print("选项一被选择")
        }))
        
        actionSheet.addAction(UIAlertAction(title: "选项二", style: .default, handler: { _ in
            print("选项二被选择")
        }))
        
        actionSheet.addAction(UIAlertAction(title: "删除", style: .destructive, handler: { _ in
            print("删除操作被选择")
        }))
        
        actionSheet.addAction(UIAlertAction(title: "取消", style: .cancel, handler: { _ in
            print("操作被取消")
        }))
        
        present(actionSheet, animated: true, completion: nil)
    }
    
    // 添加触摸事件来处理键盘隐藏
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
}

// MARK: - UIPickerView DataSource & Delegate
extension ControlDetailViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 5
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "选项 \(row + 1)"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedLabel?.text = "选择了: 选项 \(row + 1)"
    }
}
