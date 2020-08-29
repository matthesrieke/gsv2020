FROM continuumio/miniconda3

ADD ./environment.yml /tmp/environment.yml
RUN conda env create -f /tmp/environment.yml

ENV PATH /opt/conda/envs/geopandas/bin:$PATH
RUN echo "source activate geopandas" > /etc/profile

ADD ./geojson_buffer.ipynb /nb.ipynb

ENV INPUT_INPUT '/input.geojson'
ENV OUTPUT_BUFFERED_OUTPUT '/output.geojson'
ENV INPUT_BUFFER_RADIUS_METERS 1000

CMD env && papermill /nb.ipynb /out.ipynb -p filename $INPUT_INPUT -p outputFilename $OUTPUT_BUFFERED_OUTPUT -p bufferRadiusMeters $INPUT_BUFFER_RADIUS_METERS
