/**
 * Karabiner config source of truth
 *
 * Run: node ~/.local/karabiner/config.js
 * Vim: :autocmd BufWritePost <buffer> !node <afile>
 */

const { rule, manip, key, fingers, profile, karabiner } = require("./api");

karabiner(
  profile(
    "Werk",
    manip("swap backslash", {
      from: key("backslash"),
      to: [key("delete_or_backspace")],
    }),
    manip("swap backspace", {
      from: key("delete_or_backspace"),
      to: [key("backslash")],
    }),
    rule(
      "Pinkies",
      manip("capslock = esc(click) | control(hold)", {
        from: key("caps_lock", { modifiers: { optional: ["any"] } }),
        to: [key("right_control", { lazy: true })],
        to_if_alone: [key("escape")],
      }),
      // manip("return = return(click) | control(hold)", {
      //   from: key("return_or_enter", { modifiers: { optional: ["any"] } }),
      //   to: [key("right_control", { lazy: true })],
      //   to_if_alone: [key("return_or_enter")],
      // }),
      manip("double shift = capslock", {
        from: {
          modifiers: { optional: ["any"] },
          simultaneous: [key("left_shift"), key("right_shift")],
        },
        to: [key("caps_lock")],
      })
    ),
    rule(
      "Control Brackets = Parens",
      manip("control+open_bracket = open_paren", {
        from: key("open_bracket", { modifiers: { mandatory: ["control"] } }),
        to: [key("9", { modifiers: ["right_shift"] })],
      }),
      manip("control+close_bracket = open_paren", {
        from: key("close_bracket", { modifiers: { mandatory: ["control"] } }),
        to: [key("0", { modifiers: ["right_shift"] })],
      })
    ),
    // rule(
    //   "arrows bad habit!",
    //   manip("no up", { from: key("up_arrow"), to: [] }),
    //   manip("no down", { from: key("down_arrow"), to: [] }),
    //   manip("no left", { from: key("left_arrow"), to: [] }),
    //   manip("no right", { from: key("right_arrow"), to: [] })
    // ),
    rule(
      "Pinkie undo",
      manip("C+z = undo", {
        from: key("z", {
          modifiers: { mandatory: ["right_control"], optional: ["any"] },
        }),
        to: [key("z", { modifiers: ["command"] })],
      })
    ),
    rule(
      "Pinkie ijkl arrows",
      manip("C+i = up", {
        from: key("i", {
          modifiers: { mandatory: ["right_control"], optional: ["any"] },
        }),
        to: [key("up_arrow")],
      }),
      manip("C+j = left", {
        from: key("j", {
          modifiers: { mandatory: ["right_control"], optional: ["any"] },
        }),
        to: [key("left_arrow")],
      }),
      manip("C+k = down", {
        from: key("k", {
          modifiers: { mandatory: ["right_control"], optional: ["any"] },
        }),
        to: [key("down_arrow")],
      }),
      manip("C+l = right", {
        from: key("l", {
          modifiers: { mandatory: ["right_control"], optional: ["any"] },
        }),
        to: [key("right_arrow")],
      })
    ),
    rule(
      "Pinkie wasd arrows",
      manip("C+w = up", {
        from: key("w", {
          modifiers: { mandatory: ["right_control"], optional: ["any"] },
        }),
        to: [key("up_arrow")],
      }),
      manip("C+a = left", {
        from: key("a", {
          modifiers: { mandatory: ["right_control"], optional: ["any"] },
        }),
        to: [key("left_arrow")],
      }),
      manip("C+s = down", {
        from: key("s", {
          modifiers: { mandatory: ["right_control"], optional: ["any"] },
        }),
        to: [key("down_arrow")],
      }),
      manip("C+d = right", {
        from: key("d", {
          modifiers: { mandatory: ["right_control"], optional: ["any"] },
        }),
        to: [key("right_arrow")],
      })
    )
  ),
  profile(
    "Pinkbaby",
    rule(
      "Pinkies",
      manip("capslock = esc(click) | control(hold)", {
        from: key("caps_lock", { modifiers: { optional: ["any"] } }),
        to: [key("left_control", { lazy: true })],
        to_if_alone: [key("escape")],
      }),
      manip("return = return(click) | control(hold)", {
        from: key("return_or_enter", { modifiers: { optional: ["any"] } }),
        to: [key("right_control", { lazy: true })],
        to_if_alone: [key("return_or_enter")],
      }),
      manip("double shift = capslock", {
        from: {
          modifiers: { optional: ["any"] },
          simultaneous: [key("left_shift"), key("right_shift")],
        },
        to: [key("caps_lock")],
      })
    ),
    rule(
      "Control Brackets = Parens",
      manip("control+open_bracket = open_paren", {
        from: key("open_bracket", { modifiers: { mandatory: ["control"] } }),
        to: [key("9", { modifiers: ["right_shift"] })],
      }),
      manip("control+close_bracket = open_paren", {
        from: key("close_bracket", { modifiers: { mandatory: ["control"] } }),
        to: [key("0", { modifiers: ["right_shift"] })],
      })
    ),
    rule(
      "Pasteboards",
      manip("next pasteboard", {
        from: key("right_shift", {
          modifiers: { mandatory: ["left_shift"] },
        }),
        to_if_alone: [{ shell_command: "~/.local/bin/pbshift", halt: true }],
      }),
      manip("prev pasteboard", {
        from: key("left_shift", {
          modifiers: { mandatory: ["right_shift"] },
        }),
        to_if_alone: [{ shell_command: "~/.local/bin/pbshift -p", halt: true }],
      })
    ),
    rule(
      "Finger Vim Arrows",
      manip("finger h = left", {
        conditions: fingers(1),
        from: key("h", { modifiers: { optional: ["any"] } }),
        to: [key("left_arrow")],
      }),
      manip("finger j = down", {
        conditions: fingers(1),
        from: key("j", { modifiers: { optional: ["any"] } }),
        to: [key("down_arrow")],
      }),
      manip("finger k = up", {
        conditions: fingers(1),
        from: key("k", { modifiers: { optional: ["any"] } }),
        to: [key("up_arrow")],
      }),
      manip("finger l = right", {
        conditions: fingers(1),
        from: key("l", { modifiers: { optional: ["any"] } }),
        to: [key("right_arrow")],
      })
    )
  ),
  profile("Vanilla")
);
