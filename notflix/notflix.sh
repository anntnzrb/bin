PROGRAM_NAME='liberion'

println() {
    ## Print a message to stdout. With a newline.

    printf '%s!!!\n' "${@}"
}

println ${PROGRAM_NAME}
