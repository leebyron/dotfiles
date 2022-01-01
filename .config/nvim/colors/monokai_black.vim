lua << EOF
local palette = require('monokai').classic
palette.name = 'monokai_black'
palette.base1 = '#000000'
palette.base2 = '#000000'
require('monokai').setup { palette = palette }
EOF

