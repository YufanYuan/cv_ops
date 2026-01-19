clean:
    rm -f dist/*.yaml

compile target:
    just clean
    mkdir -p dist
    cd cue-src && cue export ./content/common.cue ./content/generated/{{target}}.cue -e {{target}} -o ../dist/{{target}}.yaml
    ./compile.sh dist/{{target}}.yaml

# Agent: Generate or Update a resume for a JD
# Usage: just gen google ./jds/google_jd.txt
gen target jd_path:
    uv run python src/agents/generator.py --name {{target}} --jd {{jd_path}}

# Agent: Check for hallucinations
# Usage: just audit google
audit target:
    uv run python src/agents/guardian.py --target {{target}}

# Agent: Sync manual edits back to master data
# Usage: just sync google
sync target:
    uv run python src/agents/syncer.py --target {{target}}

# Shortcut: Generate -> Audit -> Build
build target jd_path:
    just gen {{target}} {{jd_path}}
    just audit {{target}}
    just compile {{target}}
