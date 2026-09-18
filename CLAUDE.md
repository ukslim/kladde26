# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repo is

A single-purpose microsite for **The Kladde 26 Manifesto** ("Show Your Workings" — a manifesto
on disclosing language-model involvement in published writing). Repo `ukslim/kladde26`,
published at **kladde26.org** via GitHub Pages (custom domain, `CNAME` at repo root — so the
site is served at the domain root and internal links are plain root-relative paths).

Three pages, all Markdown at the repo root:

| File | URL | What it is |
|---|---|---|
| `index.md` | `/` | the manifesto itself, versioned (`v1.0.0 — 17 September 2026`) |
| `introduction.md` | `/introduction/` | why it exists; was a blog post on the old site |
| `faq.md` | `/faq/` | the questions the manifesto deliberately leaves open |
| `workings.md` | `/workings/` | workings for the manifesto |
| `faq-workings.md` | `/faq/workings/` | workings for the FAQ |

A new page is a new root-level `.md` with front matter `title`, `permalink`, `description` —
then add it to the nav in `_layouts/default.html`. A page with workings gets a sibling
`<name>-workings.md` at `/<name>/workings/`; workings pages stay out of the nav and are reached
only from the work they belong to.

## Commands

```sh
./serve.sh              # local server at http://localhost:4000
./serve.sh --port 4010  # flags pass through to jekyll serve
bundle install          # first run only
```

Ruby 3.3 is Homebrew keg-only and not on `PATH`; `serve.sh` prepends it. There is no test suite
and no CI — GitHub Pages builds Jekyll natively on push to `main`. To check a build without
serving: `PATH="/opt/homebrew/opt/ruby@3.3/bin:$PATH" bundle exec jekyll build`.

`_config.yml` changes need a server restart; everything else hot-reloads — but **not** under
`--detach`, which silently disables the watcher and serves stale output.

## Architecture

Jekyll, but deliberately **no theme gem** — `theme: null` in `_config.yml`, because the
`github-pages` gem otherwise defaults to `jekyll-theme-primer` and builds a 136KB stylesheet
nothing links to. Everything the site renders is in this repo:

- `_layouts/default.html` — the only layout: head, nav, title, content, footer. Applied to all
  pages by a `defaults:` rule, so pages don't declare `layout:`.
- `assets/style.css` — plain CSS (not SCSS, no Sass pipeline). Serif, single 40rem column,
  light/dark via `prefers-color-scheme`.

Front matter the layout honours:

- `show_title: false` — suppress the `<h1>` built from `page.title`. Used by both workings
  pages, whose bodies open with their own `# …​.kladde` headings.
- `workings_url:` — append the line "This work has shared *workings*, in line with Kladde 26"
  pointing at that URL. "Kladde 26" links to `/` except on `/` itself. The wording is fixed by
  the FAQ, which quotes it as the worked example of marking a piece.
- `workings_of:` + `workings_of_title:` — put a "← *title*" back-link at the top. Used by the
  workings pages.

Plugins: `jekyll-seo-tag` (the `{%- seo -%}` call in the layout supplies `<title>`, canonical
and Open Graph from front matter) and `jekyll-sitemap`. Both are GitHub Pages-supported; adding
a plugin outside that allowlist breaks the native build.

## Conventions

- **The site must practise what it preaches.** Any page here whose text came from a language
  model needs its workings published alongside it, and edits to workings must be declared
  within the workings themselves. This is the project's whole point, not a nicety.
- **The manifesto text is versioned.** Changing the wording of the clauses in `index.md` is a
  version bump, not a silent edit — check with the user before touching manifesto prose.
- **The `*-workings.md` files are historical records.** Do not tidy them, fix their links, or
  update quoted URLs inside a transcript (`workings.md` quotes `ukslim.github.io/fiction` as it
  was said at the time).
- Fiction lives on the author's personal site, not here. The single pointer to
  `https://john.hartnup.uk/fiction/` is the FAQ's "Where can I see examples?" answer; there is
  no site footer. Don't reintroduce the link elsewhere.
- British English, `lang: en-GB`.
- Content site, not an application: prefer editing pages, the layout and the stylesheet over
  adding build tooling or frameworks.
- Only create git commits when the user explicitly asks.

## Relationship to the old site

The manifesto material was copied here from `ukslim/ukslim.github.io`, the author's personal
blog (live at `john.hartnup.uk`). That migration is finished and the `OLD_SITE` symlink that
pointed at it is gone. What remains true over there:

- `/kladde-manifesto/` and `/kladde-manifesto/workings/` are redirect stubs pointing at
  `https://kladde26.org/` and `/workings/`. Changing those URLs here breaks them.
- The announcement post at `/2026/09/17/kladde-manifesto.html` stays on the blog — it is
  cloned to `/introduction/` here, not moved, so the two copies exist in parallel.
- The fiction section and its per-story "in line with Kladde 26" footers link here.
