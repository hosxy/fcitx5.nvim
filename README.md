# fcitx5.nvim

## Installation
+ packer:
```
use 'hosxy/fcitx5.nvim'
```

## Configuration
+ `input_method`
  + description: input method name 
  + type: string
  + value: `fcitx5` or `fcitx5_rime`
  + default: `fcitx5`
+ `disable_im`
  + description: disable input method after nvim start(if your default input method isn't Eng,maybe need this)
  + type: boolean
  + value: `true` or `false`
  + default: `false`




## Example
```
require("fcitx5").setup{
    input_method = "fcitx5",
    disable_im = false
}
```
