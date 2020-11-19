# BSD 3-Clause License
# Copyright (c) 2020, Felipe V. Calderan
# All rights reserved.
# See the full license inside LICENSE.txt file
#! /bin/sh

# Get optional flags
while getopts 'o:t:chvl' flag; do
  case "${flag}" in
    o) output_flag="${OPTARG}" ;;
    t) text_flag="${OPTARG}" ;;
    c) clip_flag=true ;;
    h) help_flag=true ;;
    v) verbose_flag=true ;;
    l) license_flag=true ;;
    *) echo "Unexpected option ${flag}"; exit 1 ;;
  esac
done

# Check for license flag. if set, display license text.
if [ -n "$license_flag" ]; then
    __license_text="    BSD 3-Clause License

    Copyright (c) 2020, Felipe V. Calderan
    All rights reserved.

    Redistribution and use in source and binary forms, with or without
    modification, are permitted provided that the following conditions are met:

    1. Redistributions of source code must retain the above copyright notice, this
       list of conditions and the following disclaimer.

    2. Redistributions in binary form must reproduce the above copyright notice,
    this list of conditions and the following disclaimer in the documentation
    and/or other materials provided with the distribution.

    3. Neither the name of the copyright holder nor the names of its
    contributors may be used to endorse or promote products derived from
    this software without specific prior written permission.

    THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS \"AS IS\"
    AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
    IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
    DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
    FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
    DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
    SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
    CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
    OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
    OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
    echo "$__license_text"
    exit 1
fi

# Check for help flag. If set, display help message.
if [ -n "$help_flag" ]; then
    __help_text="Convert string to image with compiled LaTeX written

Mandatory flags:
    -t: text (in LaTeX format) to be printed.

Optional flags:
    -c: copy to clipboard instead of saving it.
    -h: show this help message.
    -l: show license.
    -o: output name.
    -v: verbose output.

Example:
    ./TextToTex.sh -o \"equation.png\" -t \"\\\\Delta = b^2 -4ac\""
    echo "$__help_text"
    exit 1
fi

# Verify if the user has given a name to the output. If not, do it.
if [ -n "$output_flag" ]; then
    FILE_NAME=$output_flag
else
    FILE_NAME="output.png"
fi

# Verify if the user has given a text to print. If not, exit.
if [ -z "$text_flag" ]; then
    echo "Please specify with -t a text to be printed."
    exit 1
fi

# Generate super simple latex code with the equation
[ -n "$verbose_flag" ] && echo "Generating simple .tex file."
echo "\\documentclass{letter}" > temp_file_equation.tex
echo "\\begin{document}" >> temp_file_equation.tex
echo "\$\$ ${text_flag} \$\$" >> temp_file_equation.tex
echo "\\pagenumbering{gobble}" >> temp_file_equation.tex
echo "\\end{document}" >> temp_file_equation.tex

# Compile into pdf
[ -n "$verbose_flag" ] && echo "Compiling .tex file to PDF."
pdflatex temp_file_equation.tex > /dev/null

# Convert to image
[ -n "$verbose_flag" ] && echo "Converting PDF to image."
convert -trim -density 300 temp_file_equation.pdf -strip $FILE_NAME > /dev/null

# If -c is active, then copy image to clipboard and delete it
if [ -n "$clip_flag" ]; then
    [ -n "$verbose_flag" ] && echo "Copying to clipboard."
    xclip -se c -t image/png -i $FILE_NAME
    rm $FILE_NAME
fi

# Remove temporary files
[ -n "$verbose_flag" ] && echo "Removing temporary files."
rm temp_file_equation.*

# Done!
[ -n "$verbose_flag" ] && echo "Done!"
