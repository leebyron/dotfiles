/**
 * API for building Karabiner config files.
 */


exports.remap = (from, ...to) => ({ from, to })

exports.rule = (description, ...manipulators) => ({
  description,
  manipulators,
})

exports.manip = (description, props) => (
  'type' in props || (props.type = 'basic'),
  !('to' in props && !Array.isArray(props.to)) || (props.to = [props.to]),
  {
    description,
    ...props,
  }
)

exports.key = (key_code, props) => ({ key_code, ...props })

exports.setVar = (name, value) => ({ set_variable: { name, value } })

exports.ifVar = (name, value) => ({ type: 'variable_if', name, value })

exports.fingers = value => [
  {
    name: 'multitouch_extension_finger_count_total',
    type: 'variable_if',
    value,
  },
]

exports.profile = (name, ...rules) => ({
  name,
  simple_modifications: rules.filter(rule => 'from' in rule),
  complex_modifications: {
    parameters: {
      'basic.simultaneous_threshold_milliseconds': 50,
      'basic.to_delayed_action_delay_milliseconds': 500,
      'basic.to_if_alone_timeout_milliseconds': 250,
      'basic.to_if_held_down_threshold_milliseconds': 500,
      'mouse_motion_to_scroll.speed': 100,
    },
    rules: rules.filter(rule => 'manipulators' in rule),
  },
  devices: [],
  fn_function_keys: [
    {
      from: {
        key_code: 'f1',
      },
      to: [
        {
          consumer_key_code: 'display_brightness_decrement',
        },
      ],
    },
    {
      from: {
        key_code: 'f2',
      },
      to: [
        {
          consumer_key_code: 'display_brightness_increment',
        },
      ],
    },
    {
      from: {
        key_code: 'f3',
      },
      to: [
        {
          apple_vendor_keyboard_key_code: 'mission_control',
        },
      ],
    },
    {
      from: {
        key_code: 'f4',
      },
      to: [
        {
          apple_vendor_keyboard_key_code: 'spotlight',
        },
      ],
    },
    {
      from: {
        key_code: 'f5',
      },
      to: [
        {
          "apple_vendor_top_case_key_code": "illumination_down"
        },
      ],
    },
    {
      from: {
        key_code: 'f6',
      },
      to: [
        {
          "apple_vendor_top_case_key_code": "illumination_up"
        },
      ],
    },
    {
      from: {
        key_code: 'f7',
      },
      to: [
        {
          consumer_key_code: 'rewind',
        },
      ],
    },
    {
      from: {
        key_code: 'f8',
      },
      to: [
        {
          consumer_key_code: 'play_or_pause',
        },
      ],
    },
    {
      from: {
        key_code: 'f9',
      },
      to: [
        {
          consumer_key_code: 'fast_forward',
        },
      ],
    },
    {
      from: {
        key_code: 'f10',
      },
      to: [
        {
          consumer_key_code: 'mute',
        },
      ],
    },
    {
      from: {
        key_code: 'f11',
      },
      to: [
        {
          consumer_key_code: 'volume_decrement',
        },
      ],
    },
    {
      from: {
        key_code: 'f12',
      },
      to: [
        {
          consumer_key_code: 'volume_increment',
        },
      ],
    },
  ],
  parameters: {
    delay_milliseconds_before_open_device: 1000,
  },
  selected: false,
  simple_modifications: rules.filter(rule => !('manipulators' in rule)),
  virtual_hid_keyboard: {
    country_code: 0,
    indicate_sticky_modifier_keys_state: true,
    mouse_key_xy_scale: 100,
  },
})

exports.karabiner = (...profiles) => (
  (profiles[0].selected = true),
  require('fs').writeFileSync(
    process.env.HOME + '/.config/karabiner/karabiner.json',
    JSON.stringify(
      {
        GENERATEDBY: process.argv.join(' '),
        global: {
          check_for_updates_on_startup: true,
          show_in_menu_bar: false,
          show_profile_name_in_menu_bar: false,
        },
        profiles,
      },
      null,
      4
    ),
    'utf8'
  )
)
