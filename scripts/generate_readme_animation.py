"""Generate the lightweight workflow animation used by the project README."""

from __future__ import annotations

import math
from pathlib import Path

from PIL import Image, ImageDraw, ImageFont


ROOT = Path(__file__).resolve().parents[1]
OUTPUT = ROOT / "docs" / "assets" / "synk-workflow.gif"
WIDTH, HEIGHT = 1200, 660
FRAMES = 24

BG = (10, 15, 29)
PANEL = (20, 28, 47)
PANEL_HI = (26, 37, 60)
STROKE = (52, 69, 98)
TEXT = (237, 244, 255)
MUTED = (142, 160, 190)
CYAN = (98, 232, 217)
BLUE = (103, 145, 255)
PURPLE = (156, 117, 255)
GREEN = (104, 230, 166)


def font(size: int, bold: bool = False) -> ImageFont.FreeTypeFont:
    candidates = (
        [r"C:\Windows\Fonts\seguisb.ttf", r"C:\Windows\Fonts\segoeuib.ttf"]
        if bold
        else [r"C:\Windows\Fonts\segoeui.ttf"]
    )
    for candidate in candidates:
        try:
            return ImageFont.truetype(candidate, size)
        except OSError:
            continue
    return ImageFont.load_default()


def lerp(a: tuple[int, int, int], b: tuple[int, int, int], t: float) -> tuple[int, int, int]:
    t = max(0.0, min(1.0, t))
    return tuple(round(x + (y - x) * t) for x, y in zip(a, b))


def rounded(draw: ImageDraw.ImageDraw, box, radius: int, fill, outline=None, width=1):
    draw.rounded_rectangle(box, radius=radius, fill=fill, outline=outline, width=width)


def label(draw, xy, text, size, color=TEXT, bold=False, anchor=None):
    draw.text(xy, text, font=font(size, bold), fill=color, anchor=anchor)


def draw_background(image: Image.Image, frame: int) -> None:
    pixels = image.load()
    for y in range(HEIGHT):
        t = y / HEIGHT
        base = lerp((12, 17, 33), (7, 12, 24), t)
        for x in range(WIDTH):
            glow = max(0.0, 1 - math.sqrt(((x - 610) / 850) ** 2 + ((y - 305) / 520) ** 2))
            pulse = 0.5 + 0.5 * math.sin(frame / FRAMES * math.tau)
            color = lerp(base, (20, 33, 61), glow * (0.24 + pulse * 0.04))
            pixels[x, y] = color


def draw_device_shells(draw: ImageDraw.ImageDraw, phase: int, progress: float) -> None:
    # Phone
    rounded(draw, (72, 145, 354, 577), 34, (14, 20, 35), (70, 88, 122), 2)
    rounded(draw, (84, 158, 342, 564), 26, (18, 27, 46))
    rounded(draw, (165, 167, 262, 174), 4, (64, 78, 104))
    label(draw, (105, 196), "Synk", 24, CYAN, True)
    rounded(draw, (255, 198, 320, 222), 12, (22, 63, 65), (45, 133, 127))
    draw.ellipse((265, 206, 273, 214), fill=GREEN)
    label(draw, (279, 203), "LIVE", 11, GREEN, True)

    if phase < 2:
        label(draw, (105, 256), "Pair a device", 18, TEXT, True)
        label(draw, (105, 284), "Share this one-time code", 13, MUTED)
        rounded(draw, (104, 313, 322, 390), 18, (24, 39, 64), (55, 80, 119))
        code = "472 806" if phase == 0 else "472 806"
        label(draw, (213, 350), code, 29, CYAN, True, "mm")
        label(draw, (213, 375), "EXPIRES IN 05:00", 10, MUTED, True, "mm")
        rounded(draw, (104, 407, 322, 457), 14, (39, 58, 92), (69, 95, 142))
        label(draw, (213, 432), "Create pairing code", 14, TEXT, True, "mm")
        rounded(draw, (104, 474, 322, 529), 13, (18, 31, 50), (44, 60, 86))
        label(draw, (119, 491), "Desktop is ready to pair", 12, MUTED)
        if phase == 1:
            rounded(draw, (245, 483, 310, 510), 10, (25, 70, 60), (57, 150, 111))
            label(draw, (277, 489), "PAIRED", 10, GREEN, True, "ma")
    else:
        label(draw, (105, 256), "Clipboard sync", 18, TEXT, True)
        rounded(draw, (104, 292, 322, 431), 18, (24, 39, 64), (55, 80, 119))
        label(draw, (122, 314), "RECEIVED FROM DESKTOP", 10, CYAN, True)
        label(draw, (122, 347), "Meet at 4:30", 17, TEXT, True)
        label(draw, (122, 375), "Bring the notebook.", 15, MUTED)
        rounded(draw, (104, 451, 322, 504), 14, (22, 63, 65), (45, 133, 127))
        draw.ellipse((122, 469, 138, 485), fill=GREEN)
        label(draw, (151, 469), "Synced just now", 14, GREEN, True)

    # Desktop monitor
    rounded(draw, (424, 129, 1128, 539), 24, (15, 22, 39), (70, 88, 122), 2)
    rounded(draw, (437, 142, 1115, 525), 16, (18, 25, 42))
    draw.line((437, 192, 1115, 192), fill=(46, 60, 86), width=1)
    label(draw, (464, 160), "S", 19, CYAN, True)
    label(draw, (491, 160), "Synk Desktop", 16, TEXT, True)
    rounded(draw, (1003, 155, 1088, 180), 12, (22, 63, 65), (45, 133, 127))
    draw.ellipse((1014, 163, 1022, 171), fill=GREEN)
    label(draw, (1029, 160), "CONNECTED", 10, GREEN, True)
    label(draw, (464, 218), "Paired devices", 16, TEXT, True)
    rounded(draw, (464, 247, 1088, 302), 14, (24, 34, 54), (48, 65, 96))
    draw.ellipse((482, 266, 500, 284), fill=CYAN)
    label(draw, (515, 257), "Synk Mobile", 14, TEXT, True)
    label(draw, (515, 278), "Phone · online", 11, MUTED)
    rounded(draw, (1009, 259, 1072, 286), 10, (25, 70, 60), (57, 150, 111))
    label(draw, (1040, 265), "ONLINE", 10, GREEN, True, "ma")

    if phase < 2:
        label(draw, (464, 326), "Pair with a code", 16, TEXT, True)
        label(draw, (464, 353), "Enter the six-digit code from your phone.", 12, MUTED)
        rounded(draw, (464, 376, 780, 434), 12, (12, 19, 33), (61, 78, 108))
        if phase == 0:
            label(draw, (487, 394), "_  _  _  _  _  _", 18, (103, 121, 153), True)
        else:
            label(draw, (487, 394), "4  7  2  8  0  6", 18, CYAN, True)
        rounded(draw, (798, 376, 948, 434), 12, (77, 96, 219), (114, 130, 250))
        label(draw, (873, 393), "Pair device", 14, TEXT, True, "ma")
        if phase == 1:
            rounded(draw, (967, 376, 1088, 434), 12, (22, 63, 65), (45, 133, 127))
            label(draw, (1027, 393), "Paired", 13, GREEN, True, "ma")
    else:
        label(draw, (464, 326), "Latest clipboard", 16, TEXT, True)
        rounded(draw, (464, 356, 1088, 431), 14, (24, 34, 54), (48, 65, 96))
        label(draw, (485, 373), "Meet at 4:30  ·  Bring the notebook.", 16, TEXT, True)
        label(draw, (485, 402), "Delivered to Synk Mobile", 12, CYAN)
        rounded(draw, (464, 451, 1088, 496), 12, (20, 38, 52), (44, 85, 94))
        label(draw, (485, 465), "Text copied on one device. Ready on the other.", 13, GREEN, True)

    # Monitor stand
    rounded(draw, (687, 539, 865, 557), 7, (47, 60, 83))
    rounded(draw, (640, 556, 912, 568), 6, (42, 55, 77))


def draw_flow(draw: ImageDraw.ImageDraw, phase: int, progress: float, frame: int) -> None:
    start = (354, 359 if phase < 2 else 395)
    end = (424, 405 if phase < 2 else 395)
    draw.line((start[0], start[1], end[0], end[1]), fill=(54, 76, 112), width=3)
    x = start[0] + (end[0] - start[0]) * progress
    y = start[1] + (end[1] - start[1]) * progress
    color = CYAN if phase < 2 else PURPLE
    glow = 10 + 3 * math.sin(frame * math.tau / 6)
    draw.ellipse((x - glow, y - glow, x + glow, y + glow), fill=(*color,))
    draw.ellipse((x - 4, y - 4, x + 4, y + 4), fill=(255, 255, 255))


def draw_footer(draw: ImageDraw.ImageDraw, phase: int, progress: float) -> None:
    step_text = [
        ("01", "PAIR ONCE", "A short-lived code links your devices."),
        ("02", "CONNECT SECURELY", "Each device keeps its own credentials."),
        ("03", "COPY. IT'S THERE.", "Text moves across your paired devices."),
    ]
    number, title, subtitle = step_text[phase]
    label(draw, (78, 615), number, 13, CYAN if phase < 2 else PURPLE, True)
    label(draw, (111, 609), title, 14, TEXT, True)
    label(draw, (306, 611), subtitle, 13, MUTED)
    x0, x1, y = 901, 1117, 620
    rounded(draw, (x0, y - 4, x1, y + 4), 4, (35, 47, 71))
    fill_end = x0 + round((x1 - x0) * ((phase + progress) / 3))
    if fill_end > x0:
        rounded(draw, (x0, y - 4, fill_end, y + 4), 4, CYAN if phase < 2 else PURPLE)


def render_frame(frame: int) -> Image.Image:
    phase = min(2, frame // 8)
    progress = (frame % 8) / 7
    image = Image.new("RGB", (WIDTH, HEIGHT), BG)
    draw_background(image, frame)
    draw = ImageDraw.Draw(image)

    label(draw, (74, 48), "SYNK", 18, CYAN, True)
    label(draw, (148, 51), "CROSS-DEVICE CLIPBOARD", 11, MUTED, True)
    label(draw, (74, 73), "Your text, wherever you need it.", 27, TEXT, True)
    label(draw, (74, 106), "A six-digit code pairs once. Secure connections keep clipboard text in sync.", 14, MUTED)

    draw_device_shells(draw, phase, progress)
    draw_flow(draw, phase, progress, frame)
    draw_footer(draw, phase, progress)
    return image


def main() -> None:
    OUTPUT.parent.mkdir(parents=True, exist_ok=True)
    frames = [render_frame(index) for index in range(FRAMES)]
    palette_frames = [frame.quantize(colors=128, method=Image.Quantize.FASTOCTREE) for frame in frames]
    palette_frames[0].save(
        OUTPUT,
        save_all=True,
        append_images=palette_frames[1:],
        duration=115,
        loop=0,
        optimize=True,
        disposal=2,
    )
    print(f"Generated {OUTPUT.relative_to(ROOT)} ({OUTPUT.stat().st_size:,} bytes)")


if __name__ == "__main__":
    main()
