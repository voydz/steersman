# steersman ![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/voydz/steersman) ![Docker Pulls](https://img.shields.io/docker/pulls/voydz/steersman)
A docker image for running klipper, moonraker and mainsail from arbitary hardware.

## Run the container
Just fire up the container as you are used to with docker and pass in your printers serial port using the `--device` option.

```bash
docker run --name steersman -d -p 80:80 \
    -v /path/to/your/config:/config \
    --device /dev/serial/by-id/usb-1a86_USB2.0-Serial-if00-port0:/dev/serial/by-id/usb-1a86_USB2.0-Serial-if00-port0 \
    steersman:latest
```

**NOTE:** Due to limitations in dockers device passthrough you will run into issues restarting the firmware. A "restart" works just fine though.

There is an fix for this issue, though:

```bash
docker run --name steersman -d -p 80:80 \
    --privileged \
    -v /dev:/dev \
    -v /path/to/your/config:/config \
    steersman:latest
```

**NOTE:** This solution may come with severe security concerns. Do not use it unless you are sure, what you are doing! Linking the whole `/dev` directory inside the container enables "hotplug support".

## Configuration
After you booted the container you will end up with a tree at `/path/to/your/config` that looks like this:
```
config
├── gcode_files         # Your virtual sdcard
└── klipper_config      # Config files for klipper and moonraker
    ├── moonraker.conf
    └── printer.cfg
```

1. Feel free to update the files inside `klipper_config`  to your needs.
2. Make sure your `printer.cfg` keeps:
```ini
[virtual_sdcard]
# for gcode upload
path: ~/gcode_files 

[display_status]
# for display messages in status panel

[pause_resume]
# for pause/resume functionality. 
# Mainsail needs gcode macros for `PAUSE`, `RESUME` and `CANCEL_PRINT` to make the buttons work.
```
More info? See [mainsail docs for klipper](https://docs.mainsail.xyz/setup/manual-setup/klipper) for more information.

3. Make sure moonraker is configured correctly or mainsail will not be able to connect:
```ini
[server]
config_path: ~/klipper_config

[authorization]
trusted_clients:
    172.17.0.0/16

[update_manager]

[update_manager client mainsail]
type: web
repo: meteyou/mainsail
path: steersman/mainsail/src # to update mainsail inside the container
```
Trouble? See [mainsail docs for moonraker](https://docs.mainsail.xyz/setup/manual-setup/moonraker#configuration)

**NOTE:** You can have a look at the example config at the `config/` folder of this repository.

## Build firmware
**NOTE:** Building klipper out of the container works fine. **I would not try to flash out of the container, though.**

1. Enter the container shell with `docker exec -it steersman bash`
2. Navigate to klipper src dir via `cd /steersman/klipper/src`
3. Follow instructions on building the firmware from the [klipper docs](https://www.klipper3d.org/Installation.html#building-and-flashing-the-micro-controller)
4. You may copy the firmware to the `/config` dir (i.e. `cp /steersman/klipper/src/out/klipper.elf.hex /config/`) and get it outside of the container.

## Noteworthy
* **Webcams** can be passed as devices and should work in theory, but I did not test mjpegstreamer
* **GPIO** I/O may also be passed as devices, and should work, but did not test it

## Known issues
* **host control** (i.e. from mainsail "power" menu) is not supported either 