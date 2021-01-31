## Docker instructions

As per the information later in this file, you will need a username from
Geonames (http://www.geonames.org/) in order to use their API. Do not proceed
until you have a username available.

To build the Docker image, use something like:

```
docker build -t geonames-reconcile .
```

To run a container on port 8887, for example, overriding the default port 5000, do something 
like this (note the `-e` parameter used to pass the Geonames username):

``` 
docker run --name geonames -p 8877:5000 -e GEONAMES_USERNAME=<username> geonames-reconcile
```

## About

An OpenRefine reconciliation service for [GeoNames](http://www.geonames.org/).

The service queries the [GeoNames API](http://www.geonames.org/export/web-services.html)
and provides normalized scores across queries for reconciling in Refine.

## Provenance

Michael Stephens wrote a [demo reconcilliation service](https://github.com/mikejs/reconcile-demo) and Ted Lawless wrote a [FAST reconciliation service](https://github.com/lawlesst/fast-reconcile) that this code basically repeats but for a different API.

Further adapted from Christina Harlow's [work](https://github.com/cmharlow/geonames-reconcile).

Please give any thanks for this work to Ted Lawless and Christina Harlow. Also give thanks to Trevor Muñoz for some cleanups to make this code easier to work with.

## Instructions

1. Start up OpenRefine (however you normally go about it).
2. Open a project in OpenRefine.
3. On the column you would like to reconcile with GeoNames, click on the arrow at the top, choose 'Reconcile' > 'Start Reconciling...'
4. Click on the 'Add Standard Service' button in the bottom left corner.
5. Enter: http://geonames.oceanmeat.tech
6. Click Add Service.
7. You should now be greeted by a list of possible reconciliation types for the GeoNames Reconciliation Service. They should be fairly straight-forward to understand, and use /geonames/all if you need the broadest search capabilities possible.
8. Click 'Start Reconciling' in the bottom right corner.
9. Once finished, you should see the closest options that the GeoNames API found for each cell. You can click on the options and be taken to the GeoNames site for that entry. Once you find the appropriate reconciliation choice, click the single arrow box beside it to use that choice just for the one cell, or the double arrows box to use that choice for all other cells containing that text.
10. Once you've got your reconciliation choices done or rejected, you then need to store the GeoNames name, id, and coordinates (or any subset of those that you want to keep in the data) in your OpenRefine project. This is important: **Although it appears that you have retrieved your reconciled data into your OpenRefine project, OpenRefine is actually storing the original data still. You need to explicit save the reconciled data in order to make sure it appears/exists when you export your data. Annoying as mosquito in your bedroom, I know, but please learn from my own mistakes, sweat and confusion.**
11.  So, depending on whether or not you wish to keep the original data, you can replace the column with the reconciled data or add a column that contains the reconciled data. I'll do the latter here. On the reconciled data column, click the arrow at the top, then Choose 'Edit Columns' > 'Add a new column based on this column'
12. In the GREL box that appears, put the following depending on what you want to pull:
  - Name and Coordinates: `cell.recon.match.name` (will pull the GeoNames Name plus coordinates, separated by a | - you can split that column later to have just name then coordinates)
	- URI: `cell.recon.match.id` (will pull the GeoNames URI/link)
	- Coordinates Only: `replace(substring(cell.recon.match.name, indexOf(cell.recon.match.name, ' | ')), ' | ', '')`
	- Name, Coordinates, and URI each separated by | (for easier column splitting later): `cell.recon.match.name + " | " + cell.recon.match.id`
