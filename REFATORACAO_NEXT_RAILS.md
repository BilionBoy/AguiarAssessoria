# Refatoração Aguiar Assessoria: Next + Rails API

## Estrutura criada
- `aguiar-api/`: nova API Rails 7.2 (API-only)
- `aguiar-front/`: novo frontend Next.js

## O que já foi migrado
- Domínio de dados do sistema atual (models e migrations) copiado para `aguiar-api`
- Endpoints REST versionados em `api/v1`
- Autenticação JWT (`login`, `refresh`, `me`)
- Paginação com Pagy
- Filtros com Ransack
- Estrutura de services para CRUD e auth
- Front com login e listagem de clientes consumindo a API

## Próximas fases recomendadas
1. Revisar regras de negócio específicas por entidade e mover para services dedicados.
2. Adicionar serializers por recurso para padronizar payloads finos.
3. Criar testes de request em `aguiar-api` para os endpoints principais.
4. Migrar telas restantes do monólito para páginas Next (contratos, metas, cadastros gerais).
5. Configurar CI/CD separado para `aguiar-api` e `aguiar-front`.

## Rotas úteis
- API: `http://localhost:3000/api/v1/...`
- Front: `http://localhost:3001`
