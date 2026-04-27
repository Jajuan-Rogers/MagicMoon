local const = {}

const.SCREEN_WIDTH, const.SCREEN_HEIGHT = love.window.getDesktopDimensions()
const.HAND_CARD_ORIGIN_X = const.SCREEN_WIDTH / 2
const.HAND_CARD_ORIGIN_Y = const.SCREEN_WIDTH / 4
const.HAND_CARD_WIDTH = 200
const.HAND_CARD_OFFSET_X = const.HAND_CARD_ORIGIN_X + (const.HAND_CARD_WIDTH * 0.60)
const.HAND_CARD_OFFSET_Y = const.HAND_CARD_ORIGIN_Y + (const.HAND_CARD_WIDTH * 0.60)
const.HAND_CARD_X = const.HAND_CARD_ORIGIN_X
const.HAND_CARD_Y = const.HAND_CARD_ORIGIN_Y
const.HAND_CARD_ZOOM_WIDTH = const.HAND_CARD_WIDTH * 1.5
const.HAND_CARD_HEIGHT = const.HAND_CARD_WIDTH * (3.5 / 2.5) -- Results in 280
const.HAND_CARD_ZOOM_HEIGHT = const.HAND_CARD_HEIGHT * 1.5
const.HAND_CARD_ZOOM_X = (const.HAND_CARD_WIDTH * 0.1)
const.HAND_CARD_ZOOM_Y = (const.HAND_CARD_HEIGHT * 0.1) - 160

---color constants

return const
