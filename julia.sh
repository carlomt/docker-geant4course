case ":$PATH:" in
    *:/root/.juliaup/bin:*)
        ;;

    *)
        export PATH=/root/.juliaup/bin${PATH:+:${PATH}}
        ;;
esac
