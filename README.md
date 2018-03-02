# JOB-SETUP_TM721

This is a tool for setting up routine quantum chemistry calculations for [Turbomole, version 7.2.1](http://www.cosmologic-services.de/downloads/TM72-documentation/index.html). It is specifically for the current version (7.2.1); however, it can easily be altered to work with future versions (see [below](#Future-proofing)). It also includes some of the template files I have created.

It is designed for use when you've already got a general idea of what kind of calculation will work, but are looking at, for example, a new molecule or trying a different exchange-correlation functional.

You will create template files that can be read in to [`define`](http://www.cosmologic-services.de/downloads/TM72-documentation/DOKch4.html#x17-380004), [`cosmoprep`](http://www.cosmologic-services.de/downloads/TM72-documentation/DOKse70.html#x113-34000017.2) or that utilise the in-built tool [`adg`](http://www.cosmologic-services.de/downloads/TM72-documentation/DOKse5.html#x10-90001.5) to alter the control file.

This is in no way associated with Turbomole GmbH.

## Requirements
- This probably only works on `*nix`-like systems.
- You must have installed `Turbomole 7.2.1`.
- Set `TURBODIR` and `PARA_ARCH`. Check [Section 2.1.1](http://www.cosmologic-services.de/downloads/TM72-documentation/DOKse6.html#x12-110002.1) of the documentation for more details.
- Run `Config_turbo_env` or `Config_turbo_env.tcsh`.

## Installation
1) Download this repository as you normally would.
2) Set an environment variable `JSTM721` to the path to the main `JOB-SETUP_TM721` directory.
3) ????
4) Profit!

## How to
The tools are split into four parts:
1) Scripts for setting up specific types of jobs, found in `$JOB-SETUP_TM721/scripts`
2) Template files for `define`, found in `$JOB-SETUP_TM721/define`
3) Template files for `cosmoprep`, found in `$JOB-SETUP_TM721/cosmoprep`
4) Scripts containing one or more `control` file alterations, which utilise `adg` and are found in `$JOB-SETUP_TM721/adg`

Counter-intuitively, it's easiest to start with the second of these.

### define
In this directory you need to create templates that will be read into the [`define`](http://www.cosmologic-services.de/downloads/TM72-documentation/DOKch4.html#x17-380004) program. These are text files that are intended to replicate the inputs one would enter in an interactive session of `define`. The simplest way to go about creating one of these is to create a job from scratch and document everything you enter into the program. You can then save the file in `$JOB-SETUP_TM721/define`. It helps to make the name descriptive.

### adg
The in-built tool, [`adg`](http://www.cosmologic-services.de/downloads/TM72-documentation/DOKse5.html#x10-90001.5), is for altering a `control` file to add in any extra things you couldn't do with `define`. The scripts in `$JOB-SETUP_TM721/adg` are essentially bash scripts which run `adg` one or more times to add the relevant keywords to the `control` file. There is a [list of keywords](http://www.cosmologic-services.de/downloads/TM72-documentation/DOKse82.html) in the documentation.

### cosmoprep
In this directory you will need to create templates that will be read into the [`cosmoprep`](http://www.cosmologic-services.de/downloads/TM72-documentation/DOKse70.html#x113-34000017.2) program. These are very simple and for most cases all you will need to do is look up the dielectric constant and refractive index for your solvent. There is a helpful database [here](http://www.stenutz.eu/chem/solv23.php?s=1&p=0).

### scripts
The scripts in this directory combine the above templates in order to create a ready-to-submit Turbomole job. [Use the template](scripts/template.JS-TM721.sh) as a basis, and make sure that your `adg` scripts are listed as a [bash array](http://tldp.org/LDP/Bash-Beginners-Guide/html/sect_10_02.html). You may want to consider including this directory in your `PATH` for easy access.


## Future-proofing
The main concern for future-proofing is that it is possible (though unlikely given their history of trying not to do so), that the Turbomole development team will alter the functionality of either `define`, `cosmoprep` or the `control` file keywords (a.k.a. datagroups) and therefore stop existing templates from working. This will basically mean your old templates won't work, so you may need to create a new version of this repository and delete the old templates.
s
