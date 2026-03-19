# skk-jisyo-julia-unicode

SKK dictionaries for Julia's Unicode symbols, designed for use in **abbrev mode**.

## Dictionaries

| File | Description |
|------|-------------|
| `SKK-JISYO.julia-latex` | LaTeX symbol names (e.g. `alpha` → `α`) |
| `SKK-JISYO.julia-emoji` | Emoji names (e.g. `smile` → `😄`) |

In abbrev mode, type the symbol name without the leading `\` (LaTeX) or surrounding `:` (emoji).

## Formats

Each dictionary is distributed in three formats under `dist/`:

- `yaml/` — source format
- `json/` — JSON
- `mpk/` — MessagePack

The YAML schema follows [skk-dict/jisyo](https://github.com/skk-dict/jisyo).
The build pipeline (YAML → JSON + mpk) is also modeled after that project, using Deno.

## Build

**Requirements:**
- [Julia](https://julialang.org/)
- [Deno](https://deno.land/)

```sh
make
```

Or step by step:

```sh
julia generate_yaml.jl   # generate yaml/
deno run --allow-read --allow-write build.ts  # generate dist/
```

## License

This project is licensed under the [MIT License](LICENSE).

The dictionary data is derived from Julia's `REPL.REPLCompletions` module,
which is also distributed under the MIT License.
