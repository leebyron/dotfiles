/**
 * Karabiner config source of truth
 */

const {
  rule,
  manip,
  key,
  oneKey,
  fingerCount,
  profile,
  karabiner,
} = require("./api");

karabiner(
  profile(
    "Pinkbaby",
    rule(
      "Pinkies",
      manip("capslock = esc(click) | control(hold)", {
        from: key("caps_lock", { modifiers: { optional: ["any"] } }),
        to: oneKey("right_control", { lazy: true }),
        to_if_alone: oneKey("escape"),
      }),
      manip("return = return(click) | control(hold)", {
        from: key("return_or_enter", { modifiers: { optional: ["any"] } }),
        to: oneKey("left_control", { lazy: true }),
        to_if_alone: oneKey("return_or_enter"),
      }),
      manip("double shift = capslock", {
        from: {
          modifiers: { optional: ["any"] },
          simultaneous: [key("left_shift"), key("right_shift")],
        },
        to: oneKey("caps_lock"),
      })
    ),
    rule(
      "Control Brackets = Parens",
      manip("control+open_bracket = open_paren", {
        from: key("open_bracket", { modifiers: { mandatory: ["control"] } }),
        to: oneKey("9", { modifiers: ["right_shift"] }),
      }),
      manip("control+close_bracket = open_paren", {
        from: key("close_bracket", { modifiers: { mandatory: ["control"] } }),
        to: oneKey("0", { modifiers: ["right_shift"] }),
      })
    ),
    rule(
      "Multitouch Vi Arrows",
      manip("finger h = left", {
        conditions: fingerCount(1),
        from: key("h", { modifiers: { optional: ["any"] } }),
        to: oneKey("left_arrow"),
      }),
      manip("finger j = down", {
        conditions: fingerCount(1),
        from: key("j", { modifiers: { optional: ["any"] } }),
        to: oneKey("down_arrow"),
      }),
      manip("finger k = up", {
        conditions: fingerCount(1),
        from: key("k", { modifiers: { optional: ["any"] } }),
        to: oneKey("up_arrow"),
      }),
      manip("finger l = right", {
        conditions: fingerCount(1),
        from: key("l", { modifiers: { optional: ["any"] } }),
        to: oneKey("right_arrow"),
      })
    )
  ),
  profile("Vanilla")
);
