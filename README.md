# 💬 ChatApp — WhatsApp Style Flutter UI

A pixel-perfect WhatsApp-style chat application built with **Flutter**. Features a full contact list, real-time-style message bubbles, Hero animations, dark mode, and a polished chat UI — all with zero backend required.

<br>

## 📸 Screenshots

<!--
  HOW TO ADD YOUR SCREENSHOTS:
  1. Run the app on your emulator or real device
  2. Take screenshots of each screen listed below
  3. Create a folder called "screenshots" in your project root
  4. Save each image with the exact filename shown
  5. Push to GitHub — images will appear automatically in this table
-->
### Contact
<img width="388" height="756" alt="Screenshot from 2026-04-19 20-07-47" src="https://github.com/user-attachments/assets/f788fa9c-61e3-4e1e-a541-0a62e90f844a" />

### Chat
<img width="388" height="756" alt="Screenshot from 2026-04-19 20-08-06" src="https://github.com/user-attachments/assets/eebc5a22-6fc8-4270-866d-50fef98ccaaa" />

###  Search data
<img width="388" height="756" alt="Screenshot from 2026-04-19 20-08-43" src="https://github.com/user-attachments/assets/4ad436d6-316f-44b2-a9a5-32ec836c0a52" />

## ✨ Features

- 🦸 **Hero animation** — avatar smoothly flies from contact list into the chat app bar
- 💬 **Message bubbles** — sent (green) and received (white) with custom tail using `CustomPainter`
- ✅ **Message tick icons** — single tick (sent), double grey (delivered), double blue (read)
- 📅 **Date dividers** — Today / Yesterday / weekday labels between message groups
- 🔍 **Search contacts** — filter contact list by name in real time
- 📖 **Story row** — horizontal scrollable story avatars above the chat list
- 🗂️ **Tab bar** — Chats / Status / Calls tabs
- 🌙 **Dark mode** — full dark theme matching WhatsApp's dark palette
- ⬇️ **Scroll to bottom** — floating button appears when scrolled up in chat
- ✉️ **Send new messages** — type and send, messages appear instantly
- 🎙️ **Animated send button** — mic icon switches to send icon with smooth animation
- 📲 **Slide transition** — chat screen slides in from the right on open
- 🟢 **Online indicator** — green dot on online contact avatars

<br>

## 🛠️ Tech Stack

| Layer | Technology |
|---|---|
| Framework | Flutter (Dart) |
| Animations | Hero, AnimationController, AnimatedSwitcher, SlideTransition |
| Custom Drawing | CustomPainter (bubble tail triangle) |
| Date Formatting | intl |
| Architecture | Feature-based folder structure |
| Backend | None — fully hardcoded offline data |

<br>
