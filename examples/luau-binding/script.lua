print("Hello from Luau!")

-- Basic operations
local x = 10
local y = 20
print("10 + 20 =", x + y)

-- Table operations
local colors = {"red", "green", "blue"}
print("Colors:")
for i, color in ipairs(colors) do
    print("  " .. color)
end

-- Local function
function test()
    print("Inside function")
end
test()