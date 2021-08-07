declare -gA __smartinput_rules=(
  '(' ')'
  '[' ']'
  "\"" "\""
  "'" "'"
  '`' '`'
)

function __smartinput:widget:main {
  if [[ "${LBUFFER[-1]}" != '\' ]]; then
    RBUFFER="${__smartinput_rules[$KEYS]}$RBUFFER"
  fi
  zle self-insert
}

() {
  zle -N __smartinput:widget:main
  local key
  for key in ${(k)__smartinput_rules}; do
    bindkey "$key" __smartinput:widget:main
  done
}

