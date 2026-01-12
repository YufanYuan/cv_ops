clean:
    rm -f dist/*.yaml

build target:
    just clean
    mkdir -p dist
    cd src && cue export ./content -e {{target}} -o ../dist/{{target}}.yaml
    ./compile.sh dist/{{target}}.yaml
