# DASPAS — Gestión de afiliados

Sistema web multiusuario para DASPAS Broker de Seguros.

## Flujo

Login → Panel principal → Clientes → Importar Excel → Ficha del afiliado → Documentación adjunta → Historial → Base de datos central.

## Funciones

- Autenticación con sesiones JWT en cookie HttpOnly.
- Roles `admin` y `operador`.
- PostgreSQL como base central.
- Alta, edición, búsqueda y eliminación de afiliados.
- Importación `.xlsx`, `.xls` y `.csv` con actualización por Nro. de Afiliado.
- Documentación adjunta con almacenamiento central.
- Historial de acciones por afiliado.
- Dashboard con métricas.
- Interfaz responsive con identidad DASPAS.

## Ejecutar con Docker

```bash
docker compose up -d --build
```

Luego crear las tablas:

```bash
docker compose exec -T db psql -U postgres -d daspas < schema.sql
```

Crear administrador (cambiar credenciales antes de producción):

```bash
docker compose exec app sh -lc 'ADMIN_EMAIL=admin@daspas.com ADMIN_PASSWORD="Cambiar123!" node seed.js'
```

Abrir `http://localhost:3000`.

## Producción

Cambiar `JWT_SECRET`, contraseña de PostgreSQL y credenciales del administrador. Para producción se recomienda HTTPS, backups de PostgreSQL, almacenamiento de documentos con backup y restricciones de tamaño/tipos de archivos.
