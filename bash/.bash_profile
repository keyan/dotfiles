if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/keyan/bin/google-cloud-sdk/path.bash.inc' ]; then . '/Users/keyan/bin/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/keyan/bin/google-cloud-sdk/completion.bash.inc' ]; then . '/Users/keyan/bin/google-cloud-sdk/completion.bash.inc'; fi

# opam configuration
test -r /Users/keyan/.opam/opam-init/init.sh && . /Users/keyan/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true
