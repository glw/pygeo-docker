FROM ubuntu:16.04

#need to install software properties on this version of ubuntu to run add-apt-repository
RUN apt-get update && apt-get install -y software-properties-common python-software-properties
RUN add-apt-repository -y ppa:ubuntugis/ubuntugis-unstable
RUN apt-get install -y \
	curl \
	python3 \
	python3-dev \
	gdal-bin \
	libgdal-dev \
	python3-gdal \
	rasterio \
	fiona \
	libspatialindex-c4v5 \ 
	# libspatialindex-c4v5 fixes error when importing geopandas
	python3-tk \ 
	#python3-tk osmnx dependency
	&& \

	curl -O https://bootstrap.pypa.io/get-pip.py && \
	python3 get-pip.py && \
	rm get-pip.py \
	&& \

	pip --no-cache-dir install \
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
	geojsonio \
	scrapy \
	geopy \
	beautifulsoup4

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY jupyter_notebook_config.py /root/.jupyter/
COPY run_jupyter.sh /

ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

# jupyter
EXPOSE 8888

CMD ["/run_jupyter.sh", "--allow-root"]

# Externally accessible data is by default put in /data
WORKDIR /data

CMD ["/bin/bash"]