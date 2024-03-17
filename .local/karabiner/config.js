/**
 * Karabiner config source of truth
 *
 * Run: node ~/.local/karabiner/config.js
 * Vim: :autocmd BufWritePost <buffer> !node <afile>
 */

const {
  remap,
  rule,
  manip,
  key,
  setVar,
  ifVar,
  fingers,
  profile,
  karabiner,
} = require('./api')

function fnKey(from, to, ...mods) {
  return manip(`Fn+${from} = ${to}`, {
    from: key(from, { modifiers: { mandatory: ['fn'], optional: ['any'] } }),
    to: key(to, ...mods),
  })
}

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
    'HHKB Trainer',
    remap(key('backslash'), key('delete_or_backspace')),
    // remap(key('delete_or_backspace'), key('backslash')),
    remap(key('caps_lock'), key('left_control')),
    rule(
      'Slash moved trainer',
      manip('disable delete', {
        from: key('delete_or_backspace', { modifiers: { optional: ['any'] } }),
        to: { shell_command: 'osascript -e "beep 1"' },
        conditions: [{ type: 'event_changed_if', value: false }],
      }),
      manip('command backslash', {
        from: key('slash', {
          modifiers: { mandatory: ['control'], optional: ['any'] },
        }),
        to: key('backslash'),
      })
    ),
    rule(
      'Lazy fn',
      manip('', {
        from: key('fn', { modifiers: { optional: ['any'] } }),
        to: key('fn', { lazy: true }),
        to_if_alone: [key('fn')],
      })
    ),
    rule(
      'HHKB Fn keys',
      fnKey('tab', 'caps_lock'),
      fnKey('open_bracket', 'up_arrow'),
      fnKey('slash', 'down_arrow'),
      fnKey('semicolon', 'left_arrow'),
      fnKey('quote', 'right_arrow'),
      fnKey('k', 'home'),
      fnKey('comma', 'end'),
      fnKey('l', 'page_up'),
      fnKey('period', 'page_down'),
      fnKey('h', 'keypad_asterisk'),
      fnKey('j', 'keypad_slash'),
      fnKey('n', 'keypad_plus'),
      fnKey('m', 'keypad_hyphen')
    )
  ),

  profile(
    'HHKB',
    remap(key('backslash'), key('delete_or_backspace')),
    remap(key('delete_or_backspace'), key('backslash')),
    remap(key('caps_lock'), key('left_control')),
    rule(
      'Lazy fn',
      manip('', {
        from: key('fn', { modifiers: { optional: ['any'] } }),
        to: key('fn', { lazy: true }),
        to_if_alone: [key('fn')],
      })
    ),
    rule(
      'HHKB Fn keys',
      fnKey('tab', 'caps_lock'),
      fnKey('open_bracket', 'up_arrow'),
      fnKey('slash', 'down_arrow'),
      fnKey('semicolon', 'left_arrow'),
      fnKey('quote', 'right_arrow'),
      fnKey('k', 'home'),
      fnKey('comma', 'end'),
      fnKey('l', 'page_up'),
      fnKey('period', 'page_down'),
      fnKey('h', 'keypad_asterisk'),
      fnKey('j', 'keypad_slash'),
      fnKey('n', 'keypad_plus'),
      fnKey('m', 'keypad_hyphen')
    )
  ),

  profile(
    'Pinkbaby',
    rule(
      'HHKB Delete',
      manip('slash = delete', {
        from: key('backslash', { modifiers: { optional: ['any'] } }),
        to: key('delete_or_backspace'),
      }),
      manip('slash = delete', {
        from: key('delete_or_backspace', { modifiers: { optional: ['any'] } }),
        to: key('backslash'),
      })
    ),
    rule(
      'caps_lock = esc(tap) | control(hold) | caps_lock(double tap)',
      manip('double tap', {
        conditions: [ifVar('double_caps', 1)],
        from: key('caps_lock', { modifiers: { optional: ['caps_lock'] } }),
        to: [setVar('double_caps', 0), key('caps_lock')],
      }),
      manip('control, set double tap state, or delayed escape', {
        parameters: {
          'basic.to_if_held_down_threshold_milliseconds': 600,
          'basic.to_delayed_action_delay_milliseconds': 600,
        },
        from: key('caps_lock', { modifiers: { optional: ['caps_lock'] } }),
        to: [setVar('double_caps', 1), key('left_control', { lazy: true })],
        to_if_held_down: [
          setVar('double_caps', 0),
          key('left_control', { halt: true }),
        ],
        // to_after_key_up: [
        //   setVar('double_caps', 1)
        // ],
        to_delayed_action: {
          to_if_invoked: [setVar('double_caps', 0), key('escape')],
          to_if_canceled: [setVar('double_caps', 0), key('escape')],
        },
      }),
      manip('if other mods are pressed, no double tap behavior', {
        from: key('caps_lock', { modifiers: { optional: ['any'] } }),
        to: [key('left_control', { lazy: true })],
        to_if_alone: [key('escape')],
      })
    ),
    rule(
      'Pinkies',
      // manip('capslock = esc(click) | control(hold)', {
      //   from: key('caps_lock', { modifiers: { optional: ['any'] } }),
      //   to: [key('left_control', { lazy: true })],
      //   to_if_alone: [key('escape')],
      // }),
      manip('return = return(click) | control(hold)', {
        from: key('return_or_enter', { modifiers: { optional: ['any'] } }),
        to: [key('right_control', { lazy: true })],
        to_if_alone: [key('return_or_enter')],
      }),
      manip('double shift = capslock', {
        from: {
          modifiers: { optional: ['any'] },
          simultaneous: [key('left_shift'), key('right_shift')],
        },
        to: [key('caps_lock')],
      })
    ),
    rule(
      'Control Brackets = Parens',
      manip('control+open_bracket = open_paren', {
        from: key('open_bracket', { modifiers: { mandatory: ['control'] } }),
        to: [key('9', { modifiers: ['right_shift'] })],
      }),
      manip('control+close_bracket = open_paren', {
        from: key('close_bracket', { modifiers: { mandatory: ['control'] } }),
        to: [key('0', { modifiers: ['right_shift'] })],
      })
    ),
    rule(
      'Pasteboards',
      manip('next pasteboard', {
        from: key('right_shift', {
          modifiers: { mandatory: ['left_shift'] },
        }),
        to_if_alone: [{ shell_command: '~/.local/bin/pbshift', halt: true }],
      }),
      manip('prev pasteboard', {
        from: key('left_shift', {
          modifiers: { mandatory: ['right_shift'] },
        }),
        to_if_alone: [{ shell_command: '~/.local/bin/pbshift -p', halt: true }],
      })
    ),
    rule(
      'Finger Vim Arrows',
      manip('finger h = left', {
        conditions: fingers(1),
        from: key('h', { modifiers: { optional: ['any'] } }),
        to: [key('left_arrow')],
      }),
      manip('finger j = down', {
        conditions: fingers(1),
        from: key('j', { modifiers: { optional: ['any'] } }),
        to: [key('down_arrow')],
      }),
      manip('finger k = up', {
        conditions: fingers(1),
        from: key('k', { modifiers: { optional: ['any'] } }),
        to: [key('up_arrow')],
      }),
      manip('finger l = right', {
        conditions: fingers(1),
        from: key('l', { modifiers: { optional: ['any'] } }),
        to: [key('right_arrow')],
      })
    )
  ),
  profile('Vanilla')
)
