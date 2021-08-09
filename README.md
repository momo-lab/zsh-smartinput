# zsh-smartinput
This is a zsh plugin to provided smart input.
When brackets/quotes are inputted, the corresponding brackets/quotes are automatically inputted.
Support character is ` () `, ` [] `, ` {} `, ` " `, ` ' ` and `` ` ``.

This plugin consulted [vim-smartinput](http://github.com/kana/vim-smartinput).

# Installation
### Using [zplug](https://github.com/b4b4r07/zplug)

```zsh
zplug "momo-lab/zsh-smartinput"
```

### Manually

Clone this repository somewhere (`~/.zsh-smartinput` for example) and source it in your `.zshrc`

```zsh
git clone https://github.com/momo-lab/zsh-smartinput.git
```

```zsh
source ~/.zsh-smartinput/smartinput.plugin.zsh
```

# For Example

This plugin provides the following rules
(note that "#" indicates the cursor position in the following examples):

Automatically complements the corresponding brackets/quotes:

| Before | Input  | After  |
|--------|--------|--------|
| #      | (      | (#)    |
| #      | [      | [#]    |
| #      | {      | {#}    |
| #      | "      | "#"    |
| #      | '      | '#'    |
| #      | \`     | \`#\`  |

Input right brackets/quotes to leave the block:

| Before | Input  | After  |
|--------|--------|--------|
| (#)    | )      | ()#    |
| (foo#) | )      | (foo)# |

Input the backspace key to remove the corresponding brackets/quotes:

| Before | Input  | After  |
|--------|--------|--------|
| (#)    | \<BS\> | #      |
| ()#    | \<BS\> | #      |

Care to escaping characters:

| Before | Input  | After  |
|--------|--------|--------|
| \\#    | (      | \\(#   |

Care to English words:

| Before | Input  | After  |
|--------|--------|--------|
| foo#   | 's     | foo's# |
