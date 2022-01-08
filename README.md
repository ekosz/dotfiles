# Eric's dotfiles

> Collection of dot files to take to other computers

## Installation

```sh
./bootstrap.sh
```

**Flags**
- `-f|--force` - Skips the warning about overriding files
- `-o|--only <files|brew>` - Only do a certain section of the install

## Notes

At the time of this writing, libraries are still upgrading to with with arm64
architectures. Because of that the follow libraries/applications need to be
installed manually:

- Alacritty - Need to make install locally
- yabai - Need to follow [these instructions][instructions] to get version 4

[instructions]: https://github.com/koekeishiya/yabai/wiki/Installing-yabai-(from-HEAD)
