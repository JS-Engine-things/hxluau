-- Luau type annotation example
local function greet(name: string, age: number): string
	return "Hello, " .. name .. "! You are " .. age .. " years old."
end

print(greet("Alice", 30))

-- Luau type inference
local numbers: {number} = {1, 2, 3, 4, 5}
local total = 0
for _, num in ipairs(numbers) do
	total += num  -- Luau supports compound assignment operators
end
print("Total: " .. total)

-- Luau dictionary type
local person: {name: string, age: number} = {
	name = "Bob",
	age = 25
}
print("Person: " .. person.name .. ", age: " .. person.age)

-- Luau union type (simulation)
local function processValue(value: any)
	if type(value) == "string" then
		print("Got string: " .. value)
	elseif type(value) == "number" then
		print("Got number: " .. value)
	else
		print("Got other type: " .. type(value))
	end
end

processValue("Hello")
processValue(42)
processValue({x = 1, y = 2})

local a = 1
a += 20
print(a)

-- Luau indexer type (simulation)
local config: {[string]: any} = {
	theme = "dark",
	version = "1.0",
	active = true
}

for key, value in pairs(config) do
	print(key .. " = " .. tostring(value))
end

-- Luau's table library enhancements
local fruits = {"apple", "banana", "cherry"}
table.insert(fruits, "date")
print("Fruits: " .. table.concat(fruits, ", "))

-- Luau for loop
for i = 1, 3 do
	print("for loop: " .. i)
end

-- Using method call syntax (Luau compatible)
local obj = {x = 10, y = 20}
function obj:move(dx, dy)
	self.x += dx
	self.y += dy
end

obj:move(5, -5)
print("Object position: (" .. obj.x .. ", " .. obj.y .. ")")

-- Luau bitwise operations (if available)
if bit32 then
	local a = 12
	local b = 10
	print("Bitwise AND: " .. bit32.band(a, b))
	print("Bitwise OR: " .. bit32.bor(a, b))
	print("Bitwise XOR: " .. bit32.bxor(a, b))
end
