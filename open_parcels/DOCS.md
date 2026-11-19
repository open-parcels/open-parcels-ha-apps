# Open Parcels

Self-hosted parcel and order tracking for every carrier, shop and mailbox, running inside Home
Assistant. Open it from the **Parcels** entry in the sidebar.

## First start

1. Start the app and open its log. It prints a **setup code** on the first start.
2. Open **Parcels** in the sidebar, enter the setup code and choose the owner password.
3. Add your carrier accounts, shops and mailboxes under **Sources**. For something to look at
   first, add the **Demo shop** and **Demo courier**.

## The Home Assistant integration

The [Open Parcels integration](https://github.com/open-parcels/open-parcels-ha) puts parcels,
orders and courier positions into Home Assistant. It talks to the server's API:

1. In the app's **Network** settings, enable port `3000`.
2. In Open Parcels, create an API token (**API tokens**, scopes read and write).
3. Add the integration with the address `http://<home-assistant-host>:3000` and that token.

## Options

- **Log level**: how much the server logs (default `info`).
- **Public address**: the address Open Parcels is reachable at from outside, used in links of the
  calendar feed. Optional.
- **Night-time pause**: no carrier requests between midnight and 6 (default on).

## Data and backups

Everything lives in the app's data folder, so Home Assistant backups include the database and its
encryption key.
