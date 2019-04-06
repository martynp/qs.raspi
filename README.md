# OpenCPI Platform for Raspberry PI 3

This project contains the RCC platform to enable cross compiling for Raspberry PI 3 from a x64 host (tested with CentOS 7).

# Install

Assuming OpenCPI 1.4 is installed:

```
cd [opencpi_dir]
source ./cdk/opencpi-setup.sh -s
cd [qs.raspi_dir]
ocpidev register project
ocpidev build
cd [opencpi_dir]
source ./scripts/install-opencpi.sh pi3
```

It is then possible to create the installer .deb using the script located at `[qs.raspi\_dir]/rcc/platforms/pi3/createPackage.sh`.

This will create `./qs.raspi-[version].deb` which should be transferred to the Raspberry PI and installed using:

```
sudo apt-get install ./qs.raspi-[version].deb
```

On the Raspberry PI the following command will run one of the built in applications:

```
ocpirun -v -d --library-path=/usr/share/opencpi/artifacts/ /usr/share/opencpi/applications/tb_bias.xml
```

