declare -g __smartinput_rules=(
  "'"
  "\""
  '`'
  '()'
  '[]'
  '{}'
)

function __smartinput:widget:input_left_bracket {
  if [[ "$LBUFFER[-1]" == '\' ]]; then
    # Support Escape "\"
    :
  else
    local rule
    for rule in $__smartinput_rules; do
      if [[ $#rule == 2 && "$rule[1]" == "$KEYS" ]]; then
        RBUFFER="$rule[2]$RBUFFER"
        break
      fi
    done
  fi
  zle self-insert
}

function __smartinput:widget:input_right_bracket {
  local left right
  if [[ "$RBUFFER[1]" == "$KEYS" ]]; then
    # [xxxxxx|]<right bracket key>
    zle forward-char
    return
  fi
  zle self-insert
}

function __smartinput:widget:input_quote {
  if [[ "$LBUFFER[-1]" == '\' ]]; then
    # Support Escape "\"
    :
  elif [[ "$RBUFFER[1]" == "$KEYS" ]]; then
    # 'xxxxxx|'<quote key>
    zle forward-char
    return
  elif [[ "$KEYS" == "'" && "'$LBUFFER[-1]" =~ '\w' ]]; then
    # Support English "someone's"
    :
  else
    RBUFFER="$KEYS$RBUFFER"
  fi
  zle self-insert
}

function __smartinput:widget:backward_delete_char {
  local rule left right
  for rule in $__smartinput_rules; do
    if [[ $#rule == 1 ]]; then
      left="$rule"
      right="$rule"
    elif [[ $#rule == 2 ]]; then
      left="$rule[1]"
      right="$rule[2]"
    else
      # Not Support rule
      continue
    fi

    # [|]<BS>
    if [[ "$LBUFFER[-1]" == "$left" && "$RBUFFER[1]" == "$right" ]]; then
      zle backward-delete-char
      zle delete-char
      return
    fi

    # []|<BS>
    if [[ "$LBUFFER[-2,-1]" == "$left$right" ]]; then
      zle backward-delete-char
      zle backward-delete-char
      return
    fi
  done

  zle backward-delete-char
}

() {
  zle -N __smartinput:widget:input_quote
  zle -N __smartinput:widget:input_left_bracket
  zle -N __smartinput:widget:input_right_bracket
  local rule
  for rule in $__smartinput_rules; do
    if [[ $#rule == 1 ]]; then
      # quote
      bindkey "$rule" __smartinput:widget:input_quote
    elif [[ $#rule == 2 ]]; then
      # brackets
      bindkey "$rule[1]" __smartinput:widget:input_left_bracket
      bindkey "$rule[2]" __smartinput:widget:input_right_bracket
    fi
  done

  zle -N __smartinput:widget:backward_delete_char
  bindkey "^H" __smartinput:widget:backward_delete_char
  bindkey "^?" __smartinput:widget:backward_delete_char
}
