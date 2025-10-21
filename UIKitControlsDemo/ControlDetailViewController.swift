//
//  ControlDetailViewController.swift
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
        
        // 设置滚动视图
        scrollView.frame = view.bounds
        scrollView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        scrollView.alwaysBounceVertical = true
        view.addSubview(scrollView)
        
        // 内容视图
        contentView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 0)
        scrollView.addSubview(contentView)
    }
    
    // MARK: - Control Demos
    private func setupControlDemo() {
        // 重置内容视图
        contentView.subviews.forEach { $0.removeFromSuperview() }
        
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
        
        // 更新内容视图高度
        let lastSubview = contentView.subviews.last
        contentView.frame.size.height = (lastSubview?.frame.maxY ?? 0) + 20
        scrollView.contentSize = contentView.frame.size
    }
    
    // MARK: - 各个控件的演示方法
    private func setupLabelDemo() {
        addTitleLabel("UILabel 演示")
        
        // 基本标签
        let basicLabel = UILabel()
        basicLabel.text = "这是一个基本标签"
        basicLabel.textColor = .label
        basicLabel.frame = CGRect(x: 20, y: 60, width: view.bounds.width - 40, height: 30)
        contentView.addSubview(basicLabel)
        
        // 带样式的标签
        let styledLabel = UILabel()
        styledLabel.text = "带样式的标签"
        styledLabel.textColor = .systemBlue
        styledLabel.font = UIFont.boldSystemFont(ofSize: 18)
        styledLabel.textAlignment = .center
        styledLabel.backgroundColor = .systemGray6
        styledLabel.frame = CGRect(x: 20, y: 110, width: view.bounds.width - 40, height: 40)
        contentView.addSubview(styledLabel)
        
        // 多行标签
        let multilineLabel = UILabel()
        multilineLabel.text = "这是一个多行标签，可以显示多行文本内容。UILabel 是 UIKit 中最常用的控件之一。"
        multilineLabel.textColor = .label
        multilineLabel.numberOfLines = 0
        multilineLabel.frame = CGRect(x: 20, y: 170, width: view.bounds.width - 40, height: 80)
        contentView.addSubview(multilineLabel)
    }
    
    private func setupButtonDemo() {
        addTitleLabel("UIButton 演示")
        
        var currentY: CGFloat = 60
        
        // 系统按钮
        let systemButton = UIButton(type: .system)
        systemButton.setTitle("系统样式按钮", for: .normal)
        systemButton.frame = CGRect(x: 20, y: currentY, width: view.bounds.width - 40, height: 44)
        systemButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        contentView.addSubview(systemButton)
        
        currentY += 60
        
        // 自定义按钮
        let customButton = UIButton(type: .custom)
        customButton.setTitle("自定义按钮", for: .normal)
        customButton.setTitleColor(.white, for: .normal)
        customButton.backgroundColor = .systemBlue
        customButton.layer.cornerRadius = 8
        customButton.frame = CGRect(x: 20, y: currentY, width: view.bounds.width - 40, height: 44)
        customButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        contentView.addSubview(customButton)
        
        currentY += 60
        
        // 带图片的按钮
        let imageButton = UIButton(type: .system)
        imageButton.setTitle("带图标的按钮", for: .normal)
        imageButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        imageButton.tintColor = .systemYellow
        imageButton.frame = CGRect(x: 20, y: currentY, width: view.bounds.width - 40, height: 44)
        imageButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        contentView.addSubview(imageButton)
    }
    
    private func setupTextFieldDemo() {
        addTitleLabel("UITextField 演示")
        
        var currentY: CGFloat = 60
        
        // 基本文本输入框
        let basicTextField = UITextField()
        basicTextField.placeholder = "请输入文本"
        basicTextField.borderStyle = .roundedRect
        basicTextField.frame = CGRect(x: 20, y: currentY, width: view.bounds.width - 40, height: 44)
        contentView.addSubview(basicTextField)
        
        currentY += 60
        
        // 带图标的文本输入框
        let iconTextField = UITextField()
        iconTextField.placeholder = "带图标的输入框"
        iconTextField.borderStyle = .roundedRect
        let leftView = UIImageView(image: UIImage(systemName: "envelope"))
        leftView.tintColor = .systemGray
        leftView.frame = CGRect(x: 0, y: 0, width: 30, height: 20)
        leftView.contentMode = .scaleAspectFit
        iconTextField.leftView = leftView
        iconTextField.leftViewMode = .always
        iconTextField.frame = CGRect(x: 20, y: currentY, width: view.bounds.width - 40, height: 44)
        contentView.addSubview(iconTextField)
        
        currentY += 60
        
        // 安全文本输入框
        let secureTextField = UITextField()
        secureTextField.placeholder = "请输入密码"
        secureTextField.borderStyle = .roundedRect
        secureTextField.isSecureTextEntry = true
        secureTextField.frame = CGRect(x: 20, y: currentY, width: view.bounds.width - 40, height: 44)
        contentView.addSubview(secureTextField)
        
        currentY += 60
        
        // 添加说明标签
        let descriptionLabel = UILabel()
        descriptionLabel.text = "点击输入框开始输入，点击空白处结束编辑"
        descriptionLabel.textColor = .systemGray
        descriptionLabel.font = UIFont.systemFont(ofSize: 14)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.frame = CGRect(x: 20, y: currentY, width: view.bounds.width - 40, height: 40)
        contentView.addSubview(descriptionLabel)
    }
    
    private func setupTextViewDemo() {
        addTitleLabel("UITextView 演示")
        
        let textView = UITextView()
        textView.text = "这是一个 UITextView，支持多行文本输入和显示。\n\n你可以在这里输入大量的文本内容，支持滚动查看。UITextView 提供了丰富的文本编辑功能。"
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.systemGray4.cgColor
        textView.layer.cornerRadius = 8
        textView.frame = CGRect(x: 20, y: 60, width: view.bounds.width - 40, height: 200)
        contentView.addSubview(textView)
    }
    
    private func setupSwitchDemo() {
        addTitleLabel("UISwitch 演示")
        
        let switchControl = UISwitch()
        switchControl.isOn = true
        switchControl.frame.origin = CGPoint(x: 20, y: 60)
        switchControl.addTarget(self, action: #selector(switchValueChanged(_:)), for: .valueChanged)
        contentView.addSubview(switchControl)
        
        statusLabel = UILabel()
        statusLabel!.text = "开关状态: 开启"
        statusLabel!.frame = CGRect(x: 100, y: 60, width: 200, height: 31)
        contentView.addSubview(statusLabel!)
    }
    
    private func setupSliderDemo() {
        addTitleLabel("UISlider 演示")
        
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 100
        slider.value = 50
        slider.frame = CGRect(x: 20, y: 60, width: view.bounds.width - 40, height: 40)
        slider.addTarget(self, action: #selector(sliderValueChanged(_:)), for: .valueChanged)
        contentView.addSubview(slider)
        
        valueLabel = UILabel()
        valueLabel!.text = "当前值: 50"
        valueLabel!.textAlignment = .center
        valueLabel!.frame = CGRect(x: 20, y: 110, width: view.bounds.width - 40, height: 30)
        contentView.addSubview(valueLabel!)
    }
    
    private func setupSegmentedControlDemo() {
        addTitleLabel("UISegmentedControl 演示")
        
        let segmentedControl = UISegmentedControl(items: ["选项一", "选项二", "选项三"])
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.frame = CGRect(x: 20, y: 60, width: view.bounds.width - 40, height: 40)
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)
        contentView.addSubview(segmentedControl)
        
        selectedLabel = UILabel()
        selectedLabel!.text = "选中: 选项一"
        selectedLabel!.textAlignment = .center
        selectedLabel!.frame = CGRect(x: 20, y: 120, width: view.bounds.width - 40, height: 30)
        contentView.addSubview(selectedLabel!)
    }
    
    private func setupActivityIndicatorDemo() {
        addTitleLabel("UIActivityIndicatorView 演示")
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.center = CGPoint(x: view.bounds.width / 2, y: 100)
        activityIndicator.startAnimating()
        activityIndicator.color = .systemBlue
        contentView.addSubview(activityIndicator)
        
        let descriptionLabel = UILabel()
        descriptionLabel.text = "活动指示器正在旋转，通常用于表示任务正在进行中"
        descriptionLabel.textAlignment = .center
        descriptionLabel.numberOfLines = 0
        descriptionLabel.frame = CGRect(x: 20, y: 180, width: view.bounds.width - 40, height: 60)
        contentView.addSubview(descriptionLabel)
    }
    
    private func setupProgressViewDemo() {
        addTitleLabel("UIProgressView 演示")
        
        progressView = UIProgressView(progressViewStyle: .default)
        progressView!.progress = 0.0
        progressView!.frame = CGRect(x: 20, y: 60, width: view.bounds.width - 40, height: 4)
        contentView.addSubview(progressView!)
        
        progressLabel = UILabel()
        progressLabel!.text = "进度: 0%"
        progressLabel!.textAlignment = .center
        progressLabel!.frame = CGRect(x: 20, y: 80, width: view.bounds.width - 40, height: 30)
        contentView.addSubview(progressLabel!)
        
        let startButton = UIButton(type: .system)
        startButton.setTitle("开始进度", for: .normal)
        startButton.frame = CGRect(x: 20, y: 130, width: view.bounds.width - 40, height: 44)
        startButton.addTarget(self, action: #selector(startProgress), for: .touchUpInside)
        contentView.addSubview(startButton)
        
        let resetButton = UIButton(type: .system)
        resetButton.setTitle("重置进度", for: .normal)
        resetButton.frame = CGRect(x: 20, y: 190, width: view.bounds.width - 40, height: 44)
        resetButton.addTarget(self, action: #selector(resetProgress), for: .touchUpInside)
        contentView.addSubview(resetButton)
    }
    
    private func setupStepperDemo() {
        addTitleLabel("UIStepper 演示")
        
        let stepper = UIStepper()
        stepper.minimumValue = 0
        stepper.maximumValue = 10
        stepper.stepValue = 1
        stepper.value = 5
        stepper.frame.origin = CGPoint(x: 20, y: 60)
        stepper.addTarget(self, action: #selector(stepperValueChanged(_:)), for: .valueChanged)
        contentView.addSubview(stepper)
        
        valueLabel = UILabel()
        valueLabel!.text = "当前值: 5"
        valueLabel!.frame = CGRect(x: 120, y: 60, width: 200, height: 31)
        contentView.addSubview(valueLabel!)
    }
    
    private func setupDatePickerDemo() {
        addTitleLabel("UIDatePicker 演示")
        
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .dateAndTime
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.frame = CGRect(x: 0, y: 60, width: view.bounds.width, height: 200)
        datePicker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
        contentView.addSubview(datePicker)
        
        selectedLabel = UILabel()
        selectedLabel!.text = "选择的日期和时间将显示在这里"
        selectedLabel!.textAlignment = .center
        selectedLabel!.numberOfLines = 0
        selectedLabel!.frame = CGRect(x: 20, y: 280, width: view.bounds.width - 40, height: 60)
        contentView.addSubview(selectedLabel!)
        
        // 初始显示当前日期
        datePickerValueChanged(datePicker)
    }
    
    private func setupPickerViewDemo() {
        addTitleLabel("UIPickerView 演示")
        
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.frame = CGRect(x: 0, y: 60, width: view.bounds.width, height: 200)
        contentView.addSubview(pickerView)
        
        selectedLabel = UILabel()
        selectedLabel!.text = "选择的内容将显示在这里"
        selectedLabel!.textAlignment = .center
        selectedLabel!.frame = CGRect(x: 20, y: 280, width: view.bounds.width - 40, height: 30)
        contentView.addSubview(selectedLabel!)
        
        // 初始显示第一个选项
        if selectedLabel != nil {
            selectedLabel!.text = "选择了: 选项 1"
        }
    }
    
    private func setupImageViewDemo() {
        addTitleLabel("UIImageView 演示")
        
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .systemGray6
        
        // 使用系统图标作为演示图片
        if let image = UIImage(systemName: "photo.circle.fill") {
            imageView.image = image
        }
        
        imageView.frame = CGRect(x: 50, y: 60, width: view.bounds.width - 100, height: 200)
        imageView.tintColor = .systemBlue
        contentView.addSubview(imageView)
        
        let descriptionLabel = UILabel()
        descriptionLabel.text = "UIImageView 用于显示图片，支持多种内容模式"
        descriptionLabel.textAlignment = .center
        descriptionLabel.numberOfLines = 0
        descriptionLabel.frame = CGRect(x: 20, y: 280, width: view.bounds.width - 40, height: 60)
        contentView.addSubview(descriptionLabel)
    }
    
    private func setupAlertDemo() {
        addTitleLabel("UIAlertController 演示")
        
        var currentY: CGFloat = 60
        
        let showAlertButton = UIButton(type: .system)
        showAlertButton.setTitle("显示警告框", for: .normal)
        showAlertButton.frame = CGRect(x: 20, y: currentY, width: view.bounds.width - 40, height: 44)
        showAlertButton.addTarget(self, action: #selector(showAlert), for: .touchUpInside)
        contentView.addSubview(showAlertButton)
        
        currentY += 60
        
        let showActionSheetButton = UIButton(type: .system)
        showActionSheetButton.setTitle("显示操作菜单", for: .normal)
        showActionSheetButton.frame = CGRect(x: 20, y: currentY, width: view.bounds.width - 40, height: 44)
        showActionSheetButton.addTarget(self, action: #selector(showActionSheet), for: .touchUpInside)
        contentView.addSubview(showActionSheetButton)
    }
    
    // MARK: - Helper Methods
    private func addTitleLabel(_ text: String) {
        let titleLabel = UILabel()
        titleLabel.text = text
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.textAlignment = .center
        titleLabel.frame = CGRect(x: 20, y: 20, width: view.bounds.width - 40, height: 30)
        contentView.addSubview(titleLabel)
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
