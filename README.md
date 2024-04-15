
# Prueba Técnica Earthquake

El objetivo de esta prueba técnica es crear un tarea que permita persitir esos datos y luego poder obtenerlos por parametros y asignarles comentarios.



## Configuración

Instala las gemas necesarias.

```bash
  bundle install
```
Inicia el servidor..

```bash
  rails server
```
Ejecutar el archivo index del frontend en un navegador.
## API de referencia

#### Get all features

```http
  GET http://127.0.0.1:3000/api/features?page=1&per_page=2%27
```

| Parameter | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `page`    | `integer` | **Required**.|
| `per_page`| `integer` | **Required**.|

#### Get features

```http
  GET http://127.0.0.1:3000/api/features?page=1&per_page=2&mag_type[]=md
```

| Parameter | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `page`    | `integer` | **Required**.|
| `per_page`| `integer` | **Required**.|
| `mag_type`| `string` | **Required**.|


#### Post comments features

```http
  POST http://127.0.0.1:3000/api/features/1/comments
```

| Parameter | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `body`    | `string` | **Required**.|



