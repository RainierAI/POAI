//
//  ChatState.swift
//  LLMChat
//

import Foundation
import MLCSwift

enum MessageRole {
    case user
    case bot
}

extension MessageRole {
    var isUser: Bool { self == .user }
}

struct MessageData: Hashable {
    let id = UUID()
    var role: MessageRole
    var message: String
}

final class ChatState: ObservableObject {
    fileprivate enum ModelChatState {
        case generating
        case resetting
        case reloading
        case terminating
        case ready
        case failed
        case pendingImageUpload
        case processingImage
    }

    @Published var messages = [MessageData]()
    @Published var infoText = ""
    @Published var displayName = ""
    @Published var useVision = false
    
    private let modelChatStateLock = NSLock()
    private var modelChatState: ModelChatState = .ready

    private let threadWorker = ThreadWorker()
    private let chatModule = ChatModule()
    private var modelLib = ""
    private var modelPath = ""
    var localID = ""
    
    init() {
        threadWorker.qualityOfService = QualityOfService.userInteractive
        threadWorker.start()
    }
    
    var isInterruptible: Bool {
        return getModelChatState() == .ready
        || getModelChatState() == .generating
        || getModelChatState() == .failed
        || getModelChatState() == .pendingImageUpload
    }

    var isChattable: Bool {
        return getModelChatState() == .ready
    }

    var isUploadable: Bool {
        return getModelChatState() == .pendingImageUpload
    }

    var isResettable: Bool {
        return getModelChatState() == .ready
        || getModelChatState() == .generating
    }
    
    func requestResetChat(channel: FlutterMethodChannel) {
        assert(isResettable)
        interruptChat(prologue: {
            switchToResetting()
        }, epilogue: { [weak self] in
            self?.mainResetChat(channel: channel)
        })
    }
    
    func requestResetChat2(channel: FlutterMethodChannel, prompt: NSString) {
        assert(isResettable)
        interruptChat(prologue: {
            switchToResetting()
        }, epilogue: { [weak self] in
            self?.mainResetChat2(channel: channel, prompt: prompt)
        })
    }
    
    func requestTerminateChat(callback: @escaping () -> Void) {
        assert(isInterruptible)
        interruptChat(prologue: {
            switchToTerminating()
        }, epilogue: { [weak self] in
            self?.mainTerminateChat(callback: callback)
        })
    }
    
    func requestReloadChat(localID: String, modelLib: String, modelPath: String, estimatedVRAMReq: Int, displayName: String, channel: FlutterMethodChannel) {
        print("request reloading chat")
        
        if (isCurrentModel(localID: localID)) {
            return
        }
        assert(isInterruptible)
        interruptChat(prologue: {
            switchToReloading()
        }, epilogue: { [weak self] in
            self?.mainReloadChat(localID: localID,
                                 modelLib: modelLib,
                                 modelPath: modelPath,
                                 estimatedVRAMReq: estimatedVRAMReq,
                                 displayName: displayName, channel: channel)
        })
    }
    
    func requestGenerate(prompt: NSString, channel: FlutterMethodChannel) {
        print("Request Generating data from swift start")
        print("Chat state: \(isChattable)")
        assert(isChattable)
        switchToGenerating()
        appendMessage(role: .user, message: prompt as String)
        appendMessage(role: .bot, message: "")
        
        threadWorker.push {[weak self] in
            guard let self else {
                print("thread worker got and error")
                return
            }
            print("Thread workder is good to go")
            chatModule.prefill(prompt as String)
            print("Chat Module prefill is good to go")
            var result = ""
            while !chatModule.stopped() {
                print("Chat module processing")
                chatModule.decode()
                if let newText = chatModule.getMessage() {
                    DispatchQueue.main.async {
                        result = newText
                        self.updateMessage(role: .bot, message: newText, channel: channel, isGenerating: true)
                    }
                }

                if getModelChatState() != .generating {
                    break
                }
            }
            
            
            if getModelChatState() == .generating {
                if let runtimeStats = chatModule.runtimeStatsText(useVision) {
                    DispatchQueue.main.async {
                        self.infoText = runtimeStats
                        self.switchToReady()
                        self.updateMessage(role: .bot, message: result, channel: channel, isGenerating: false)
                    }
                }
            }
        }
    }
    
    func requestGenerate2(prompt: NSString, channel: FlutterMethodChannel) {
        print("Request Generating data from swift start")
        print("Chat state: \(isChattable)")
        assert(isChattable)
        switchToGenerating()
        appendMessage(role: .user, message: prompt as String)
        appendMessage(role: .bot, message: "")
        
        threadWorker.push {[weak self] in
            guard let self else {
                print("thread worker got and error")
                return
            }
            print("Thread workder is good to go")
            chatModule.prefill(prompt as String)
            print("Chat Module prefill is good to go")
            var result = ""
            while !chatModule.stopped() {
                print("Chat module processing")
                chatModule.decode()
                if let newText = chatModule.getMessage() {
                    DispatchQueue.main.async {
                        result = newText
//                        self.updateMessage(role: .bot, message: newText, channel: channel, isGenerating: true)
                    }
                }

                if getModelChatState() != .generating {
                    break
                }
            }
            
            
            if getModelChatState() == .generating {
                if let runtimeStats = chatModule.runtimeStatsText(useVision) {
                    DispatchQueue.main.async {
                        self.infoText = runtimeStats
                        self.switchToReady()
                        let arg = ["isGenerating": false] as [String : Any]
                        channel.invokeMethod("sendmsgswift2",arguments: arg)
                    }
                }
            }
        }
    }

//    func requestProcessImage(image: UIImage) {
//        assert(getModelChatState() == .pendingImageUpload)
//        switchToProcessingImage()
//        threadWorker.push {[weak self] in
//            guard let self else { return }
//            assert(messages.count > 0)
//            DispatchQueue.main.async {
//                self.updateMessage(role: .bot, message: "[System] Processing image")
//            }
//            // step 1. resize image
//            let new_image = resizeImage(image: image, width: 112, height: 112)
//            // step 2. prefill image by chatModule.prefillImage()
//            chatModule.prefillImage(new_image, prevPlaceholder: "<Img>", postPlaceholder: "</Img> ")
//            DispatchQueue.main.async {
//                self.updateMessage(role: .bot, message: "[System] Ready to chat")
//                self.switchToReady()
//            }
//        }
//    }

    func isCurrentModel(localID: String) -> Bool {
        return self.localID == localID
    }
}

private extension ChatState {
    func getModelChatState() -> ModelChatState {
        modelChatStateLock.lock()
        defer { modelChatStateLock.unlock() }
        return modelChatState
    }

    func setModelChatState(_ newModelChatState: ModelChatState) {
        modelChatStateLock.lock()
        modelChatState = newModelChatState
        modelChatStateLock.unlock()
    }

    func appendMessage(role: MessageRole, message: String) {
        messages.append(MessageData(role: role, message: message))
    }

    func updateMessage(role: MessageRole, message: String, channel: FlutterMethodChannel, isGenerating: Bool) {
        messages[messages.count - 1] = MessageData(role: role, message: message)
        let arg = ["message": message,
                   "isGenerating": isGenerating] as [String : Any]
        channel.invokeMethod("sendmsgswift", arguments: arg)
    }

    func clearHistory() {
        messages.removeAll()
        infoText = ""
    }

    func switchToResetting() {
        setModelChatState(.resetting)
    }

    func switchToGenerating() {
        setModelChatState(.generating)
    }

    func switchToReloading() {
        setModelChatState(.reloading)
    }

    func switchToReady() {
        setModelChatState(.ready)
    }

    func switchToTerminating() {
        setModelChatState(.terminating)
    }

    func switchToFailed() {
        setModelChatState(.failed)
    }

    func switchToPendingImageUpload() {
        setModelChatState(.pendingImageUpload)
    }

    func switchToProcessingImage() {
        setModelChatState(.processingImage)
    }

    func interruptChat(prologue: () -> Void, epilogue: @escaping () -> Void) {
        assert(isInterruptible)
        if getModelChatState() == .ready 
            || getModelChatState() == .failed
            || getModelChatState() == .pendingImageUpload {
            prologue()
            epilogue()
        } else if getModelChatState() == .generating {
            prologue()
            threadWorker.push {
                DispatchQueue.main.async {
                    epilogue()
                }
            }
        } else {
            assert(false)
        }
    }

    func mainResetChat(channel: FlutterMethodChannel) {
        threadWorker.push {[weak self] in
            guard let self else { return }
            chatModule.resetChat()
            if useVision {
                chatModule.resetImageModule()
            }
            DispatchQueue.main.async {
                self.clearHistory()
                if self.useVision {
                    self.appendMessage(role: .bot, message: "[System] Upload an image to chat")
                    self.switchToPendingImageUpload()
                } else {
                    print("Reset succeed")
                    channel.invokeMethod("reset", arguments: "done")
                    self.switchToReady()
                }
            }
        }
    }
    
    func mainResetChat2(channel: FlutterMethodChannel, prompt: NSString) {
        threadWorker.push {[weak self] in
            guard let self else { return }
            chatModule.resetChat()
            if useVision {
                chatModule.resetImageModule()
            }
            DispatchQueue.main.async {
                self.clearHistory()
                if self.useVision {
                    self.appendMessage(role: .bot, message: "[System] Upload an image to chat")
                    self.switchToPendingImageUpload()
                } else {
                    print("Reset succeed")
                    self.requestGenerate2(prompt: prompt, channel: channel)
                }
            }
        }
    }

    func mainTerminateChat(callback: @escaping () -> Void) {
        threadWorker.push {[weak self] in
            guard let self else { return }
            if useVision {
                chatModule.unloadImageModule()
            }
            chatModule.unload()
            DispatchQueue.main.async {
                self.clearHistory()
                self.localID = ""
                self.modelLib = ""
                self.modelPath = ""
                self.displayName = ""
                self.useVision = false
                self.switchToReady()
                callback()
            }
        }
    }

    func mainReloadChat(localID: String, modelLib: String, modelPath: String, estimatedVRAMReq: Int, displayName: String, channel: FlutterMethodChannel) {
        print("Main Reloading chat")
        clearHistory()
        let prevUseVision = useVision
        self.localID = localID
        self.modelLib = modelLib
        self.modelPath = modelPath
        self.displayName = displayName
        self.useVision = displayName.hasPrefix("minigpt")
        threadWorker.push {[weak self] in
            guard let self else { return }
            DispatchQueue.main.async {
                self.appendMessage(role: .bot, message: "[System] Initalize...")
            }
            if prevUseVision {
                chatModule.unloadImageModule()
            }
            chatModule.unload()
            let vRAM = os_proc_available_memory()
            if (vRAM < estimatedVRAMReq) {
                let myVram = String (
                    format: "%.1fMB", Double(vRAM) / Double(1 << 20))
                print("My device VRAM: \(myVram)")
                let requiredMemory = String (
                    format: "%.1fMB", Double(estimatedVRAMReq) / Double(1 << 20)
                )
                let errorMessage = (
                    "Sorry, the system cannot provide \(requiredMemory) VRAM as requested to the app, " +
                    "so we cannot initialize this model on this device."
                )
                DispatchQueue.main.sync {
                    print("Sorry, the system cannot provide \(requiredMemory) VRAM as requested to the app, " +
                          "so we cannot initialize this model on this device.")
                    self.messages.append(MessageData(role: MessageRole.bot, message: errorMessage))
                    self.switchToFailed()
                }
                return
            }

            if useVision {
                print("Using useVision")
                
                // load vicuna model
                let dir = (modelPath as NSString).deletingLastPathComponent
                let vicunaModelLib = "vicuna-7b-v1.3-q3f16_0"
                let vicunaModelPath = dir + "/" + vicunaModelLib
                let appConfigJSONData = try? JSONSerialization.data(withJSONObject: ["conv_template": "minigpt"], options: [])
                let appConfigJSON = String(data: appConfigJSONData!, encoding: .utf8)
                chatModule.reload(vicunaModelLib, modelPath: vicunaModelPath, appConfigJson: appConfigJSON)
                // load image model
                chatModule.reloadImageModule(modelLib, modelPath: modelPath)
            } else {
                print("Reloading chatmodule")
                chatModule.reload(modelLib, modelPath: modelPath, appConfigJson: "")
                print("Model: \(modelLib), Model path: \(modelPath)")
            }

            DispatchQueue.main.async {
                if self.useVision {
//                    self.updateMe/*ssage(role: .bot, message: "[System] Upload an image to chat", channel: channel, )*/
                    self.switchToPendingImageUpload()
                } else {
//                    self.updateMessage(role: .bot, message: "[System] Ready to chat", channel: channel, )
                    self.switchToReady()
                    print("System ready to chat")
                    channel.invokeMethod("appconfigdone", arguments: "done")
                }
            }
        }
    }
}
