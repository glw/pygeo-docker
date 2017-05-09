# Use phusion/baseimage as base image. To make your builds reproducible, make
# sure you lock down to a specific version, not to `latest`!
# See https://github.com/phusion/baseimage-docker/blob/master/Changelog.md for
# a list of version numbers.
FROM phusion/baseimage:0.9.21

USER root

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

RUN add-apt-repository -y ppa:ubuntugis/ubuntugis-unstable
RUN apt-get update && apt-get install -y \
git \
nano \
python3-dev \
gdal-bin \
libgdal-dev \
python3-gdal \
rio \
fio

RUN curl -O https://bootstrap.pypa.io/get-pip.py && \
    python3 get-pip.py && \
    rm get-pip.py

RUN pip --no-cache-dir install \
	gdal2mbtiles \
        jupyter \
        matplotlib \
        numpy \
        scipy \
        sklearn \
        pandas \
        Pillow \
	descartes \
	Fiona \
	geopandas \
	osmnx \
	pykml \
	pyshp \
	rasterio \
	shapely \
	pysal \
	Cartopy \
	geojsonio \
	scrapy \
	urllib \
	beautifulsoup \
        && \

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY jupyter_notebook_config.py /root/.jupyter/
COPY run_jupyter.sh /

# jupyter
EXPOSE 8888

CMD ["/run_jupyter.sh", "--allow-root"]

# Externally accessible data is by default put in /data
WORKDIR /data
VOLUME ["/data"]

CMD ["/bin/bash"]