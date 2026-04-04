#
# ~/.bash_profile
#
[[ -f ~/.bashrc ]] && . ~/.bashrc
[[ -f ~/Documents/projects/dotfiles/.bashrc ]] && . ~/Documents/projects/dotfiles/.bashrc

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
