# kladde26

The Kladde 26 Manifesto — *Show Your Workings*. A manifesto on disclosing
language-model involvement in published writing.

Published at **[kladde26.org](https://kladde26.org)** via GitHub Pages.

- `/` — the manifesto
- `/introduction/` — why it exists
- `/faq/` — questions, and what the manifesto deliberately leaves open
- `/workings/`, `/faq/workings/` — the edited transcripts that produced each

## Local development

```sh
./serve.sh        # http://localhost:4000
```

Ruby 3.3 is Homebrew keg-only; `serve.sh` puts it on `PATH` and runs
`bundle exec jekyll serve`. First run needs `bundle install`.
