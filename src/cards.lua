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
    Images of cards are stored in a table, with the card name as the key.
    The card name is a string in the format "rank_suit", where rank is
    one of "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K", or "A",
    and suit is one of "hearts", "diamonds", "clubs", or "spades".
]]

local TR = 1
local fl = 0

local cards = {}
local except = require("cc.expect").expect

---@class Card
---@field index number
---@field colour number

cards.small = {
    --- One
    {
        { TR, TR, TR, TR, TR, TR, TR, }, -- 1
        { TR, fl, fl, fl, TR, TR, TR, }, -- 0
        { TR, TR, TR, fl, TR, TR, TR, }, -- 1
        { TR, TR, TR, fl, TR, TR, TR, }, -- 0
        { TR, TR, TR, fl, TR, TR, TR, }, -- 1
        { TR, TR, TR, fl, TR, TR, TR, }, -- 0
        { TR, TR, TR, fl, TR, TR, TR, }, -- 1
        { TR, TR, TR, fl, fl, fl, TR, }, -- 0
        { TR, TR, TR, TR, TR, TR, TR, }, -- 1
    },
    --- Two
    {
        { TR, TR, TR, TR, TR, TR, TR, }, -- 1
        { TR, fl, fl, fl, TR, TR, TR, }, -- 0
        { TR, TR, TR, fl, TR, TR, TR, }, -- 1
        { TR, TR, TR, fl, fl, TR, TR, }, -- 0
        { TR, TR, TR, TR, TR, TR, TR, }, -- 1
        { TR, TR, fl, fl, TR, TR, TR, }, -- 0
        { TR, TR, TR, fl, TR, TR, TR, }, -- 1
        { TR, TR, TR, fl, fl, fl, TR, }, -- 0
        { TR, TR, TR, TR, TR, TR, TR, }, -- 1
    },
    --- Three
    {
        { TR, TR, TR, TR, TR, TR, TR, }, -- 1
        { TR, fl, fl, fl, TR, TR, TR, }, -- 0
        { TR, TR, TR, fl, TR, TR, TR, }, -- 1
        { TR, TR, TR, TR, TR, TR, TR, }, -- 0
        { TR, fl, fl, fl, fl, fl, TR, }, -- 1
        { TR, TR, TR, TR, TR, TR, TR, }, -- 0
        { TR, TR, TR, fl, TR, TR, TR, }, -- 1
        { TR, TR, TR, fl, fl, fl, TR, }, -- 0
        { TR, TR, TR, TR, TR, TR, TR, }, -- 1
    },
    --- Four
    {
        { TR, TR, TR, TR, TR, TR, TR, }, -- 1
        { TR, fl, fl, TR, fl, fl, TR, }, -- 0
        { TR, fl, TR, TR, TR, fl, TR, }, -- 1
        { TR, TR, TR, TR, TR, TR, TR, }, -- 0
        { TR, TR, TR, TR, TR, TR, TR, }, -- 1
        { TR, TR, TR, TR, TR, TR, TR, }, -- 0
        { TR, fl, TR, TR, TR, fl, TR, }, -- 1
        { TR, fl, fl, TR, fl, fl, TR, }, -- 0
        { TR, TR, TR, TR, TR, TR, TR, }, -- 1
    },
    --- Five
    {
        { TR, TR, TR, TR, TR, TR, TR, }, -- 1
        { TR, fl, fl, TR, fl, fl, TR, }, -- 0
        { TR, fl, TR, TR, TR, fl, TR, }, -- 1
        { TR, TR, TR, fl, TR, TR, TR, }, -- 0
        { TR, fl, fl, fl, fl, fl, TR, }, -- 1
        { TR, TR, TR, fl, TR, TR, TR, }, -- 0
        { TR, fl, TR, TR, TR, fl, TR, }, -- 1
        { TR, fl, fl, TR, fl, fl, TR, }, -- 0
        { TR, TR, TR, TR, TR, TR, TR, }, -- 1
    },
    --- Six
    {
        { TR, TR, TR, TR, TR, TR, TR, }, -- 1
        { TR, fl, fl, TR, fl, fl, TR, }, -- 0
        { TR, fl, TR, TR, TR, fl, TR, }, -- 1
        { TR, TR, TR, TR, TR, TR, TR, }, -- 0
        { TR, fl, fl, TR, fl, fl, TR, }, -- 1
        { TR, TR, TR, TR, TR, TR, TR, }, -- 0
        { TR, fl, TR, TR, TR, fl, TR, }, -- 1
        { TR, fl, fl, TR, fl, fl, TR, }, -- 0
        { TR, TR, TR, TR, TR, TR, TR, }, -- 1
    },
    --- Seven
    {
        { TR, TR, TR, TR, TR, TR, TR, }, -- 1
        { TR, fl, fl, TR, fl, fl, TR, }, -- 0
        { TR, TR, TR, TR, TR, TR, TR, }, -- 1
        { TR, fl, TR, fl, TR, fl, TR, }, -- 0
        { TR, fl, TR, fl, TR, fl, TR, }, -- 1
        { TR, fl, TR, fl, TR, fl, TR, }, -- 0
        { TR, TR, TR, TR, TR, TR, TR, }, -- 1
        { TR, fl, fl, TR, fl, fl, TR, }, -- 0
        { TR, TR, TR, TR, TR, TR, TR, }, -- 1
    },
    --- Eight
    {
        { TR, TR, TR, TR, TR, TR, TR, }, -- 1
        { TR, fl, fl, TR, fl, fl, TR, }, -- 0
        { TR, TR, TR, TR, TR, TR, TR, }, -- 1
        { TR, fl, TR, TR, TR, fl, TR, }, -- 0
        { TR, TR, TR, TR, TR, TR, TR, }, -- 1
        { TR, fl, TR, TR, TR, fl, TR, }, -- 0
        { TR, TR, TR, TR, TR, TR, TR, }, -- 1
        { TR, fl, fl, TR, fl, fl, TR, }, -- 0
        { TR, TR, TR, TR, TR, TR, TR, }, -- 1
    },
    -- Nine
    {
        { TR, TR, TR, TR, TR, TR, TR, }, -- 1
        { TR, fl, fl, TR, fl, fl, TR, }, -- 0
        { TR, TR, TR, TR, TR, TR, TR, }, -- 1
        { TR, fl, TR, fl, TR, fl, TR, }, -- 0
        { TR, TR, TR, fl, TR, TR, TR, }, -- 1
        { TR, fl, TR, fl, TR, fl, TR, }, -- 0
        { TR, TR, TR, TR, TR, TR, TR, }, -- 1
        { TR, fl, fl, TR, fl, fl, TR, }, -- 0
        { TR, TR, TR, TR, TR, TR, TR, }, -- 1
    },
    -- Ten
    {
        { TR, TR, TR, TR, TR, TR, TR, }, -- 1
        { TR, fl, fl, TR, fl, fl, TR, }, -- 0
        { TR, TR, TR, TR, TR, TR, TR, }, -- 1
        { TR, fl, TR, fl, TR, fl, TR, }, -- 0
        { TR, TR, TR, TR, TR, TR, TR, }, -- 1
        { TR, fl, TR, fl, TR, fl, TR, }, -- 0
        { TR, TR, TR, TR, TR, TR, TR, }, -- 1
        { TR, fl, fl, TR, fl, fl, TR, }, -- 0
        { TR, TR, TR, TR, TR, TR, TR, }, -- 1
    },
    --- Jester
    {
        { TR, TR, TR, TR, TR, TR, TR, }, -- 1
        { fl, fl, fl, TR, fl, fl, fl, }, -- 0
        { fl, fl, fl, TR, fl, fl, fl, }, -- 1
        { fl, fl, fl, TR, fl, fl, fl, }, -- 0
        { fl, fl, fl, TR, fl, fl, fl, }, -- 1
        { fl, fl, fl, TR, fl, fl, fl, }, -- 0
        { TR, fl, fl, TR, fl, fl, TR, }, -- 1
        { TR, TR, fl, TR, fl, TR, TR, }, -- 0
        { TR, fl, fl, TR, fl, fl, TR, }, -- 1
    },
    --- Queen
    {
        { TR, TR, TR, TR, TR, TR, TR, }, -- 1
        { TR, fl, fl, fl, fl, fl, TR, }, -- 0
        { TR, fl, TR, TR, TR, fl, TR, }, -- 1
        { TR, fl, TR, TR, TR, fl, TR, }, -- 0
        { TR, fl, TR, TR, TR, fl, TR, }, -- 1
        { TR, fl, TR, TR, TR, fl, TR, }, -- 0
        { TR, fl, fl, fl, fl, fl, TR, }, -- 1
        { TR, fl, fl, TR, fl, fl, TR, }, -- 0
        { TR, TR, TR, fl, TR, TR, TR, }, -- 1
    },
    --- King
    {
        { TR, TR, TR, TR, TR, TR, TR, }, -- 1
        { TR, TR, fl, fl, TR, fl, TR, }, -- 0
        { TR, fl, TR, fl, fl, fl, TR, }, -- 1
        { TR, fl, fl, TR, fl, fl, TR, }, -- 0
        { TR, fl, fl, TR, fl, fl, TR, }, -- 1
        { TR, fl, TR, fl, fl, fl, TR, }, -- 0
        { TR, fl, fl, fl, TR, fl, TR, }, -- 1
        { TR, fl, fl, fl, TR, fl, TR, }, -- 0
        { TR, TR, TR, TR, TR, TR, TR, }, -- 1
    },
}

cards.names = {
    "Ace",
    "Two",
    "Three",
    "Four",
    "Five",
    "Six",
    "Seven",
    "Eight",
    "Nine",
    "Ten",
    "Jester",
    "Queen",
    "King"
}

cards._scaledCache = {}

function cards.getImage(idx)
    except(1, idx, "number")
    if idx < 1 or idx > #cards.small then
        error("Invalid card index: " .. tostring(idx))
    end
    return cards.small[idx]
end

function cards.getCardName(idx)
    except(1, idx, "number")
    if idx < 1 or idx > #cards.names then
        error("Invalid card index: " .. tostring(idx))
    end
    return cards.names[idx]
end

function cards.getImageScaled(idx, scale)
    except(1, idx, "number")
    except(2, scale, "number")
    if scale < 1 then
        error("Scale factor must be at least 1")
    end
    if idx < 1 or idx > #cards.small then
        error("Invalid card index: " .. tostring(idx))
    end

    local key = idx .. "x" .. scale
    if cards._scaledCache[key] then
        return cards._scaledCache[key]
    end

    local image = cards.small[idx]
    local scaledImage = {}

    -- for each original row
    for i = 1, #image do
        local row       = image[i]
        local scaledRow = {}

        -- horizontal scaling
        for j = 1, #row do
            local value = row[j]
            for k = 1, scale do
                scaledRow[(j - 1) * scale + k] = value
            end
        end

        -- vertical scaling: repeat each scaledRow 'scale' times
        for v = 1, scale do
            scaledImage[#scaledImage + 1] = scaledRow
        end
    end

    cards._scaledCache[key] = scaledImage
    return scaledImage
end

-- Assumes 'colors' API is available, e.g., via local colors = require("colors")
-- Assumes TR = 1 and fl = 0 are defined as before

function cards.colourImage(image, colour)
    except(1, image, "table")
    except(2, colour, "number")

    local colouredImage = {}
    for i = 1, #image do
        local row = image[i]
        local colouredRow = {}
        for j = 1, #row do
            if row[j] == TR then              -- Check if the pixel value is TR (1)
                colouredRow[j] = colour       -- Use the provided colour for TR pixels
            else                              -- Otherwise (pixel value is fl (0))
                colouredRow[j] = colors.black -- Use black for fl pixels
            end
        end
        colouredImage[i] = colouredRow
    end

    return colouredImage
end

return cards
