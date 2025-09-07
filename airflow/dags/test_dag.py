# dags/three_python_sleeps.py
from __future__ import annotations
import time
import pendulum
from airflow import DAG
from airflow.operators.python import PythonOperator

def sleep_for(seconds: int = 15, label: str = ""):
    print(f"Starting {label}…")
    time.sleep(seconds)
    print(f"Finished {label}.")
    return seconds

with DAG(
    dag_id="three_python_sleep_tasks",
    start_date=pendulum.datetime(2025, 8, 1, tz="UTC"),
    schedule=None,   # run manually
    catchup=False,
    tags=["example"],
) as dag:
    sleep_1 = PythonOperator(
        task_id="sleep_1",
        python_callable=sleep_for,
        op_kwargs={"seconds": 15, "label": "sleep_1"},
    )
    sleep_2 = PythonOperator(
        task_id="sleep_2",
        python_callable=sleep_for,
        op_kwargs={"seconds": 15, "label": "sleep_2"},
    )
    sleep_3 = PythonOperator(
        task_id="sleep_3",
        python_callable=sleep_for,
        op_kwargs={"seconds": 15, "label": "sleep_3"},
    )

    sleep_1 >> sleep_2 >> sleep_3
