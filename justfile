clean:
    rm -f dist/*.yaml

compile target:
    just clean
    mkdir -p dist
    cd cue-src && cue export ./content/common.cue ./content/generated/{{target}}.cue -e {{target}} -o ../dist/{{target}}.yaml
    ./compile.sh dist/{{target}}.yaml

# Shortcut: Compile generated resume
build target:
    just compile {{target}}
