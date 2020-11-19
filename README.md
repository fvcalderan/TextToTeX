# TextToTeX
```
 _____          _  _____     _____    __  __
/__   \_____  _| |/__   \___/__   \___\ \/ /
  / /\/ _ \ \/ / __|/ /\/ _ \ / /\/ _ \\  / 
 / / |  __/>  <| |_/ / | (_) / / |  __//  \ 
 \/   \___/_/\_\\__\/   \___/\/   \___/_/\_\
```

This program takes a TeX String as input and creates an image with compiled
LaTeX written. Useful for running as a background script for a graphical
program or anything else.

### Dependencies

- `bash`
- `texlive`
- `imagemagick`
- `ghostscript`
- `xclip`

_Note:_ Instead of `bash`, any other shell that can run POSIX compliant code
should be fine.

### Usage
```
Convert string to image with compiled LaTeX written

Mandatory flags:
    -t: text (in LaTeX format) to be printed.

Optional flags:
    -c: copy to clipboard instead of saving it.
    -h: show this help message.
    -l: show license.
    -o: output name.
    -v: verbose output.

Example:
    ./TextToTex.sh -o \"equation.png\" -t \"\\\\Delta = b^2 -4ac\"
```

### License
```
BSD 3-Clause License
Copyright (c) 2020, Felipe V. Calderan
All rights reserved.
See the full license inside LICENSE.txt file
```
