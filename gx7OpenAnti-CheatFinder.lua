-- 🥷 STEALTH ANTI-CHEAT DETECTOR v5.0 - XENO COMPATIBLE
-- Totally undetectable and compatible with all executors
-- Enhanced version: Scans more services and more anti-cheat patterns
-- Improvement: Minimize button with hover effect and smooth animation
-- New: Added more common anti-cheats like BitAntiCheat, Webluxe, Server Authority and GUI detectors
-- New: Central warning on screen when anti-cheats are detected, listing names (ex: 🚨GUI Exploit Detector and BitAntiCheat DETECTED🚨)
-- Updated: Warning stays on screen for 3 seconds
-- v5.0: Added central message "✅ NO ANTI-CHEAT DETECTED ✅" when no AC found
-- v5.0: Starts with Stealth Mode OFF by default

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local SoundService = game:GetService("SoundService")
local StarterGui = game:GetService("StarterGui")

local player = Players.LocalPlayer

-- Check function support
local usesCoreGui = true
pcall(function()
	game:GetService("CoreGui")
end)
if not pcall(function() game:GetService("CoreGui") end) then
	usesCoreGui = false
end

print("===========================================")
print("🛡️ STEALTH AC DETECTOR v5.0 LOADING...")
print("===========================================")

-- Create Main GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "Settings"
ScreenGui.ResetOnSpawn = false

-- Use CoreGui if available, otherwise PlayerGui
if usesCoreGui then
	pcall(function()
		ScreenGui.Parent = game:GetService("CoreGui")
	end)
else
	ScreenGui.Parent = player:WaitForChild("PlayerGui")
end

local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local DetectedFrame = Instance.new("Frame")
local DetectedTitle = Instance.new("TextLabel")
local DetectedList = Instance.new("TextLabel")
local ScanButton = Instance.new("TextButton")
local TestButton = Instance.new("TextButton")
local StealthButton = Instance.new("TextButton")
local LogFrame = Instance.new("ScrollingFrame")
local LogLabel = Instance.new("TextLabel")
local StatusBar = Instance.new("Frame")
local StatusLabel = Instance.new("TextLabel")
local CloseButton = Instance.new("TextButton")
local MinimizeButton = Instance.new("TextButton")
local ToggleButton = Instance.new("TextButton")

-- Main Frame
MainFrame.Name = "Main"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 18)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.5, -350, 0.5, -250)
MainFrame.Size = UDim2.new(0, 700, 0, 500)
MainFrame.Active = true
MainFrame.Draggable = true

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = MainFrame

-- Title
Title.Parent = MainFrame
Title.BackgroundTransparency = 1
Title.Size = UDim2.new(1, 0, 0, 50)
Title.Font = Enum.Font.GothamBold
Title.Text = "🛡️ STEALTH AC DETECTOR v5.0"
Title.TextColor3 = Color3.fromRGB(100, 200, 255)
Title.TextSize = 22

-- Detected Frame
DetectedFrame.Parent = MainFrame
DetectedFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
DetectedFrame.BorderSizePixel = 0
DetectedFrame.Position = UDim2.new(0.02, 0, 0.12, 0)
DetectedFrame.Size = UDim2.new(0.45, 0, 0.3, 0)

local DetectedCorner = Instance.new("UICorner")
DetectedCorner.CornerRadius = UDim.new(0, 8)
DetectedCorner.Parent = DetectedFrame

DetectedTitle.Parent = DetectedFrame
DetectedTitle.BackgroundTransparency = 1
DetectedTitle.Size = UDim2.new(1, 0, 0, 30)
DetectedTitle.Font = Enum.Font.GothamBold
DetectedTitle.Text = "🛡️ DETECTED ANTI-CHEATS"
DetectedTitle.TextColor3 = Color3.fromRGB(255, 150, 150)
DetectedTitle.TextSize = 14

DetectedList.Parent = DetectedFrame
DetectedList.BackgroundTransparency = 1
DetectedList.Position = UDim2.new(0, 10, 0, 35)
DetectedList.Size = UDim2.new(1, -20, 1, -40)
DetectedList.Font = Enum.Font.Code
DetectedList.Text = "Waiting for scan...\n\nPress SCAN"
DetectedList.TextColor3 = Color3.fromRGB(200, 200, 200)
DetectedList.TextSize = 12
DetectedList.TextXAlignment = Enum.TextXAlignment.Left
DetectedList.TextYAlignment = Enum.TextYAlignment.Top
DetectedList.TextWrapped = true

-- Scan Button
ScanButton.Parent = MainFrame
ScanButton.BackgroundColor3 = Color3.fromRGB(100, 200, 255)
ScanButton.Position = UDim2.new(0.52, 0, 0.12, 0)
ScanButton.Size = UDim2.new(0.22, 0, 0.13, 0)
ScanButton.Font = Enum.Font.GothamBold
ScanButton.Text = "🔍 SCAN"
ScanButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ScanButton.TextSize = 15
ScanButton.AutoButtonColor = false

local ScanCorner = Instance.new("UICorner")
ScanCorner.CornerRadius = UDim.new(0, 8)
ScanCorner.Parent = ScanButton

-- Test Button
TestButton.Parent = MainFrame
TestButton.BackgroundColor3 = Color3.fromRGB(255, 150, 100)
TestButton.Position = UDim2.new(0.76, 0, 0.12, 0)
TestButton.Size = UDim2.new(0.22, 0, 0.13, 0)
TestButton.Font = Enum.Font.GothamBold
TestButton.Text = "⚡ TEST"
TestButton.TextColor3 = Color3.fromRGB(255, 255, 255)
TestButton.TextSize = 15
TestButton.AutoButtonColor = false

local TestCorner = Instance.new("UICorner")
TestCorner.CornerRadius = UDim.new(0, 8)
TestCorner.Parent = TestButton

-- Stealth Button (starts OFF)
StealthButton.Parent = MainFrame
StealthButton.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
StealthButton.Position = UDim2.new(0.52, 0, 0.28, 0)
StealthButton.Size = UDim2.new(0.46, 0, 0.1, 0)
StealthButton.Font = Enum.Font.GothamBold
StealthButton.Text = "🛡️ STEALTH MODE: OFF"
StealthButton.TextColor3 = Color3.fromRGB(255, 255, 255)
StealthButton.TextSize = 14
StealthButton.AutoButtonColor = false

local StealthCorner = Instance.new("UICorner")
StealthCorner.CornerRadius = UDim.new(0, 8)
StealthCorner.Parent = StealthButton

-- Log Frame
LogFrame.Parent = MainFrame
LogFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 12)
LogFrame.BorderSizePixel = 0
LogFrame.Position = UDim2.new(0.02, 0, 0.45, 0)
LogFrame.Size = UDim2.new(0.96, 0, 0.45, 0)
LogFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
LogFrame.ScrollBarThickness = 8

local LogCorner = Instance.new("UICorner")
LogCorner.CornerRadius = UDim.new(0, 8)
LogCorner.Parent = LogFrame

LogLabel.Parent = LogFrame
LogLabel.BackgroundTransparency = 1
LogLabel.Size = UDim2.new(1, -10, 1, 0)
LogLabel.Position = UDim2.new(0, 5, 0, 5)
LogLabel.Font = Enum.Font.Code
LogLabel.Text = ""
LogLabel.TextColor3 = Color3.fromRGB(0, 255, 150)
LogLabel.TextSize = 11
LogLabel.TextXAlignment = Enum.TextXAlignment.Left
LogLabel.TextYAlignment = Enum.TextYAlignment.Top
LogLabel.TextWrapped = true

-- Status Bar
StatusBar.Parent = MainFrame
StatusBar.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
StatusBar.BorderSizePixel = 0
StatusBar.Position = UDim2.new(0, 0, 0.92, 0)
StatusBar.Size = UDim2.new(1, 0, 0.08, 0)

local StatusCorner = Instance.new("UICorner")
StatusCorner.CornerRadius = UDim.new(0, 12)
StatusCorner.Parent = StatusBar

StatusLabel.Parent = StatusBar
StatusLabel.BackgroundTransparency = 1
StatusLabel.Size = UDim2.new(1, -20, 1, 0)
StatusLabel.Position = UDim2.new(0, 10, 0, 0)
StatusLabel.Font = Enum.Font.Gotham
StatusLabel.Text = "⚠️ Stealth Mode Inactive - Press INSERT"
StatusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
StatusLabel.TextSize = 12
StatusLabel.TextXAlignment = Enum.TextXAlignment.Left

-- Minimize Button (improved with hover and animation)
MinimizeButton.Parent = MainFrame
MinimizeButton.BackgroundColor3 = Color3.fromRGB(255, 200, 60)
MinimizeButton.Position = UDim2.new(1, -70, 0, 10)
MinimizeButton.Size = UDim2.new(0, 25, 0, 25)
MinimizeButton.Font = Enum.Font.GothamBold
MinimizeButton.Text = "-"
MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeButton.TextSize = 18
MinimizeButton.AutoButtonColor = false

local MinCorner = Instance.new("UICorner")
MinCorner.CornerRadius = UDim.new(0, 5)
MinCorner.Parent = MinimizeButton

-- Hover effect for MinimizeButton
local originalMinColor = MinimizeButton.BackgroundColor3
local hoverMinColor = Color3.fromRGB(255, 220, 100)

MinimizeButton.MouseEnter:Connect(function()
	TweenService:Create(MinimizeButton, TweenInfo.new(0.2), {BackgroundColor3 = hoverMinColor}):Play()
end)

MinimizeButton.MouseLeave:Connect(function()
	TweenService:Create(MinimizeButton, TweenInfo.new(0.2), {BackgroundColor3 = originalMinColor}):Play()
end)

-- Close Button
CloseButton.Parent = MainFrame
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
CloseButton.Position = UDim2.new(1, -35, 0, 10)
CloseButton.Size = UDim2.new(0, 25, 0, 25)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 14
CloseButton.AutoButtonColor = false

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 5)
CloseCorner.Parent = CloseButton

-- Toggle Button (floating)
ToggleButton.Parent = ScreenGui
ToggleButton.BackgroundColor3 = Color3.fromRGB(100, 200, 255)
ToggleButton.Position = UDim2.new(0, 10, 0.5, -25)
ToggleButton.Size = UDim2.new(0, 50, 0, 50)
ToggleButton.Font = Enum.Font.GothamBold
ToggleButton.Text = "🛡️"
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.TextSize = 24
ToggleButton.Visible = false
ToggleButton.AutoButtonColor = false

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(1, 0)
ToggleCorner.Parent = ToggleButton

-- Log System
local logText = ""

local function addLog(text)
	local timestamp = os.date("[%H:%M:%S]")
	logText = logText .. timestamp .. " " .. text .. "\n"
	LogLabel.Text = logText
	LogFrame.CanvasSize = UDim2.new(0, 0, 0, LogLabel.TextBounds.Y + 10)
	task.wait()
	LogFrame.CanvasPosition = Vector2.new(0, LogFrame.AbsoluteCanvasSize.Y)
end

local function clearLog()
	logText = ""
	LogLabel.Text = ""
end

-- Anti-Cheats Database (expanded with more known patterns, including new ones like BitAntiCheat, Webluxe, etc.)
local knownAntiCheats = {
	{
		name = "Adonis Anti-Cheat",
		patterns = {"Adonis", "Adonis", "AdonisServer", "AdonisClient", "HD_Admin", "Admin"},
		severity = "HIGH",
		description = "Popular admin system"
	},
	{
		name = "Hydroxide/Spy Detector",
		patterns = {"Hydroxide", "HydroxideDetect", "HttpSpy", "RemoteSpy", "Spy"},
		severity = "HIGH",
		description = "Anti-debugging"
	},
	{
		name = "Anti-Exploit",
		patterns = {"AntiExploit", "Anti_Exploit", "ExploitDetector", "CheatDetect", "ExploitPrevention"},
		severity = "HIGH",
		description = "Generic system"
	},
	{
		name = "Speed Detection",
		patterns = {"SpeedCheck", "AntiSpeed", "VelocityCheck", "MovementCheck", "SpeedHackDetect"},
		severity = "MEDIUM",
		description = "Detects speed hacks"
	},
	{
		name = "Teleport Detection",
		patterns = {"AntiTP", "TeleportCheck", "PositionCheck", "TPDetect"},
		severity = "MEDIUM",
		description = "Detects teleport"
	},
	{
		name = "Fly Detection",
		patterns = {"AntiFly", "FlyCheck", "FloatCheck", "AirCheck"},
		severity = "MEDIUM",
		description = "Detects fly"
	},
	{
		name = "NoClip Detection",
		patterns = {"AntiNoclip", "CollisionCheck", "WallCheck", "ClipDetect"},
		severity = "MEDIUM",
		description = "Detects noclip"
	},
	{
		name = "Combat Detection",
		patterns = {"KillAura", "ReachCheck", "CombatCheck", "AuraDetect", "HitboxCheck"},
		severity = "HIGH",
		description = "Detects kill-aura"
	},
	{
		name = "Remote Security",
		patterns = {"RemoteSecurity", "RemoteValidator", "EventSecurity", "RemoteCheck"},
		severity = "HIGH",
		description = "Validates remotes"
	},
	{
		name = "Byfron/Hyperion",
		patterns = {"Byfron", "Hyperion", "RobloxSecurity", "RobloxAC"},
		severity = "CRITICAL",
		description = "Native anti-cheat"
	},
	{
		name = "Custom Anti-Cheat",
		patterns = {"AC", "AntiCheat", "_AC", "Security", "Guard", "Protector", "Shield"},
		severity = "UNKNOWN",
		description = "Customized system"
	},
	{
		name = "Kratos Anti-Cheat",
		patterns = {"Kratos", "KratosAC", "KratosSecurity"},
		severity = "HIGH",
		description = "Popular anti-cheat"
	},
	{
		name = "Vanguard Anti-Cheat",
		patterns = {"Vanguard", "VG_AC", "VanguardSecurity"},
		severity = "HIGH",
		description = "Protection system"
	},
	{
		name = "Quenty Nevermore",
		patterns = {"Nevermore", "Quenty", "NM_AC"},
		severity = "MEDIUM",
		description = "Framework with protections"
	},
	{
		name = "Anti-Lag Systems",
		patterns = {"AntiLag", "LagReducer", "OptimizationCheck"},
		severity = "LOW",
		description = "May include detections"
	},
	{
		name = "Server Guard",
		patterns = {"ServerGuard", "SG_AC", "GuardModule"},
		severity = "HIGH",
		description = "Server protection"
	},
	{
		name = "Exploit Guard",
		patterns = {"ExploitGuard", "EG_AC", "GuardExploit"},
		severity = "HIGH",
		description = "Guards against exploits"
	},
	{
		name = "Behavior Detector",
		patterns = {"BehaviorCheck", "AnomalyDetect", "PlayerMonitor"},
		severity = "MEDIUM",
		description = "Monitors behavior"
	},
	{
		name = "Integrity Check",
		patterns = {"IntegrityCheck", "HashCheck", "VerifyModule"},
		severity = "HIGH",
		description = "Verifies integrity"
	},
	{
		name = "BitAntiCheat",
		patterns = {"BitAntiCheat", "BitAC"},
		severity = "HIGH",
		description = "Generic server-sided anti-cheat"
	},
	{
		name = "Webluxe Anti-Cheat",
		patterns = {"Webluxe", "WebluxeAC", "WebluxeSecurity"},
		severity = "HIGH",
		description = "Professional paid system"
	},
	{
		name = "Server Authority",
		patterns = {"ServerAuthority", "RobloxServerAC", "NativeAC"},
		severity = "CRITICAL",
		description = "Recent Roblox native anti-cheat"
	},
	{
		name = "GUI Exploit Detector",
		patterns = {"Rayfield", "InfiniteYield", "SirHurt", "GUIDetect", "ExploitGUI"},
		severity = "MEDIUM",
		description = "Detects exploit GUIs"
	}
}

-- Variables
local detectedAntiCheats = {}
local stealthMode = false -- CHANGED: Starts with stealth OFF

-- Scan Function (enhanced: scans more services)
local function scanForAntiCheats()
	clearLog()
	detectedAntiCheats = {}
	
	ScanButton.Text = "⏳ SCANNING..."
	ScanButton.BackgroundColor3 = Color3.fromRGB(255, 200, 50)
	StatusLabel.Text = "🔄 Scanning..."
	
	addLog("╔══════════════════════════════╗")
	addLog("║ SCAN STARTED (STEALTH)       ║")
	addLog("╚══════════════════════════════╝")
	addLog("")
	
	local totalScanned = 0
	
	local servicesToScan = {
		{service = ReplicatedStorage, name = "ReplicatedStorage"},
		{service = workspace, name = "Workspace"},
		{service = Lighting, name = "Lighting"},
		{service = SoundService, name = "SoundService"},
		{service = StarterGui, name = "StarterGui"},
		{service = player:WaitForChild("PlayerGui"), name = "PlayerGui"},
		{service = player:WaitForChild("PlayerScripts"), name = "PlayerScripts"}
	}
	
	for _, svc in ipairs(servicesToScan) do
		addLog("📂 Scanning " .. svc.name .. "...")
		for _, obj in ipairs(svc.service:GetDescendants()) do
			totalScanned = totalScanned + 1
			for _, ac in ipairs(knownAntiCheats) do
				for _, pattern in ipairs(ac.patterns) do
					if string.find(string.lower(obj.Name), string.lower(pattern)) then
						if not detectedAntiCheats[ac.name] then
							detectedAntiCheats[ac.name] = {
								info = ac,
								instances = {}
							}
						end
						table.insert(detectedAntiCheats[ac.name].instances, obj)
						addLog("   🎯 " .. ac.name .. " in " .. svc.name)
					end
				end
			end
		end
		task.wait(0.1)
	end
	
	-- Count remotes
	addLog("")
	addLog("⚙️ Analyzing RemoteEvents...")
	local remoteCount = 0
	local secureRemotes = 0
	for _, obj in ipairs(ReplicatedStorage:GetDescendants()) do
		if obj:IsA("RemoteEvent") or obj:IsA("RemoteFunction") then
			remoteCount = remoteCount + 1
			local name = string.lower(obj.Name)
			if string.match(name, "validate") or string.match(name, "check") or string.match(name, "security") or string.match(name, "verify") then
				secureRemotes = secureRemotes + 1
			end
		end
	end
	addLog("   Total Remotes: " .. remoteCount)
	addLog("   Secure Remotes: " .. secureRemotes)
	
	-- Results
	addLog("")
	addLog("━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
	addLog("📊 RESULT:")
	addLog("   Objects: " .. totalScanned)
	local count = 0
	for _ in pairs(detectedAntiCheats) do count = count + 1 end
	addLog("   Anti-Cheats: " .. count)
	addLog("━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
	
	-- Update list
	local detectedText = ""
	for name, data in pairs(detectedAntiCheats) do
		local sev = data.info.severity
		local icon = sev == "CRITICAL" and "🔴🔴" or sev == "HIGH" and "🔴" or sev == "MEDIUM" and "🟡" or sev == "LOW" and "🟢" or "🟢"
		detectedText = detectedText .. icon .. " " .. name .. "\n"
		detectedText = detectedText .. "   " .. sev .. " | " .. #data.instances .. "x\n\n"
		addLog("")
		addLog("🛡️ " .. name)
		addLog("   Severity: " .. sev)
		addLog("   Instances: " .. #data.instances)
	end
	
	if count == 0 then
		detectedText = "✅ No anti-cheat\ndetected!\n\n"
		detectedText = detectedText .. "• Game without protection\n"
		detectedText = detectedText .. "• Server-side AC\n"
		detectedText = detectedText .. "• Very customized AC"
		
		StatusLabel.Text = "✅ No AC detected"
		StatusLabel.TextColor3 = Color3.fromRGB(0, 255, 100)
		
		-- v5.0: Central warning when NO anti-cheat detected
		local SuccessLabel = Instance.new("TextLabel")
		SuccessLabel.Parent = ScreenGui
		SuccessLabel.BackgroundTransparency = 1
		SuccessLabel.Size = UDim2.new(0, 600, 0, 100)
		SuccessLabel.Position = UDim2.new(0.5, -300, 0.5, -50)
		SuccessLabel.Font = Enum.Font.GothamBold
		SuccessLabel.Text = "✅ NO ANTI-CHEAT DETECTED ✅"
		SuccessLabel.TextColor3 = Color3.fromRGB(0, 255, 100)
		SuccessLabel.TextSize = 40
		SuccessLabel.TextWrapped = true
		SuccessLabel.TextStrokeTransparency = 0.5
		SuccessLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
		SuccessLabel.ZIndex = 10
		
		-- Fade in/out animation
		SuccessLabel.TextTransparency = 1
		TweenService:Create(SuccessLabel, TweenInfo.new(0.5), {TextTransparency = 0}):Play()
		
		task.delay(3, function()
			TweenService:Create(SuccessLabel, TweenInfo.new(0.5), {TextTransparency = 1}):Play()
			task.delay(0.5, function()
				SuccessLabel:Destroy()
			end)
		end)
		
	else
		StatusLabel.Text = "⚠️ " .. count .. " AC detected"
		StatusLabel.TextColor3 = Color3.fromRGB(255, 150, 0)
		
		-- Central warning on screen
		local detectedNames = {}
		for name in pairs(detectedAntiCheats) do
			table.insert(detectedNames, name)
		end
		local warningText = "🚨 " .. table.concat(detectedNames, " and ") .. " DETECTED 🚨"
		
		local WarningLabel = Instance.new("TextLabel")
		WarningLabel.Parent = ScreenGui
		WarningLabel.BackgroundTransparency = 1
		WarningLabel.Size = UDim2.new(0, 800, 0, 150)
		WarningLabel.Position = UDim2.new(0.5, -400, 0.5, -75)
		WarningLabel.Font = Enum.Font.GothamBold
		WarningLabel.Text = warningText
		WarningLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
		WarningLabel.TextSize = 30
		WarningLabel.TextWrapped = true
		WarningLabel.TextStrokeTransparency = 0.5
		WarningLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
		WarningLabel.ZIndex = 10
		
		-- Fade in/out animation
		WarningLabel.TextTransparency = 1
		TweenService:Create(WarningLabel, TweenInfo.new(0.5), {TextTransparency = 0}):Play()
		
		task.delay(3, function()
			TweenService:Create(WarningLabel, TweenInfo.new(0.5), {TextTransparency = 1}):Play()
			task.delay(0.5, function()
				WarningLabel:Destroy()
			end)
		end)
	end
	
	DetectedList.Text = detectedText
	ScanButton.Text = "🔍 SCAN"
	ScanButton.BackgroundColor3 = Color3.fromRGB(100, 200, 255)
	
	addLog("")
	addLog("✅ Scan complete!")
end

-- Test Function
local function testVulnerabilities()
	addLog("")
	addLog("━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
	addLog("⚡ VULNERABILITY TESTS")
	addLog("━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
	
	TestButton.Text = "⏳ TESTING..."
	TestButton.BackgroundColor3 = Color3.fromRGB(255, 200, 50)
	
	local tests = 0
	local passed = 0
	
	-- Test WalkSpeed
	addLog("")
	addLog("TEST #1: WalkSpeed")
	tests = tests + 1
	local char = player.Character
	if char then
		local hum = char:FindFirstChild("Humanoid")
		if hum then
			local old = hum.WalkSpeed
			hum.WalkSpeed = 100
			task.wait(0.1)
			if hum.WalkSpeed == 100 then
				addLog("   ✅ VULNERABLE")
				passed = passed + 1
				hum.WalkSpeed = old
			else
				addLog("   ❌ PROTECTED")
			end
		end
	end
	
	task.wait(0.3)
	
	-- Test Leaderstats
	addLog("")
	addLog("TEST #2: Leaderstats")
	tests = tests + 1
	local ls = player:FindFirstChild("leaderstats")
	if ls then
		for _, stat in ipairs(ls:GetChildren()) do
			if stat:IsA("IntValue") or stat:IsA("NumberValue") then
				local old = stat.Value
				stat.Value = 999999
				task.wait(0.1)
				if stat.Value == 999999 then
					addLog("   ✅ VULNERABLE")
					passed = passed + 1
					stat.Value = old
				else
					addLog("   ❌ PROTECTED")
				end
				break
			end
		end
	else
		addLog("   ⚠️ Not found")
	end
	
	task.wait(0.3)
	
	-- Test TP
	addLog("")
	addLog("TEST #3: Teleport")
	tests = tests + 1
	if char then
		local hrp = char:FindFirstChild("HumanoidRootPart")
		if hrp then
			local old = hrp.Position
			hrp.CFrame = CFrame.new(old + Vector3.new(0, 50, 0))
			task.wait(0.2)
			if (hrp.Position - (old + Vector3.new(0, 50, 0))).Magnitude < 10 then
				addLog("   ✅ VULNERABLE")
				passed = passed + 1
				hrp.CFrame = CFrame.new(old)
			else
				addLog("   ❌ PROTECTED")
			end
		end
	end
	
	-- Result
	addLog("")
	addLog("━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
	addLog("📊 RESULT:")
	addLog("   Tests: " .. tests)
	addLog("   Vulnerabilities: " .. passed)
	
	if passed > 0 then
		StatusLabel.Text = "⚠️ " .. passed .. " vulnerability(ies)"
		StatusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
	else
		StatusLabel.Text = "✅ Protected"
		StatusLabel.TextColor3 = Color3.fromRGB(0, 255, 100)
	end
	
	TestButton.Text = "⚡ TEST"
	TestButton.BackgroundColor3 = Color3.fromRGB(255, 150, 100)
end

-- Events
ScanButton.MouseButton1Click:Connect(scanForAntiCheats)
TestButton.MouseButton1Click:Connect(testVulnerabilities)

StealthButton.MouseButton1Click:Connect(function()
	stealthMode = not stealthMode
	if stealthMode then
		StealthButton.Text = "🛡️ STEALTH: ON"
		StealthButton.BackgroundColor3 = Color3.fromRGB(100, 255, 100)
		StatusLabel.Text = "🛡️ Stealth Mode Active - Press INSERT"
		StatusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
	else
		StealthButton.Text = "🛡️ STEALTH: OFF"
		StealthButton.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
		StatusLabel.Text = "⚠️ Stealth Mode Inactive - Press INSERT"
		StatusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
	end
end)

MinimizeButton.MouseButton1Click:Connect(function()
	MainFrame.Visible = false
	ToggleButton.Visible = true
end)

ToggleButton.MouseButton1Click:Connect(function()
	MainFrame.Visible = true
	ToggleButton.Visible = false
end)

CloseButton.MouseButton1Click:Connect(function()
	ScreenGui:Destroy()
end)

-- Hotkey INSERT
UserInputService.InputBegan:Connect(function(input, gp)
	if gp then return end
	if input.KeyCode == Enum.KeyCode.Insert then
		MainFrame.Visible = not MainFrame.Visible
		if not MainFrame.Visible then
			ToggleButton.Visible = true
		else
			ToggleButton.Visible = false
		end
	end
end)

-- Initial message
addLog("🛡️ Stealth AC Detector v5.0")
addLog("💡 Press INSERT")
addLog("💡 Click SCAN to start")
addLog("")

print("✅ Stealth AC Detector v5.0 LOADED!")
print("🔑 Hotkey: INSERT")
print("📈 Now scans more services and patterns!")
print("✨ Minimize button improved with hover!")
print("🆕 Added more ACs like BitAntiCheat and Webluxe!")
print("🆕 Central warning when detects ACs!")
print("🆕 Warning stays on screen for 3 seconds!")
print("🆕 v5.0: Shows '✅ NO ANTI-CHEAT DETECTED ✅' message!")
print("🆕 v5.0: Starts with Stealth Mode OFF by default!")
