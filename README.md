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

It is then possible to create the installer .deb using the script located at `[qs.raspi_dir]/rcc/platforms/pi3/createPackage.sh`.

This will create `./qs.raspi-[version].deb` which should be transferred to the Raspberry PI and installed using:

```
sudo apt-get install ./qs.raspi-[version].deb
```

On the Raspberry PI the following command will run one of the built in applications:

```
export OCPI_CDK_DIR=/usr/share/opencpi
ocpirun -v -d --library-path=/usr/share/opencpi/artifacts/ /usr/share/opencpi/applications/tb_bias.xml
```

Which generates:

```
Available containers are:  0: rcc0 [model: rcc os: linux platform: pi3]
Actual deployment is:
  Instance  0 pattern (spec ocpi.assets.base_comps.pattern) on rcc container 0: rcc0, using pattern in /usr/share/opencpi/artifacts//3-ocpi.assets.base_comps.pattern.rcc.0.pi3.so dated Sat Apr  6 19:19:13 2019
  Instance  1 bias (spec ocpi.core.bias) on rcc container 0: rcc0, using bias_spcm in /usr/share/opencpi/artifacts//61-ocpi.core.bias_spcm.rcc.0.pi3.so dated Sat Apr  6 19:19:13 2019
  Instance  2 capture (spec ocpi.assets.base_comps.capture) on rcc container 0: rcc0, using capture in /usr/share/opencpi/artifacts//0-ocpi.assets.base_comps.capture.rcc.0.pi3.so dated Sat Apr  6 19:19:13 2019
Application XML parsed and deployments (containers and artifacts) chosen
Application established: containers, workers, connections all created
Communication with the application established
Dump of all initial property values:
Property  0: pattern.control = "1" (cached)
Property  1: pattern.metadataCount = "2"
Property  2: pattern.messagesSent = "0"
Property  3: pattern.dataSent = "0"
Property  4: pattern.messagesToSend = "2"
Property  5: pattern.pad0 = "<unreadable>"
Property  6: pattern.status = "0"
Property  7: pattern.metadata = "{12,0},{0}" (cached)
Property  8: pattern.data = "9,8,7,6,0" (cached)
Property  9: pattern.ocpi_debug = "false" (parameter)
Property 10: pattern.ocpi_endian = "little" (parameter)
Property 11: pattern.nextMeta = "0"
Property 12: pattern.nextData = "0"
Property 13: bias.biasValue = "16909060" (cached)
Property 14: bias.ocpi_debug = "false" (parameter)
Property 15: bias.ocpi_endian = "little" (parameter)
Property 16: bias.t1 = "0"
Property 17: capture.control = "3" (cached)
Property 18: capture.metadataCount = "0"
Property 19: capture.dataCount = "0"
Property 20: capture.status = "0"
Property 21: capture.metadata = "{0}"
Property 22: capture.data = "0"
Property 23: capture.ocpi_debug = "false" (parameter)
Property 24: capture.ocpi_endian = "little" (parameter)
Property 25: capture.nextMeta = "0"
Property 26: capture.nextData = "0"
Application started/running
Waiting for application to finish (no time limit)
Application finished
Dump of all final property values:
Property  1: pattern.metadataCount = "2"
Property  2: pattern.messagesSent = "2"
Property  3: pattern.dataSent = "12"
Property  4: pattern.messagesToSend = "0"
Property  5: pattern.pad0 = "<unreadable>"
Property  6: pattern.status = "0"
Property 11: pattern.nextMeta = "0"
Property 12: pattern.nextData = "12"
Property 16: bias.t1 = "0"
Property 18: capture.metadataCount = "2"
Property 19: capture.dataCount = "3"
Property 20: capture.status = "0"
Property 21: capture.metadata = "{12,0},{0}"
Property 22: capture.data = "16909069,16909068,16909067,0"
Property 25: capture.nextMeta = "2"
Property 26: capture.nextData = "0"

```