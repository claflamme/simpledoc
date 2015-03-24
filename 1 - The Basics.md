# The Basics

The goal is to make this as simple as possible. If you think any part of the process could be simplified, [let me know](https://github.com/claflamme/simpledoc/issues).

## Generating Docs

Just navigate to a directory in your terminal and run `simpledoc`.

The program will collect all markdown files in a directory and turn them in to a nice HTML file with permalinks and soothing colours.

You can keep everything in a single file if you'd like, but I prefer to separate my source files in to sections.

## File Order

Files are read in alphabetical order. If you'd like to change where content appears in the output, prefix the files numerically. For example:

    1 - MyFirstFile.md
    2 - MySecondFile.md
    3 - MyThirdFile.md

SimpleDoc doesn't care about your filenames, otherwise - it just reads the directory in order.

## Readme Files

If you include a `README.md` file in the directory, its contents will **always** be displayed at the top of the generated output, regardless of the other files' names.

I use the README as an introduction with links to the rendered docs for people viewing the repository.
