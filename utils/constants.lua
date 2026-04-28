local const = {}

const.SCREEN_WIDTH, const.SCREEN_HEIGHT = love.window.getDesktopDimensions()
const.HAND_CARD_WIDTH = 200
const.HAND_CARD_HEIGHT = const.HAND_CARD_WIDTH * (3.5 / 2.5) -- Results in 280
const.HAND_CARD_ORIGIN_X = const.SCREEN_WIDTH / 2
const.HAND_CARD_ORIGIN_Y = const.SCREEN_HEIGHT - (const.HAND_CARD_HEIGHT / 3)
const.HAND_CARD_OFFSET_X = const.HAND_CARD_ORIGIN_X + (const.HAND_CARD_WIDTH * 0.60)
const.HAND_CARD_OFFSET_Y = const.HAND_CARD_ORIGIN_Y + (const.HAND_CARD_WIDTH * 0.60)
const.HAND_CARD_X = const.HAND_CARD_ORIGIN_X
const.HAND_CARD_Y = const.HAND_CARD_ORIGIN_Y
const.HAND_CARD_ZOOM_WIDTH = const.HAND_CARD_WIDTH * 3.5
const.HAND_CARD_ZOOM_HEIGHT = const.HAND_CARD_HEIGHT * 3.5
-- const.HAND_CARD_ZOOM_X = const.HAND_CARD_ORIGIN_X + (const.HAND_CARD_WIDTH * 0.1)
const.HAND_CARD_ZOOM_Y = const.HAND_CARD_ORIGIN_Y  - 860
const.HAND_ZOOM_LERP_TARGET = const.HAND_CARD_ORIGIN_Y - 250

---game board pos
local gb_x = math.ceil(const.SCREEN_WIDTH / 4.46)
local gb_y = math.ceil(const.SCREEN_HEIGHT / 100)
const.GAMEBOARD_WIDTH = const.SCREEN_WIDTH - gb_x
const.GAMEBOARD_HEIGHT = const.SCREEN_HEIGHT - gb_y
const.GAMEBOARD_X = gb_x
const.GAMEBOARD_Y = gb_y

---color constants

return const
