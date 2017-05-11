# pygeo-docker
docker image for geospatial in python


to run jupyter notebook in your host environment:
docker run -it -p 8888:8888 -v /$(pwd)/:/data garretw/pygeo:0.1 jupyter notebook --ip 0.0.0.0 --no-browser --allow-root

Use '!' to use commandline tools like fiona, rasterio, gdal, or ogr
    !fiona cat shapefile-name.shp
