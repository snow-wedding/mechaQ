# MB Match Notifier — Player Setup Guide

This tool watches your Mecha Break game log and sends you a private Discord notification the moment your queue pops — so you don't miss a match while AFK.

**What you'll need:**
- `mechabreak_notifier.html` and `launch.bat` (keep them in the same folder)
- Google Chrome or Microsoft Edge
- Python 3 — `launch.bat` will install it automatically if needed. If you prefer to install it yourself first: [python.org/downloads](https://www.python.org/downloads/)
- Mecha Break installed

**Time required:** ~2 minutes

---

## Step 1 — Get Your Discord User ID

1. Open Discord → **Settings** → **Advanced** → turn on **Developer Mode**.
2. Close Settings. Right-click your own username anywhere in Discord (the server member list works well).
3. Click **Copy User ID**. It will be a long number like `123456789012345678`.

---

## Step 2 — Launch the App

**Do not double-click `mechabreak_notifier.html` directly** — it won't work when opened as a file. Instead:

1. Make sure both files (`mechabreak_notifier.html` and `launch.bat`) are in the same folder.
2. Double-click **`launch.bat`**.
3. A command window will open and the notifier will launch in your browser automatically.

**Keep the command window open** the entire time you're using the notifier. Closing it shuts down the server.

> **Python is required** for the local server. `launch.bat` will detect and install it automatically if needed. If auto-install fails for any reason, download it manually from [python.org/downloads](https://www.python.org/downloads/) and run `launch.bat` again.

> Chrome or Edge only — Firefox is not supported.

---

## Step 3 — Enter Your Logs Folder Path

In the **Logs Folder** panel, paste your Mecha Break logs folder path into the text field. The default Steam location is:

```
C:\SteamLibrary\steamapps\common\MechaBREAK\Game\MechaBreak\logs\MechaBREAK
```

Your Steam library drive letter or folder name may differ. Once pasted, click **Start Monitoring**. The app will find the correct log file automatically and begin watching it. Your path is saved and will be pre-filled next time.

---

## Step 4 — Set Up Your Discord Channel

First, **join the notification server** if you haven't already: [discord.gg/dJM7B25a](https://discord.gg/dJM7B25a). The bot needs to share a server with you in order to create your private channel.

In the **Discord Notifier** panel:

1. Paste your **Discord User ID** (from Step 1) into the User ID field.
2. Click **Create My Channel**.

The app will automatically create a private Discord channel that only you can see. When it's done, the panel will show a green confirmation with your channel name.

> **Only do this once.** Running setup again will reuse your existing channel. If you do accidentally run it again, it will still work fine.

---

## Step 5 — Test It

Click **Test Ping** in the Discord Notifier panel. Check Discord — you should see a message appear in your private notification channel within a few seconds.

If the test works, you're fully set up.

---

## Step 6 — Enable Mobile Notifications (Optional but Recommended)

For the best AFK coverage, enable Discord push notifications for your private channel on your phone:

1. Open the notification server in Discord mobile.
2. Long-press your `mb-{username}` channel → **Notifications** → **All Messages**.

Discord will push-notify your phone whenever a match is found, even with the app in the background.

---

## How to Use It

Every time you queue in Mecha Break:

1. Open `mechabreak_notifier.html` in Chrome or Edge (if it's not already open).
2. Click **Resume** if prompted (the browser asks for re-permission on each new session — this is normal).
3. The app will show **MONITORING** in green and begin watching the log.
4. When your queue pops, you'll get:
   - A full-screen alert in the webapp
   - A browser push notification (even if the tab is minimised)
   - A Discord message in your private channel

---

## Troubleshooting

**"Select Folder" does nothing when I click it**
Make sure you launched the app using `start.bat` and not by opening the HTML file directly. The folder picker requires the page to be served over localhost.


You may have selected the wrong folder. Make sure the path ends in `MechaBREAK\logs\MechaBREAK` — there are multiple similarly-named folders in the installation directory.

**"Create My Channel" fails with an error**
Double-check that your Worker URL, Secret Key, and User ID are all correct. Typos are the most common cause. Make sure the Worker URL does not have a `/` at the end.

**I ran setup but didn't get a Test Ping**
Make sure you're in the notification Discord server. The bot can only message you if you share a server with it. Ask your organizer which server to join if you haven't already.

**The app shows "MONITORING" but I got a match and nothing happened**
Make sure the app is the active tab or at minimum open in the browser. Some browsers throttle background tabs — keeping the tab visible in the foreground is the most reliable setup.

**My logs folder is in a different location**
If Mecha Break is installed outside of Steam (e.g. via the standalone launcher), the logs may be in a different location. Ask your organizer or check your game installation directory for a folder named `MechaBREAK`.
