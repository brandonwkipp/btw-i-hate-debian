# Vital ARM Build TODO

## Install missing build dependencies

```bash
sudo apt install \
  g++-14 pkg-config \
  libx11-dev libxext-dev libxinerama-dev libxrandr-dev libxcursor-dev \
  libasound2-dev libfreetype-dev libfontconfig1-dev \
  libcurl4-openssl-dev libwebkit2gtk-4.1-dev libgtk-3-dev \
  libgles2-mesa-dev libgl-dev
```

- [ ] `g++-14` — gcc-14 is present but C++ frontend is not
- [ ] `pkg-config` — missing, required by build scripts
- [ ] `libx11-dev`, `libxext-dev`, `libxinerama-dev`, `libxrandr-dev`, `libxcursor-dev` — X11 windowing
- [ ] `libasound2-dev` — ALSA audio
- [ ] `libfreetype-dev`, `libfontconfig1-dev` — font rendering
- [ ] `libcurl4-openssl-dev` — network (preset sync etc.)
- [ ] `libwebkit2gtk-4.1-dev` — embedded browser UI (try `4.0` if `4.1` not found)
- [ ] `libgtk-3-dev` — GTK integration
- [ ] `libgles2-mesa-dev`, `libgl-dev` — OpenGL ES (ARM uses `-DOPENGL_ES=1`)

## Build

- [ ] `make standalone` — dry run to surface any remaining missing headers
- [ ] `make all` — builds standalone + VST + VST3 + LV2
