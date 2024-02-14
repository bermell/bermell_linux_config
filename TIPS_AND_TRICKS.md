# Tips and tricks

## Vim

`:%! jq .` will pipe the current buffer into `jq` and replace
the buffer with the output.

`:set filetype=json` will make vim treat the buffer (of file?)
as json file.
