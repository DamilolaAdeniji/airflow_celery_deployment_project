FROM apache/airflow:2.10.5-python3.10

ENV AIRFLOW_HOME=/opt/airflow

WORKDIR $AIRFLOW_HOME

COPY ./requirements.txt ./requirements.txt

RUN pip install --no-cache-dir -r requirements.txt

COPY ./dags ./dags
