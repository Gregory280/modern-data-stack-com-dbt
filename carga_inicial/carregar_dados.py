from google.cloud import bigquery
from google.api_core.exceptions import NotFound
import os

os.environ["GOOGLE_APPLICATION_CREDENTIALS"] = "../chave/minha-loja-513715-93a43a5c2f78.json"
projeto_id = "minha-loja-513715"
dataset_id = "raw"

dados_carga = "dados"
arquivos = {
    "clientes": os.path.join(dados_carga, "clientes.jsonl"),
    "pedidos": os.path.join(dados_carga, "pedidos.jsonl"),
    "produtos": os.path.join(dados_carga, "produtos.jsonl"),
    "itens_pedido": os.path.join(dados_carga, "itens_pedido.jsonl"),
}
client = bigquery.Client(project=projeto_id)

def criar_dataset(dataset_id):
  
  dataset_ref = f"{projeto_id}.{dataset_id}"
  dataset = bigquery.Dataset(dataset_ref)
  dataset.location = "US"

  try:
    client.get_dataset(dataset_ref)
    print(f"Dataset {dataset_id} já existe.")
  except NotFound:
    dataset = client.create_dataset(dataset)
    print(f"Dataset {dataset_id} criado com sucesso.")


def carregar_dados(table_name, file_path):
  table_id = f"{projeto_id}.{dataset_id}.{table_name}"
  job_config = bigquery.LoadJobConfig(
    source_format=bigquery.SourceFormat.NEWLINE_DELIMITED_JSON,
    autodetect=True
  )
  with open(file_path, "rb") as file:
    load_job = client.load_table_from_file(file, table_id, job_config=job_config)
    load_job.result()
    print(f"Tabela criada com sucesso: {table_id}.")


criar_dataset(dataset_id)
for table_name, file_path in arquivos.items():
  carregar_dados(table_name, file_path)