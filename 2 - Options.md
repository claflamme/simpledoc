# Options

SimpleDoc may be simple but it still has a few options. You can use any or all of these together.

## from

_**-f, --from <path>**_

Specify the directory to read markdown files from. Defaults to current directory.

    simpledoc -f C:\Example\Docs

## to

_**-t, --to <path>**_

Specify the output directory for the `index.html` file. Defaults to current directory.

    simpledoc -t C:\Example\Output

## serve

_**-s, --serve**_

Starts a server after compiling docs, running on port 3000 or whatever the `$PORT` environment variable is set to. Defaults to disabled.

    simpledoc -s
