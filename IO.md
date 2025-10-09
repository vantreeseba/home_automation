# A list of I/O for smart home devices.

### Generic Inputs / Sensors
| Type | Units | Description
| --- | --- | --- |
| Relative Humidity | % | 
| Concentration | unit/volume(m³,L,...) | Concentration of something, i.e. absolute humidity, PM1, etc
| Count | unit | The number of something.
| Frequency | unit/time | The number of times something occurs per unit time, i.e. button presses per hour.


### Outputs / Actuators



### Home Assistant Inputs / Sensors
<table>
<thead>
<tr><th>Constant</th><th>Supported units</th><th>Description</th></tr></thead>
<tbody>
<tr><td>ABSOLUTE_HUMIDITY</td><td>g/m³, mg/m³</td><td>Absolute humidity</td></tr>
<tr><td>APPARENT_POWER</td><td>mVA, VA, kVA</td><td>Apparent power</td></tr>
<tr><td>AQI</td><td>None</td><td>Air Quality Index</td></tr>
<tr><td>AREA</td><td>m², cm², km², mm², in², ft², yd², mi², ac, ha</td><td>Area</td></tr>
<tr><td>ATMOSPHERIC_PRESSURE</td><td>cbar, bar, hPa, mmHG, inHg, inH₂O, kPa, mbar, Pa, psi</td><td>Atmospheric pressure</td></tr>
<tr><td>BATTERY</td><td>%</td><td>Percentage of battery that is left</td></tr>
<tr><td>BLOOD_GLUCOSE_CONCENTRATION</td><td>mg/dL, mmol/L</td><td>Blood glucose concentration</td></tr>
<tr><td>CO2</td><td>ppm</td><td>Concentration of carbon dioxide.</td></tr>
<tr><td>CO</td><td>ppm</td><td>Concentration of carbon monoxide.</td></tr>
<tr><td>CONDUCTIVITY</td><td>S/cm, mS/cm, µS/cm</td><td>Conductivity</td></tr>
<tr><td>CURRENT</td><td>A, mA</td><td>Current</td></tr>
<tr><td>DATA_RATE</td><td>bit/s, kbit/s, Mbit/s, Gbit/s, B/s, kB/s, MB/s, GB/s, KiB/s, MiB/s, GiB/s</td><td>Data rate</td></tr>
<tr><td>DATA_SIZE</td><td>bit, kbit, Mbit, Gbit, B, kB, MB, GB, TB, PB, EB, ZB, YB, KiB, MiB, GiB, TiB, PiB, EiB, ZiB, YiB</td><td>Data size</td></tr>
<tr><td>DATE</td><td></td><td>Date. Requires native_value to be a Python datetime.date object, or None.</td></tr>
<tr><td>DISTANCE</td><td>km, m, cm, mm, mi, nmi, yd, in</td><td>Generic distance</td></tr>
<tr><td>DURATION</td><td>d, h, min, s, ms, µs</td><td>Time period. Should not update only due to time passing. The device or service needs to give a new data point to update.</td></tr>
<tr><td>ENERGY</td><td>J, kJ, MJ, GJ, mWh, Wh, kWh, MWh, GWh, TWh, cal, kcal, Mcal, Gcal</td><td>Energy, this device class should be used for sensors representing energy consumption, for example an electricity meter. Represents <em>power</em> over <em>time</em>. Not to be confused with power.</td></tr>
<tr><td>ENERGY_DISTANCE</td><td>kWh/100km, Wh/km, mi/kWh, km/kWh</td><td>Energy per distance, this device class should be used to represent energy consumption by distance, for example the amount of electric energy consumed by an electric car.</td></tr>
<tr><td>ENERGY_STORAGE</td><td>J, kJ, MJ, GJ, mWh, Wh, kWh, MWh, GWh, TWh, cal, kcal, Mcal, Gcal</td><td>Stored energy, this device class should be used for sensors representing stored energy, for example the amount of electric energy currently stored in a battery or the capacity of a battery. Represents <em>power</em> over <em>time</em>. Not to be confused with power.</td></tr>
<tr><td>ENUM</td><td></td><td>The sensor has a limited set of (non-numeric) states. The options property must be set to a list of possible states when using this device class.</td></tr>
<tr><td>FREQUENCY</td><td>Hz, kHz, MHz, GHz</td><td>Frequency</td></tr>
<tr><td>GAS</td><td>L, m³, ft³, CCF, MCF</td><td>Volume of gas. Gas consumption measured as energy in kWh instead of a volume should be classified as energy.</td></tr>
<tr><td>HUMIDITY</td><td>%</td><td>Relative humidity</td></tr>
<tr><td>ILLUMINANCE</td><td>lx</td><td>Light level</td></tr>
<tr><td>IRRADIANCE</td><td>W/m², BTU/(h⋅ft²)</td><td>Irradiance</td></tr>
<tr><td>MOISTURE</td><td>%</td><td>Moisture</td></tr>
<tr><td>MONETARY</td><td><a href="https://en.wikipedia.org/wiki/ISO_4217#Active_codes" target="_blank" rel="noopener noreferrer">ISO 4217</a></td><td>Monetary value with a currency.</td></tr>
<tr><td>NITROGEN_DIOXIDE</td><td>µg/m³</td><td>Concentration of nitrogen dioxide</td></tr>
<tr><td>NITROGEN_MONOXIDE</td><td>µg/m³</td><td>Concentration of nitrogen monoxide</td></tr>
<tr><td>NITROUS_OXIDE</td><td>µg/m³</td><td>Concentration of nitrous oxide</td></tr>
<tr><td>OZONE</td><td>µg/m³</td><td>Concentration of ozone</td></tr>
<tr><td>PH</td><td>None</td><td>Potential hydrogen (pH) of an aqueous solution</td></tr>
<tr><td>PM1</td><td>µg/m³</td><td>Concentration of particulate matter less than 1 micrometer</td></tr>
<tr><td>PM25</td><td>µg/m³</td><td>Concentration of particulate matter less than 2.5 micrometers</td></tr>
<tr><td>PM4</td><td>µg/m³</td><td>Concentration of particulate matter less than 4 micrometers</td></tr>
<tr><td>PM10</td><td>µg/m³</td><td>Concentration of particulate matter less than 10 micrometers</td></tr>
<tr><td>POWER</td><td>mW, W, kW, MW, GW, TW</td><td>Power.</td></tr>
<tr><td>POWER_FACTOR</td><td>%, None</td><td>Power Factor</td></tr>
<tr><td>PRECIPITATION</td><td>cm, in, mm</td><td>Accumulated precipitation</td></tr>
<tr><td>PRECIPITATION_INTENSITY</td><td>in/d, in/h, mm/d, mm/h</td><td>Precipitation intensity</td></tr>
<tr><td>PRESSURE</td><td>cbar, bar, hPa, mmHg, inHg, kPa, mbar, Pa, psi</td><td>Pressure.</td></tr>
<tr><td>REACTIVE_ENERGY</td><td>varh, kvarh</td><td>Reactive energy</td></tr>
<tr><td>REACTIVE_POWER</td><td>mvar, var, kvar</td><td>Reactive power</td></tr>
<tr><td>SIGNAL_STRENGTH</td><td>dB, dBm</td><td>Signal strength</td></tr>
<tr><td>SOUND_PRESSURE</td><td>dB, dBA</td><td>Sound pressure</td></tr>
<tr><td>SPEED</td><td>ft/s, in/d, in/h, in/s, km/h, kn, m/s, mph, mm/d, mm/s</td><td>Generic speed</td></tr>
<tr><td>SULPHUR_DIOXIDE</td><td>µg/m³</td><td>Concentration of sulphure dioxide</td></tr>
<tr><td>TEMPERATURE</td><td>°C, °F, K</td><td>Temperature.</td></tr>
<tr><td>TIMESTAMP</td><td></td><td>Timestamp. Requires native_value to return a Python datetime.datetime object, with time zone information, or None.</td></tr>
<tr><td>VOLATILE_ORGANIC_COMPOUNDS</td><td>µg/m³, mg/m³</td><td>Concentration of volatile organic compounds</td></tr>
<tr><td>VOLATILE_ORGANIC_COMPOUNDS_PARTS</td><td>ppm, ppb</td><td>Ratio of volatile organic compounds</td></tr>
<tr><td>VOLTAGE</td><td>V, mV, µV, kV, MV</td><td>Voltage</td></tr>
<tr><td>VOLUME</td><td>L, mL, gal, fl. oz., m³, ft³, CCF, MCF</td><td>Generic volume, this device class should be used for sensors representing a consumption, for example the amount of fuel consumed by a vehicle.</td></tr>
<tr><td>VOLUME_FLOW_RATE</td><td>m³/h, m³/min, m³/s, ft³/min, L/h, L/min, L/s, gal/min, mL/s</td><td>Volume flow rate, this device class should be used for sensors representing a flow of some volume, for example the amount of water consumed momentarily.</td></tr>
<tr><td>VOLUME_STORAGE</td><td>L, mL, gal, fl. oz., m³, ft³, CCF, MCF</td><td>Generic stored volume, this device class should be used for sensors representing a stored volume, for example the amount of fuel in a fuel tank.</td></tr>
<tr><td>WATER</td><td>L, gal, m³, ft³, CCF, MCF</td><td>Water consumption</td></tr>
<tr><td>WEIGHT</td><td>kg, g, mg, µg, oz, lb, st</td><td>Generic mass; weight is used instead of mass to fit with every day language.</td></tr>
<tr><td>WIND_DIRECTION</td><td>°</td><td>Wind direction, should be set to None if the wind speed is 0 or too low to accurately measure the wind direction.</td></tr>
<tr><td>WIND_SPEED</td><td>ft/s, km/h, kn, m/s, mph</td><td>Wind speed</td></tr></tbody></table>
