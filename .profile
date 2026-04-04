ENV=$HOME/.shinit
export ENV
if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi

# >>> juliaup initialize >>>

# !! Contents within this block are managed by juliaup !!

case ":$PATH:" in
    *:/home/mb6ockatf/.juliaup/bin:*)
        ;;

    *)
        export PATH=/home/mb6ockatf/.juliaup/bin${PATH:+:${PATH}}
        ;;
esac

# <<< juliaup initialize <<<
