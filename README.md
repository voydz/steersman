# steersman
A docker image for running klipper, moonraker and mainsail from arbitary hardware.

## Prepare config
1. Create `config` folder
2. Inside it create corresponding `gcode_files` and `klipper_config` directories
3. Put your `printer.cfg` and `moonraker.conf` inside of `klipper_config`
4. You will end up with a tree that looks like this:
```
config
├── gcode_files
└── klipper_config
    ├── moonraker.conf
    └── printer.cfg
```
5. Link this config dir to your docker image as a shared volume (`-v path/to/config:/config`)

**NOTE:** Make sure moonraker is correctly configured or mainsail will not be able to connect. (see [mainsail docs](https://docs.mainsail.xyz/setup/manual-setup/moonraker#configuration))

## Run the container
1. Just fire up the container as you are used to with docker

```bash
docker run --name steersman -d -p 80:80 --device /dev/ttyACM0:/dev/ttyACM0 -v /path/to/your/config:/config steersman:latest
```

**NOTE:** Make sure you link the config via `-v` and the printers serial via `--device` (the linked device has to match up with the one specified in your `printer.cfg`)

## Build firmware
**NOTE:** Building klipper out of the container works fine. **I would not try to flash out of the container, though.**

1. Enter the container shell with `docker exec -it steersman bash`
2. Navigate to klipper src dir via `cd /steersman/klipper/src`
3. Follow instructions on building the firmware from the [klipper docs](https://www.klipper3d.org/Installation.html#building-and-flashing-the-micro-controller)
4. You may copy the firmware to the `/config` dir (i.e. `cp /steersman/klipper/src/out/klipper.elf.hex /config/`) and get it outside of the container.

## 