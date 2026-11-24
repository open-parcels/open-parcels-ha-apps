# Open Parcels

Self-hosted parcel and order tracking for every carrier, shop and inbox, running inside Home
Assistant. Open it from the **Parcels** entry in the sidebar.

## First start

1. Start the app and open **Parcels** in the sidebar. Home Assistant has already logged you in, so
   no setup code is needed: choose the admin password.
2. Add your connections: carrier and shop accounts, keyless tracking and inboxes (the **Connections**
   page). For something to look at first, add the **Demo shop** and **Demo
   courier**.

The log also prints a **setup code** on the first start. It is only needed if you set Open Parcels
up through port `3000` instead of the sidebar.

## The Home Assistant integration

The [Open Parcels integration](https://github.com/open-parcels/open-parcels-ha) puts parcels,
orders and courier positions into Home Assistant. It talks to the server's API.

Once the app runs, Home Assistant offers the integration under **Settings → Devices & services**
(discovered): confirm it and you are done. To add it by hand instead:

1. In Open Parcels, create an API token (**API tokens**, scopes read and write).
2. Add the integration with the address `http://<hostname>:3000` and that token, where
   `<hostname>` is the app's **Hostname** shown on its Info page. Home Assistant reaches the app
   over its internal network; port `3000` does not need to be opened.

Only enable port `3000` in the app's **Network** settings if something outside Home Assistant must
reach the server, and then set a reader password first (**Settings → Security**): without one,
anyone who can reach the port can read every parcel, order and address.

## Options

- **Log level**: how much the server logs (default `info`).
- **Public address**: the address Open Parcels is reachable at from outside, used in links of the
  calendar feed. Optional.
- **Night-time pause**: no carrier requests between midnight and 6 (default on).

### Options and the Settings page

The same three values can also be changed in Open Parcels under **Settings**. The rule is:

- The app's options are the starting values. A change here takes effect when the app restarts.
- A value saved on the **Settings** page wins over the app's option, also after restarts and
  updates. The Settings page marks such a value with a **Reset** button.
- **Reset** on the Settings page hands the value back to the app's option (or the default when
  the option is empty).

So if changing an option seems to do nothing, open **Settings**, look for that value and press
**Reset**.

## Data and backups

Everything lives in the app's data folder, so Home Assistant backups include the database and its
encryption key. Home Assistant stops the app for the few seconds a backup takes and starts it again
afterwards: copying the database while the server writes to it could give a backup that does not
restore cleanly.

The image, map-tile and collage caches and the database copies made by **Settings → Data** are
left out of backups; the caches refill themselves.

## Remote access

The app does not include Open Parcels' built-in Tailscale. To reach Open Parcels from outside your
home, use Home Assistant's own remote access (Home Assistant Cloud or the Tailscale app): the
**Parcels** panel works through it.
