--[[
    CC-BlackJack

    Copyright (C) 2025 Clifton Toaster Reid <cliftontreid@duck.com>

    This library is free software: you can redistribute it and/or modify
    it under the terms of the GNU Lesser General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This library is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
    GNU Lesser General Public License for more details.

    You should have received a copy of the GNU Lesser General Public License
    along with this library. If not, see <https://www.gnu.org/licenses/>.

    Furthermore, this library is provided as a reusable toolkit.
    You are free and encouraged to incorporate any part of this code
    into your own projects (open-source or commercial),
    under the terms of the GNU Lesser General Public License v3 or later.
]]

--[[
    Blackjack game for ComputerCraft
    This is a simple implementation of the classic card game Blackjack
    to be played alone against a robodealer, because humans might believe
    they will be selling drugs.
]]

--[[
    This file contains the configuration for the game.
    It includes the card images, the dealer's name, and the player's name.
]]

local expect = require("cc.expect").expect
local toml = require("src.toml")
local config = {}

---@class DealerConfig
---@field name string
---@field reward number

---@class CardConfig
---@field ace_value number

---@class BlackjackConfig
---@field dealer DealerConfig
---@field cards CardConfig

config.defaults = {
    dealer = {
        name = "Robodealer",
        reward = 0,
    },
    cards = {
        ace_value = 11,
    },
}

function config.load()
    local file = fs.open("config.toml", "r")
    if not file then
        print("config.toml not found, creating default config")
        file = fs.open("config.toml", "w")
        if not file then
            error("Could not create config.toml")
        end
        local default_config = toml.encode(config.defaults)
        file.write(default_config)
        file.close()
        error("Default config created. Please edit config.toml and run again.")
    end

    local data = file.readAll()
    file.close()

    local parsed_data, err = toml.parse(data)
    if err then
        error("Could not parse config.toml: " .. err)
    end

    expect(1, parsed_data)

    for key, value in pairs(config.defaults) do
        if parsed_data[key] == nil then
            parsed_data[key] = value
        end
    end

    -- Validate data types
    expect(1, parsed_data.dealer, "table")
    expect(2, parsed_data.dealer.name, "string")
    expect(3, parsed_data.dealer.reward, "number")
    expect(4, parsed_data.cards, "table")
    expect(5, parsed_data.cards.ace_value, "number")

    return parsed_data
end

function config.save(config)
    local file = fs.open("config.toml", "w")
    if not file then
        error("Could not open config.toml for writing")
    end

    local data = toml.encode(config)
    file.write(data)
    file.close()
end
