# Linkly Conversion Tracking — Google Tag Manager template

Attributes sales and leads back to the [Linkly](https://linklyhq.com) short link
that caused them.

Install it from the [Community Template Gallery][gallery] — search for *Linkly
Conversion Tracking* under **Templates → Search Gallery** in your container.
This repository is the source the gallery reads from.

[gallery]: https://tagmanager.google.com/gallery/

## Setup

**1. Initialise — this one is not optional.**

Add the tag with Tag Type *Initialise* and trigger it on **Initialisation — All
Pages**.

It must fire on every page, not only the page you are tracking. The attribution
token arrives as a `linkly_cid` parameter on the landing URL and is stored on
first sight; a tag that only fires at checkout arrives long after that parameter
is gone and has nothing to capture. This is the single most common way to end up
with zero conversions and no error to explain it.

**2. Set Cookie Domain if your checkout is on another subdomain.**

Landing on `www.example.com` and converting on `checkout.example.com` needs
`.example.com` here. Browser storage is scoped to one exact origin, so without
it the token cannot cross the boundary and those sales silently fail to
attribute — nothing logs a warning, the conversions simply never arrive.

One hostname throughout? Leave it blank.

**3. Conversions — you may already be done.**

If your site pushes GA4 ecommerce events to the data layer, the GA4 bridge is on
by default and picks up purchases on its own. No further tags.

Otherwise add a *Track Sale* or *Track Lead* tag on your own trigger.

> **Do not do both for the same event.** A GA4 `purchase` and a Track Sale tag on
> the same trigger report twice. They collapse into one conversion only when both
> carry the same order ID, so if you do run both, set the Track Sale tag's Order
> ID to the same transaction ID GA4 uses. Turning the bridge off is the simpler
> fix.

## Amounts

Amount is in the **smallest unit of the currency**: `4999` is £49.99. Data layers
usually hold a decimal, so multiply by 100 in a GTM variable first. Passing
`49.99` records a sale of forty-nine pence.

## Consent

The tag writes a first-party cookie and browser storage for attribution. If you
use Consent Mode, gate the Initialise tag on the consent type your policy
assigns to advertising attribution — `ad_storage` for most sites. The tracker
itself does not read consent state.

## What it loads

`https://cdn.linklyhq.com/linkly.js` — roughly 2.4 kB gzipped. No other network
access, and no API key: the workspace is derived server-side from the
attribution token, which carries a link ID, and a link belongs to exactly one
workspace.

GTM's sandbox provides `injectScript(url)` and no way to set attributes on the
resulting tag, which is how the tracker is normally configured. The template
therefore writes `window.linklyConfig` before injecting, which the tracker reads
on load.

Ordering is handled by an arguments queue: a Track tag that fires before the
tracker has loaded pushes onto `window.linkly.q`, and the tracker drains it on
arrival. Nothing is lost to trigger ordering.

## Permissions

| Permission | Scope | Why |
| --- | --- | --- |
| `inject_script` | `https://cdn.linklyhq.com/linkly.js` | Loads the tracker. |
| `access_globals` | `linkly`, `linkly.q`, `linklyConfig` | Calls the tracker, queues calls made before it loads, and passes settings to it. |

## Development

Import `template.tpl` into GTM via **Templates → New → ⋮ → Import**, then run the
bundled tests from the template editor before opening a pull request.

## Support

[support@linklyhq.com](mailto:support@linklyhq.com) · [linklyhq.com/support](https://linklyhq.com/support)

## Licence

MIT — see [LICENSE](LICENSE).
