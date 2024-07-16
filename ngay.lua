local binds = {}
local binds_first = {}
local forcebinds = {}
local uis = game:GetService'UserInputService';

function bind(key, func)
	binds[key] = func;
end
function bind_first(key, func)
	binds_first[key] = func;
end
function forcebind(key, func)
	forcebinds[key] = func;
end
function unbind(key)
	binds[key] = nil;
	binds_first[key] = nil;
end

uis.InputBegan:Connect(function(key)
	key = key.KeyCode.Name:lower();
	local inChat = uis:GetFocusedTextBox() and true or false;
	if not inChat then
		if binds_first[key] and typeof(binds_first[key]) == 'function' then
			binds_first[key]();
		end
	end
end)

uis.InputEnded:Connect(function(input)
	key = input.KeyCode.Name:lower();
	local inChat = uis:GetFocusedTextBox();
	if not inChat then
		if binds[key] and typeof(binds[key]) == 'function' and input.UserInputType.Name == 'Keyboard' then
			binds[key]();
		end
		if input.UserInputType.Name == 'MouseButton1' and binds.mouse1 ~= nil then
			binds.mouse1();
		end
		if input.UserInputType.Name == 'MouseButton2' and binds.mouse2 ~= nil then
			binds.mouse2();
		end
	else
		if forcebinds[key] and typeof(binds[key]) == 'function' then
			forcebinds[key]();
		end
	end
end)

getgenv().bind = bind;
getgenv().bind_first = bind_first;
getgenv().forcebind = forcebind;
getgenv().unbind = unbind;
