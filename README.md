<div align="center">
<h1>Titryes</h1>

[![Ruby Style Guide](https://img.shields.io/badge/code_style-rubocop-brightgreen.svg)](https://github.com/rubocop/rubocop)

<p>
    This Is The Reason You Encrypt Stuff
</p>
</div>

---

A Linux command-line utility running Dockerized browser instances from other operating systems.
Copies browser profiles off of Windows, Linux, and macOS and uses those inside local browsers.

Does not modify browser data.

There is currently no support for snap or flatpak installations.

Pronounced `Tie-tree-yes`.

## Supported Browsers

<table>
    <thead>
        <tr>
            <th>Browser</th>
            <th>Windows</th>
            <th>Linux</th>
            <th>macOS</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><img src="svg/browser/firefox.svg" width="60"></td>
            <td><img src="svg/supported.svg" width="60"></td>
            <td><img src="svg/supported.svg" width="60"></td>
            <td><img src="svg/not-implemented.svg" width="60"></td>
        </tr>
        <tr>
            <td><img src="svg/browser/firefox-developer-edition.svg" width="60"></td>
            <td colspan="3">Available as Firefox profile</td>
        </tr>
        <tr>
            <td><img src="svg/browser/firefox-nightly.svg" width="60"></td>
            <td colspan="3">Available as Firefox profile</td>
        </tr>
        <tr>
            <td><img src="svg/browser/chromium.svg" width="60"></td>
            <td><img src="svg/not-supported.svg" width="60"></td>
            <td><img src="svg/supported.svg" width="60"></td>
            <td><img src="svg/not-implemented.svg" width="60"></td>
        </tr>
        <tr>
            <td><img src="svg/browser/chrome.svg" width="60"></td>
            <td><img src="svg/supported.svg" width="60"></td>
            <td><img src="svg/supported.svg" width="60"></td>
            <td><img src="svg/not-implemented.svg" width="60"></td>
        </tr>
        <tr>
            <td><img src="svg/browser/chrome-beta.svg" width="60"></td>
            <td><img src="svg/supported.svg" width="60"></td>
            <td><img src="svg/supported.svg" width="60"></td>
            <td><img src="svg/not-implemented.svg" width="60"></td>
        </tr>
        <tr>
            <td><img src="svg/browser/chrome-canary.svg" width="60"></td>
            <td><img src="svg/supported.svg" width="60"></td>
            <td><img src="svg/supported.svg" width="60"></td>
            <td><img src="svg/not-implemented.svg" width="60"></td>
        </tr>
        <tr>
            <td><img src="svg/browser/opera.svg" width="60"></td>
            <td><img src="svg/supported.svg" width="60"></td>
            <td><img src="svg/supported.svg" width="60"></td>
            <td><img src="svg/not-implemented.svg" width="60"></td>
        </tr>
        <tr>
            <td><img src="svg/browser/opera-gx.svg" width="60"></td>
            <td><img src="svg/not-implemented.svg" width="60"></td>
            <td><img src="svg/not-supported.svg" width="60"></td>
            <td><img src="svg/not-implemented.svg" width="60"></td>
        </tr>
        <tr>
            <td><img src="svg/browser/edge.svg" width="60"></td>
            <td><img src="svg/not-implemented.svg" width="60"></td>
            <td><img src="svg/not-implemented.svg" width="60"></td>
            <td><img src="svg/not-implemented.svg" width="60"></td>
        </tr>
        <tr>
            <td><img src="svg/browser/safari.svg" width="60"></td>
            <td><img src="svg/not-supported.svg" width="60"></td>
            <td><img src="svg/not-supported.svg" width="60"></td>
            <td><img src="svg/not-implemented.svg" width="60"></td>
        </tr>
        <tr>
            <td><img src="svg/browser/brave.svg" width="60"></td>
            <td><img src="svg/not-implemented.svg" width="60"></td>
            <td><img src="svg/not-implemented.svg" width="60"></td>
            <td><img src="svg/not-implemented.svg" width="60"></td>
        </tr>
        <tr>
            <td><img src="svg/browser/tor.svg" width="60"></td>
            <td><img src="svg/not-implemented.svg" width="60"></td>
            <td><img src="svg/not-implemented.svg" width="60"></td>
            <td><img src="svg/not-implemented.svg" width="60"></td>
        </tr>
        <tr>
            <td><img src="svg/browser/duckduckgo.svg" width="60"></td>
            <td><img src="svg/not-implemented.svg" width="60"></td>
            <td><img src="svg/not-implemented.svg" width="60"></td>
            <td><img src="svg/not-implemented.svg" width="60"></td>
        </tr>
        <tr>
            <td><img src="svg/browser/vivaldi.svg" width="60"></td>
            <td><img src="svg/not-implemented.svg" width="60"></td>
            <td><img src="svg/not-implemented.svg" width="60"></td>
            <td><img src="svg/not-implemented.svg" width="60"></td>
        </tr>
    </tbody>
</table>

<table>
    <tbody>
        <tr>
            <td><img src="svg/supported.svg" width="40"></td>
            <td>Fully implemented</td>
        </tr>
        <tr>
            <td><img src="svg/not-implemented.svg" width="40"></td>
            <td>Not implemented</td>
        </tr>
        <tr>
            <td><img src="svg/not-supported.svg" width="40"></td>
            <td>Not supported</td>
        </tr>
    </tbody>
</table>

---

> Tor by default opens in icognito, so no data is stored unless it specifically was enabled.

## Limitations

- Sound is not available
- Shrinking the Window crashes on Chrome and its ilk

Somehow this does run on wayland despite using an Xorg passthrough.
