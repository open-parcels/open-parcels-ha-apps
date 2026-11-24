<p align="center">
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/open-parcels/open-parcels/8cf7a65/docs/branding/banner-on-dark.png">
    <img alt="Open Parcels" src="https://raw.githubusercontent.com/open-parcels/open-parcels/8cf7a65/docs/branding/banner-on-light.png" width="640">
  </picture>
</p>

# Open Parcels apps for Home Assistant

Run [Open Parcels](https://open-parcels.github.io) as a Home Assistant app (add-on): the server
and web UI inside Home Assistant, opened from the sidebar.

[![Add repository to Home Assistant](https://my.home-assistant.io/badges/supervisor_add_addon_repository.svg)](https://my.home-assistant.io/redirect/supervisor_add_addon_repository/?repository_url=https%3A%2F%2Fgithub.com%2Fopen-parcels%2Fopen-parcels-ha-apps)

Or: **Settings → Apps → App store → ⋮ → Repositories**, add
`https://github.com/open-parcels/open-parcels-ha-apps`, then install **Open Parcels**.

| App | What it is |
|---|---|
| [Open Parcels](open_parcels) | The Open Parcels server with its web UI, prebuilt for `aarch64` and `amd64`. |

Each app version runs a pinned commit of Open Parcels. Home Assistant downloads a prebuilt image,
so installing and updating take seconds; what changed is in each app's `CHANGELOG.md`.

> **Status:** early development, `2.0.0-dev`. Expect breaking changes.
