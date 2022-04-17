# HexFlora

## Quick start

Install `asdf` version manager from https://asdf-vm.com/guide/getting-started.html#_1-install-dependencies.

As well as the plugins for Erlang and Elixir:

```
asdf plugin install erlang
asdf plugin install elixir
asdf install
```

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Install Node.js dependencies with `npm install` inside the `assets` directory
  * `mix assets.deploy`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

### Learn more about Phoenix

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix

## Development

HexFlora is built with Phoenix and [NimblePublisher](https://github.com/dashbitco/nimble_publisher).

### Specimen articles

Individual specimen articles are Markdown files under the hood stored
in `priv/herbarium`. Filenames are made up of the binomial name: `genus_species.md`.

New specimen articles can be generated from the command line with:

```
mix hf.gen.spec Family Genus species
```

Replace `Family`, `Genus`, and `species` with the appropriate values.

A corresponding image should be placed at `assets/static/images/genus_species.jpg`. Do not optimize images. Images are optimized
as part of the build process with ImageMagick.

### Other pages

The other pages in the project are normal EEx HTML templates located in
`hex_flora_web/templates/page`.

## Contributing

Please fork the repository, make a pull request with your suggested changes. Consider creating an issue detailing the work you plan to do
before starting any work.