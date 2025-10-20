function uuid --description 'copies a new uuid to the clipboard'
    # works on macOS
    set -l uuid_thing (uuidgen)

    printf "%s" $uuid_thing | pbcopy

end
